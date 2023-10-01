import 'package:flutter/widgets.dart';

class SectionNavigator {
  SectionNavigator._();
  static void navigateToSections({required BuildContext context}) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
    );
  }
}
