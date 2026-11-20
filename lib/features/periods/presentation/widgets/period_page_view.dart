import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';

/// One page per period, newest first: swiping right goes back in time,
/// like a photo gallery. It opens on [initialIndex]; give it a new key to
/// open there again, such as when the period type changes.
class PeriodPageView extends StatefulWidget {
  const new({
    required this.periods,
    required this.initialIndex,
    required this.itemBuilder,
    this.onPageChanged,
    super.key,
  });

  final List<Period> periods;
  final int initialIndex;
  final Widget Function(BuildContext context, Period period) itemBuilder;
  final ValueChanged<Period>? onPageChanged;

  @override
  State<PeriodPageView> createState() => _PeriodPageViewState();
}

class _PeriodPageViewState extends State<PeriodPageView> {
  late final PageController _controller = PageController(
    initialPage: widget.initialIndex,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final periods = widget.periods;
    final onPageChanged = widget.onPageChanged;
    return PageView.builder(
      controller: _controller,
      reverse: true,
      itemCount: periods.length,
      onPageChanged: onPageChanged == null
          ? null
          : (index) => onPageChanged(periods[index]),
      itemBuilder: (context, index) =>
          widget.itemBuilder(context, periods[index]),
    );
  }
}
