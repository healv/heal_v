part of 'shared_content_bloc.dart';

sealed class SharedContentEvent extends BaseEvent {
  const SharedContentEvent();

  factory SharedContentEvent.initial() => Initial._();
}

class Initial extends SharedContentEvent {
  Initial._();
}
