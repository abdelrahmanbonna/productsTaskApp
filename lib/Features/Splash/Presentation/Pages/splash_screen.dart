import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task_app/Core/Base/base_state.dart';
import 'package:task_app/Core/Config/route_names.dart';
import 'package:task_app/Features/Splash/Presentation/Blocs/splash_bloc.dart';
import 'package:task_app/Features/Splash/Presentation/Blocs/splash_events.dart';
import 'package:task_app/Features/Splash/Presentation/Blocs/splash_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashBloc>().add(GetProductsEvent(forceUpdate: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<SplashBloc>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: BlocConsumer<SplashBloc, BaseState>(
          listener: (context, state) {
            if (state is ProductsSuccessState) {
              Get.offAllNamed(RouteNames.home);
            }
          },
          builder: (context, state) {
            if (state is ErrorState) {
              return Center(
                child: FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  delay: const Duration(milliseconds: 1000),
                  child: Text(state.failure?.message ?? "Something went wrong"),
                ),
              );
            }

            return Center(
              child: FadeIn(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 500),
                child: const CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
