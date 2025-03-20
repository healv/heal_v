part of 'progress_bloc.dart';

sealed class ProgressEvent extends BaseEvent {
  const ProgressEvent();

  factory ProgressEvent.initial() => Initial._();
}

class Initial extends ProgressEvent {
  Initial._();
}
