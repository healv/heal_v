import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';

abstract interface class AuthRepo {
  Stream<Resource<UserDto>> getMe(String? email, String? displayName);
}
