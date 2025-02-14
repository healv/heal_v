import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'progress_page_event.dart';

part 'progress_page_state.dart';

class ProgressPageBloc extends Bloc<ProgressPageEvent, ProgressPageState> {
  ProgressPageBloc() : super(ProgressPageInitial()) {
    on<ProgressPageEvent>((event, emit) {});
  }
}
