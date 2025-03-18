import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class SharedContentNetworkPort {
  Future<ApiWrapper<SharedContentDto?>> sharedContent();
}
