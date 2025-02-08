import 'package:task_app/Core/Base/base_state.dart';
import 'package:task_app/Features/Splash/Presentation/Blocs/splash_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';
import 'package:task_app/Features/Splash/Presentation/Blocs/splash_states.dart';

class SplashBloc extends Bloc<SplashEvents, BaseState> {
  SplashBloc(this._productsRepository) : super(const InitialState()) {
    on<GetProductsEvent>(_getProducts);
  }
  final ProductsRepository _productsRepository;
  
  Future<void> _getProducts(GetProductsEvent event, Emitter<BaseState> emit) async {
    emit(const LoadingState());
    final result = await _productsRepository.getProducts();
    result.fold(
      (failure) => emit(ErrorState(failure: failure)),
      (products) => emit(ProductsSuccessState(products: products)),
    );
  }
}
