import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  bool get isMobile {
    return MediaQuery.of(this).size.width < 800;
  }
}
