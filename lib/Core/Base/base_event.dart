import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends BaseEvent {
  const InitialEvent();
}

class RefreshEvent extends BaseEvent {
  const RefreshEvent();
}
