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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsStates>(
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
                    imageUrl: widget.product.image,
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
                        widget.product.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          RatingBar.readOnly(
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            initialRating: widget.product.rating.rate,
                            maxRating: 5,
                            size: 22,
                          ),
                          Text(
                            '(${widget.product.rating.count})',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.category.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          IconButton(
                            onPressed: () {
                              if (widget.product.isFavorite) {
                                _detailsBloc
                                    .add(RemoveFromFavoriteProductsEvent(
                                  product: widget.product,
                                ));
                                widget.product.isFavorite = false;
                              } else {
                                _detailsBloc.add(SaveToFavoriteProductsEvent(
                                  product: widget.product,
                                ));
                                widget.product.isFavorite = true;
                              }
                            },
                            icon: Icon(
                              widget.product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${widget.product.price} \$',
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
                        widget.product.description,
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
