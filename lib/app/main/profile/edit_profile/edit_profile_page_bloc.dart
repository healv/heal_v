import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_page_event.dart';
part 'edit_profile_page_state.dart';

class EditProfilePageBloc extends Bloc<EditProfilePageEvent, EditProfilePageState> {
  EditProfilePageBloc() : super(EditProfilePageInitial()) {
    on<EditProfilePageEvent>((event, emit) {
    });
  }
}
