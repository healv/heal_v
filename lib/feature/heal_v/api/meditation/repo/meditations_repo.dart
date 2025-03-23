import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_categories_dto.dart';

abstract interface class MeditationsRepo {
  Stream<Resource<MeditationBreathings>> meditations();

  Stream<Resource<List<MeditationsCategoriesDto>>> meditationsCategories();
}
