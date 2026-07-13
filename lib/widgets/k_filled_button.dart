import 'package:emvigo_machine_task/constants/app_colors.dart';
import 'package:flutter/material.dart';

class KFilledButton extends StatelessWidget {
  const KFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.borderRadius = 12,
    this.verticalPadding = 14,
  });

  final VoidCallback onPressed;
  final String text;
  final double width;
  final double borderRadius;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.green,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
