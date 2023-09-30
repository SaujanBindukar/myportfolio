import 'package:flutter/material.dart';

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
            fontWeight: FontWeight.w700,
          ),
      textAlign: TextAlign.center,
    );
  }
}
