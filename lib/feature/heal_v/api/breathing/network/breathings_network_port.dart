import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class BreathingsNetworkPort {
  Future<ApiWrapper<BreathingsDto?>> breathings({String? searchQuery});

  Future<ApiWrapper<List<BreathingsCategoriesDto>?>> breathingsCategories();
}
