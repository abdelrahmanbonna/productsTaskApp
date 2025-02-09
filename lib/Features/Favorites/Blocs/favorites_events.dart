import 'package:task_app/Core/Base/base_event.dart';

abstract class FavoritesEvents implements BaseEvent {}

class GetFavorites extends FavoritesEvents {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}