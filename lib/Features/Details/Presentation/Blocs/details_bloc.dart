import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_events.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_states.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';

class DetailsBloc extends Bloc<DetailsEvents, DetailsStates> {
  DetailsBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(DetailsInitial()) {
    on<SaveToFavoriteProductsEvent>(_onSaveToFavoriteProductsEvent);
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
}
