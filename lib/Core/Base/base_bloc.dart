import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Core/Base/base_event.dart';
import 'package:task_app/Core/Base/base_state.dart';
import 'package:task_app/Core/Error/failures.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(const InitialState()) {
    on<InitialEvent>(_onInitialEvent);
    on<RefreshEvent>(_onRefreshEvent);
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      emit(const LoadingState());
      await onInitialEvent(event, emit);
    } catch (e) {
      emit(
        ErrorState(
          failure: ServerFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onRefreshEvent(
    RefreshEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      await onRefreshEvent(event, emit);
    } catch (e) {
      emit(
        ErrorState(
          failure: ServerFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> onInitialEvent(InitialEvent event, Emitter<BaseState> emit) async {}
  Future<void> onRefreshEvent(RefreshEvent event, Emitter<BaseState> emit) async {}
}
