import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:task_app/Core/Config/route_names.dart';
import 'package:task_app/Features/Details/Presentation/Bindings/details_bindings.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_bloc.dart';
import 'package:task_app/Features/Details/Presentation/Screens/details_screen.dart';
import 'package:task_app/Features/Home/Presentation/Bindings/home_bindings.dart';
import 'package:task_app/Features/Home/Presentation/Bloc/home_bloc.dart';
import 'package:task_app/Features/Home/Presentation/Screens/home_screen.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';
import 'package:task_app/Features/Splash/Presentation/Bindings/splash_binding.dart';
import 'package:task_app/Features/Splash/Presentation/Blocs/splash_bloc.dart';
import 'package:task_app/Features/Splash/Presentation/Pages/splash_screen.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: RouteNames.splash,
      page: () => bloc.BlocProvider(
          child: const SplashScreen(),
          create: (context) => Get.find<SplashBloc>()),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.home,
      page: () => bloc.BlocProvider(
          child: const HomeScreen(),
          create: (context) => Get.find<HomeBloc>()),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.details,
      page: () => bloc.BlocProvider(
        create: (context) => Get.find<DetailsBloc>(),
        child: DetailsScreen(
          product: Get.arguments as Product,
        ),
      ),
      binding: DetailsBindings(),
      transition: Transition.fadeIn,
    ),
  ];

  static String get initialRoute => RouteNames.splash;
}
