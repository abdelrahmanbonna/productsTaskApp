import 'package:bloc/bloc.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';

import 'favorites_events.dart';
import 'favorites_states.dart';

class FavoritesBloc extends Bloc<FavoritesEvents, FavoritesStates> {
  FavoritesBloc(this._productsRepository) : super(FavoritesInitialState()) {
    on<GetFavorites>(_getProducts);
  }
  final ProductsRepository _productsRepository;

  Future<void> _getProducts(
      GetFavorites event, Emitter<FavoritesStates> emit) async {
    emit(FavoritesLoadingState());
    final result = await _productsRepository.getFavoriteProducts();

    if (result.isNotEmpty) {
      emit(FavoritesSuccessState(products: result));
    }
  }
}
