part of 'progress_bloc.dart';

sealed class ProgressEvent extends BaseEvent {
  const ProgressEvent();

  factory ProgressEvent.initial({required String authToken}) => Initial._(authToken);
}

class Initial extends ProgressEvent {
  final String authToken;

  Initial._(this.authToken);
}
