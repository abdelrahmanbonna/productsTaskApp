import 'package:task_app/Core/Base/base_state.dart';
import 'package:task_app/Core/Error/failures.dart';

abstract class DetailsStates implements BaseState {}

class DetailsInitial extends DetailsStates {
  @override
  Failure? get failure => null;

  @override
  bool get isLoading => false;

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class LoadingState extends DetailsStates {
  @override
  Failure? get failure => null;

  @override
  bool get isLoading => true;

  @override
  List<Object?> get props => [];
  
  @override
  bool? get stringify => true;
}

class ProductSavedToFavorite extends DetailsStates {
  @override
  Failure? get failure => null;

  @override
  bool get isLoading => false;

  @override
  List<Object?> get props => [];
  
  @override
  bool? get stringify => true;
}