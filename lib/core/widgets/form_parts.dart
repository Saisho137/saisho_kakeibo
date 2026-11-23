import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';

/// A value that cannot be edited, drawn like a disabled text field.
class ReadOnlyField extends StatelessWidget {
  const new({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(labelText: label, enabled: false),
      child: Text(value),
    );
  }
}

/// Drops the keyboard focus as soon as [child] is touched. A menu or dialog
/// opened from it would otherwise give the focus back to the last text
/// field when it closes, and the keyboard would pop up again.
class UnfocusOnPointer extends StatelessWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}

/// Title above a form control that has no label of its own.
class FormLabel extends StatelessWidget {
  const new(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(text, style: context.textTheme.labelLarge),
    );
  }
}

/// Small text under a form control: a hint, a warning or an error.
class FormNote extends StatelessWidget {
  const new(
    this.text, {
    this.isWarning = false,
    this.isError = false,
    super.key,
  });

  final String text;
  final bool isWarning;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final color = isError
        ? context.colors.error
        : isWarning
        ? context.colors.tertiary
        : context.colors.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Text(
        text,
        style: context.textTheme.bodySmall?.copyWith(color: color),
      ),
    );
  }
}
