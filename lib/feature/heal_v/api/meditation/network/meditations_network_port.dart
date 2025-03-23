import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class MeditationsNetworkPort {
  Future<ApiWrapper<MeditationsDto?>> meditations();

  Future<ApiWrapper<List<MeditationsCategoriesDto>?>> meditationsCategories();
}
