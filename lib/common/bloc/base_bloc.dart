import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState> extends Bloc<Event, State> {
  BaseBloc(super.initialState);
}
