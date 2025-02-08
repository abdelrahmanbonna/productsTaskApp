import 'package:task_app/Core/Base/base_event.dart';

abstract class SplashEvents extends BaseEvent {}

class GetProductsEvent extends SplashEvents {
  final bool forceUpdate;
  GetProductsEvent({required this.forceUpdate});
}