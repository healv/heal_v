part of 'launch_page_bloc.dart';

sealed class LaunchPageBlocEvent extends BaseEvent {
  LaunchPageBlocEvent();

  factory LaunchPageBlocEvent.initial() => Initial._();
}

class Initial extends LaunchPageBlocEvent {

  Initial._();
}
