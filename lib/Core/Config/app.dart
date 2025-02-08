import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:task_app/Core/Config/routes.dart';
import 'package:task_app/Core/Helpers/base_binding.dart';
import 'package:task_app/Core/Theme/app_theme.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sales App',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Follows system theme
      initialBinding: BaseBinding(),
      defaultTransition: Transition.fadeIn,
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.initialRoute,
    );
  }
}
