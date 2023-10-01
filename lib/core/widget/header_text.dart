import 'package:flutter/material.dart';
import 'package:myportfolio/core/colors.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.onPrimaryColor,
          ),
      textAlign: TextAlign.center,
    );
  }
}

class SubHeaderText extends StatelessWidget {
  const SubHeaderText({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.onPrimaryColor,
          ),
      textAlign: TextAlign.center,
    );
  }
}
