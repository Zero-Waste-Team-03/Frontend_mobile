import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/notification_usecases.dart';

abstract class NotificationStatsEvent extends Equatable {
  const NotificationStatsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotificationStatsEvent extends NotificationStatsEvent {
  const FetchNotificationStatsEvent();
}

abstract class NotificationStatsState extends Equatable {
  const NotificationStatsState();

  @override
  List<Object?> get props => [];
}

class NotificationStatsInitial extends NotificationStatsState {
  const NotificationStatsInitial();
}

class NotificationStatsLoading extends NotificationStatsState {
  const NotificationStatsLoading();
}

class NotificationStatsLoaded extends NotificationStatsState {
  final int unreadCount;

  const NotificationStatsLoaded(this.unreadCount);

  @override
  List<Object?> get props => [unreadCount];
}

class NotificationStatsError extends NotificationStatsState {
  final String message;

  const NotificationStatsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NotificationStatsBloc
    extends Bloc<NotificationStatsEvent, NotificationStatsState> {
  final GetNotificationStatsUseCase getNotificationStatsUseCase;

  NotificationStatsBloc({required this.getNotificationStatsUseCase})
    : super(const NotificationStatsInitial()) {
    on<FetchNotificationStatsEvent>(_onFetchNotificationStats);
  }

  Future<void> _onFetchNotificationStats(
    FetchNotificationStatsEvent event,
    Emitter<NotificationStatsState> emit,
  ) async {
    emit(const NotificationStatsLoading());

    final result = await getNotificationStatsUseCase();

    result.fold(
      (failure) => emit(NotificationStatsError(failure.message)),
      (stats) => emit(NotificationStatsLoaded(stats.unreadCount)),
    );
  }
}
