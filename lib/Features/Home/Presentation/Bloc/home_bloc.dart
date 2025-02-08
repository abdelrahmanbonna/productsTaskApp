import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Features/Home/Presentation/Bloc/home.events.dart';
import 'package:task_app/Features/Home/Presentation/Bloc/home_states.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc(this._productsRepository) : super(HomeInitialState()) {
    on<GetProductsHomeEvent>(_getProducts);
  }
  final ProductsRepository _productsRepository;

  Future<void> _getProducts(
      GetProductsHomeEvent event, Emitter<HomeStates> emit) async {
    emit(LoadingState());
    final result = await _productsRepository.getProducts(event.forceUpdate);
    result.fold(
      (failure) => emit(ErrorState(fail: failure)),
      (products) => emit(ProductsSuccessState(products: products)),
    );
  }
}
