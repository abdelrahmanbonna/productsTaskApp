import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_events.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_states.dart';
import 'package:task_app/Features/Products/Data/Models/category_enum.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';
import 'package:task_app/Features/Products/Data/Models/rating_model.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';

class DetailsBloc extends Bloc<DetailsEvents, DetailsStates> {
  DetailsBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(DetailsInitial()) {
    on<SaveToFavoriteProductsEvent>(_onSaveToFavoriteProductsEvent);
    on<RemoveFromFavoriteProductsEvent>(_onRemoveFromFavoriteProductsEvent);
    on<GetFavoriteStatusEvent>(_onGetFavoriteStatusEvent);
  }

  final ProductsRepository _productsRepository;

  Future<void> _onSaveToFavoriteProductsEvent(
      SaveToFavoriteProductsEvent event, Emitter<DetailsStates> emit) async {
    emit(LoadingState());
    await _productsRepository.addFavoriteProduct(event.product).then((value) {
      if (value) {
        emit(ProductSavedToFavorite());
      } else {
        emit(DetailsInitial());
      }
    });
  }

  Future<void> _onRemoveFromFavoriteProductsEvent(
      RemoveFromFavoriteProductsEvent event,
      Emitter<DetailsStates> emit) async {
    emit(LoadingState());
    await _productsRepository
        .removeFavoriteProduct(event.product)
        .then((value) {
      if (value) {
        emit(ProductRemovedFromFavorite());
      } else {
        emit(DetailsInitial());
      }
    });
  }

  Future<void> _onGetFavoriteStatusEvent(
      GetFavoriteStatusEvent event, Emitter<DetailsStates> emit) async {
    emit(LoadingState());
    await _productsRepository.getFavoriteProducts().then((value) {
      final temp = Product(
          id: 0,
          title: '',
          price: 0,
          description: '',
          category: Category.womensClothing,
          image: '',
          rating: Rating(rate: 0, count: 0),
          isFavorite: false);

      final product = value.firstWhere(
        (p) => p.id == event.product.id,
        orElse: () => temp,
      );

      if (product != temp) {
        emit(GetFavoriteStatusState(true));
      } else {
        emit(GetFavoriteStatusState(false));
      }
    });
  }
}
