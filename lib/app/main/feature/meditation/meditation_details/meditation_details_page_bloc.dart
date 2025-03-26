import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'meditation_details_page_event.dart';
part 'meditation_details_page_state.dart';

class MeditationDetailsPageBloc extends Bloc<MeditationDetailsPageEvent, MeditationDetailsPageState> {
  MeditationDetailsPageBloc() : super(MeditationDetailsPageInitial()) {
    on<MeditationDetailsPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
