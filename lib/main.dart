import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/app/app.dart';
import 'package:mobilewright_demo_app/core/di/injection.dart';

void main() {
  configureDependencies();
  runApp(const App());
}
