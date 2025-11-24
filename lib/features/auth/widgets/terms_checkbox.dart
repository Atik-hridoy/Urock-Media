import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_scale.dart';

/// Terms and conditions checkbox widget
class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final bool isLargeScreen = ResponsiveScale.isDesktop || ResponsiveScale.isTV;

    double? maxWidth;
    if (isLargeScreen) {
      final double minWidth = 320;
      final double maxAllowed = ResponsiveScale.isTV ? 720 : 520;
      final double targetWidth = ResponsiveScale.screenWidth *
          (ResponsiveScale.isTV ? 0.32 : 0.4);
      maxWidth = targetWidth.clamp(minWidth, maxAllowed).toDouble();
    }

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: (val) => onChanged(val ?? false),
            side: BorderSide(color: Colors.white.withOpacity(0.3)),
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.goldDark;
              }
              return Colors.transparent;
            }),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(
                'I agree to the ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Open terms and conditions
                },
                child: const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    color: AppColors.goldLight,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                ' & ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Open privacy policy
                },
                child: const Text(
                  'Privacy policy',
                  style: TextStyle(
                    color: AppColors.goldLight,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (maxWidth != null) {
      return Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: content,
        ),
      );
    }

    return content;
  }
}
