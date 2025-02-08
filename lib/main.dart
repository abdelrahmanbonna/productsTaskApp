import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'Core/Config/app.dart';
import 'Core/Helpers/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  // Initialize dependencies
  DependencyInjection.init();
  
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}
