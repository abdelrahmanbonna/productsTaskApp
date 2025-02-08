import 'package:task_app/Core/Base/base_event.dart';

abstract class HomeEvents extends BaseEvent {}

class GetProductsHomeEvent extends HomeEvents {
  final bool forceUpdate;

  GetProductsHomeEvent({required this.forceUpdate});
}