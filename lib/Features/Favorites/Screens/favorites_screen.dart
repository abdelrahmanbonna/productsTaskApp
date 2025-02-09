import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task_app/Core/Config/route_names.dart';
import 'package:task_app/Features/Favorites/Blocs/favorites_bloc.dart';
import 'package:task_app/Features/Favorites/Blocs/favorites_events.dart';
import 'package:task_app/Features/Favorites/Blocs/favorites_states.dart';
import 'package:task_app/Features/Home/Presentation/Widgets/product_card_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesBloc _favoritesBloc = Get.find<FavoritesBloc>();

  @override
  void initState() {
    super.initState();
    _favoritesBloc.add(GetFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            onPressed: () {
              _favoritesBloc.add(GetFavorites());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesStates>(
        builder: (context, state) {
          if (state is FavoritesSuccessState) {
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
                          arguments:
                              state.products[index].copyWith(isFavorite: true));
                    },
                  ),
                );
              },
            );
          }
          if (state is FavoritesErrorState) {
            return Center(
              child: Text(state.failure.message),
            );
          }

          // Loading state
          if (state is FavoritesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
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
    );
  }
}
