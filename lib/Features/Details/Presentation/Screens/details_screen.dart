import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_bloc.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_events.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_states.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final DetailsBloc _detailsBloc = Get.find<DetailsBloc>();
  late Product _product;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    _detailsBloc.add(GetFavoriteStatusEvent(widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsBloc, DetailsStates>(
      listener: (context, state) {
        if (state is GetFavoriteStatusState) {
          _product = _product.copyWith(isFavorite: state.isFavorite);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            title: Text(
              widget.product.title,
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: _product.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(66, 49, 49, 49),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: Offset(5, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _product.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          RatingBar.readOnly(
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            initialRating: _product.rating.rate,
                            maxRating: 5,
                            size: 22,
                          ),
                          Text(
                            '(${_product.rating.count})',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _product.category.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          IconButton(
                            onPressed: () {
                              if (_product.isFavorite) {
                                _detailsBloc
                                    .add(RemoveFromFavoriteProductsEvent(
                                  product: _product,
                                ));
                                _product = _product.copyWith(
                                  isFavorite: false,
                                );
                              } else {
                                _detailsBloc.add(SaveToFavoriteProductsEvent(
                                  product: _product,
                                ));
                                _product = _product.copyWith(
                                  isFavorite: true,
                                );
                              }
                            },
                            icon: Icon(
                              _product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${_product.price} \$',
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Theme.of(context).dividerColor,
                        height: 1,
                        thickness: 0.2,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _product.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
