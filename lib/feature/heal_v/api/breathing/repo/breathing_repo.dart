import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/resource.dart';

abstract interface class BreathingsRepo {
  Stream<Resource<MeditationBreathings>> breathing({required String authToken});
}
