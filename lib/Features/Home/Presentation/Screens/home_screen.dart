import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task_app/Core/Config/route_names.dart';
import 'package:task_app/Features/Home/Presentation/Bloc/home.events.dart';
import 'package:task_app/Features/Home/Presentation/Bloc/home_bloc.dart';
import 'package:task_app/Features/Home/Presentation/Bloc/home_states.dart';
import 'package:task_app/Features/Home/Presentation/Widgets/product_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = Get.find<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _homeBloc.add(GetProductsHomeEvent(forceUpdate: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              onPressed: () {
                _homeBloc.add(GetProductsHomeEvent(forceUpdate: true));
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                //todo: implement favorite
              },
              icon: const Icon(Icons.favorite),
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeStates>(
          builder: (context, state) {
            if (state is ProductsSuccessState) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.products.length,
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
                itemBuilder: (context, index) {
                  return FadeIn(
                    duration: const Duration(milliseconds: 400),
                    delay: Duration(milliseconds: 200 + 100 * index),
                    curve: Curves.easeInCubic,
                    child: ProductCardWidget(
                      imageUrl: state.products[index].image,
                      title: state.products[index].title,
                      price: state.products[index].price.toString(),
                      rating: state.products[index].rating,
                      onTap: () {
                        Get.toNamed(RouteNames.details,
                            arguments: state.products[index]);
                      },
                    ),
                  );
                },
              );
            }
            if (state is ErrorState) {
              return Center(
                child: Text(state.failure?.message ?? "Something went wrong"),
              );
            }
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dangerous,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text('No products found'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
