import 'package:task_app/Core/Base/base_state.dart';
import 'package:task_app/Core/Error/failures.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

abstract class FavoritesStates implements BaseState {}

class FavoritesInitialState implements FavoritesStates {
  @override
  bool get isLoading => false;

  @override
  Failure? get failure => null;

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class FavoritesSuccessState implements FavoritesStates {
  final List<Product> products;

  FavoritesSuccessState({required this.products});

  @override
  Failure? get failure => null;

  @override
  bool get isLoading => false;

  @override
  List<Object?> get props => [products];

  @override
  bool? get stringify => true;
}

class FavoritesErrorState implements FavoritesStates {
  @override
  final Failure failure;

  FavoritesErrorState({required this.failure});

  @override
  bool get isLoading => false;

  @override
  List<Object?> get props => [failure];

  @override
  bool? get stringify => true;
}

class FavoritesLoadingState implements FavoritesStates {
  @override
  bool get isLoading => true;

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
  
  @override
  Failure? get failure => null;
}
