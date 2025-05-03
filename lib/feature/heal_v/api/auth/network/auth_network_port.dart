import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class AuthNetworkPort {
  Future<ApiWrapper<UserDto?>> getMe(String? email, String? displayName);
}
