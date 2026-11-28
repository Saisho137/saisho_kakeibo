import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/balance_pill.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/history_view.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Opens the history: by day or, with [categoryType], by category of
/// that type.
typedef OpenHistory = void Function({MovementType? categoryType});

/// The Home's page with the Balance under it (RF-17). Tapping the Balance
/// or pulling it up slides it to the top with the history (RF-14) under
/// it, over the page; the same, or back, brings it down again. Whatever
/// goes below this panel, the entry buttons, stays in sight.
class HistoryPanel extends StatefulWidget {
  const new({
    required this.balance,
    required this.currency,
    required this.pageBuilder,
    super.key,
  });

  final Money balance;
  final Currency currency;

  /// The page under the history, which may open it (the totals do).
  final Widget Function(BuildContext context, OpenHistory open) pageBuilder;

  @override
  State<HistoryPanel> createState() => _HistoryPanelState();
}

class _HistoryPanelState extends State<HistoryPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  )..addStatusListener((_) => setState(() {}));

  /// Each opening starts a new history, with its view chosen afresh.
  int _openings = 0;
  MovementType? _categoryType;
  bool _byCategory = false;

  bool get _closed => _progress.isDismissed;

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  void _start({MovementType? categoryType}) => setState(() {
    _openings++;
    _categoryType = categoryType;
    _byCategory = categoryType != null;
  });

  void _open({MovementType? categoryType}) {
    _start(categoryType: categoryType);
    _progress.forward();
  }

  void _close() => _progress.reverse();

  /// How far the Balance travels, from the foot of the panel to its top,
  /// as last laid out.
  double _travel = 1;

  void _dragStarted(DragStartDetails _) {
    if (_closed) _start();
  }

  void _dragged(DragUpdateDetails details) =>
      _progress.value -= details.primaryDelta! / _travel;

  void _dragEnded(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final opens = velocity.abs() >= _flingVelocity
        ? velocity < 0
        : _progress.value >= 0.5;
    if (opens) {
      _progress.forward();
    } else {
      _progress.reverse();
    }
  }

  static const double _flingVelocity = 300;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final background = Theme.of(context).scaffoldBackgroundColor;
    final closed = _closed;
    return PopScope(
      canPop: closed,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _close();
      },
      child: ClipRect(
        child: CustomMultiChildLayout(
          delegate: _PanelLayout(
            _progress,
            onTravel: (travel) => _travel = max(1, travel),
          ),
          children: [
            LayoutId(
              id: _Slot.page,
              child: Offstage(
                offstage: _progress.isCompleted,
                child: widget.pageBuilder(context, _open),
              ),
            ),
            if (!closed)
              LayoutId(
                id: _Slot.history,
                child: Material(
                  color: background,
                  child: HistoryView(
                    key: ValueKey(_openings),
                    byCategory: _byCategory,
                    categoryType: _categoryType,
                  ),
                ),
              ),
            LayoutId(
              id: _Slot.bar,
              child: Material(
                color: background,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onVerticalDragStart: _dragStarted,
                  onVerticalDragUpdate: _dragged,
                  onVerticalDragEnd: _dragEnded,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: BalanceRow(
                      leading: const BalanceGrip(),
                      pill: BalancePill(
                        balance: widget.balance,
                        currency: widget.currency,
                        tooltip: closed
                            ? l10n.homeHistoryTooltip
                            : l10n.historyCloseTooltip,
                        onTap: closed ? _open : _close,
                      ),
                      // By day or by category, only with the history open.
                      trailing: closed
                          ? const BalanceGrip()
                          : IconButton(
                              tooltip: _byCategory
                                  ? l10n.historyByDay
                                  : l10n.historyByCategory,
                              icon: Icon(
                                _byCategory
                                    ? Icons.calendar_month_outlined
                                    : Icons.donut_small_outlined,
                                color: context.colors.primary,
                              ),
                              onPressed: () =>
                                  setState(() => _byCategory = !_byCategory),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _Slot { page, bar, history }

/// The page above the Balance, which rises over it with [progress] while
/// the history follows it from below.
class _PanelLayout extends MultiChildLayoutDelegate {
  new(this.progress, {required this.onTravel}) : super(relayout: progress);

  final Animation<double> progress;

  /// Reports how far the Balance travels.
  final ValueChanged<double> onTravel;

  @override
  void performLayout(Size size) {
    // As tall as it needs: its row centers in whatever height it gets.
    final bar = layoutChild(
      _Slot.bar,
      BoxConstraints.tightFor(width: size.width),
    );
    final below = Size(size.width, max(0, size.height - bar.height));
    onTravel(below.height);
    final top = below.height * (1 - progress.value);
    layoutChild(_Slot.page, BoxConstraints.tight(below));
    positionChild(_Slot.page, Offset.zero);
    positionChild(_Slot.bar, Offset(0, top));
    if (hasChild(_Slot.history)) {
      layoutChild(_Slot.history, BoxConstraints.tight(below));
      positionChild(_Slot.history, Offset(0, top + bar.height));
    }
  }

  @override
  bool shouldRelayout(_PanelLayout oldDelegate) =>
      oldDelegate.progress != progress;
}
