import 'package:heal_v/feature/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/auth/packet/login_packet.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class AuthNetworkPort {
  Future<ApiWrapper<LoginDto?>> login(LoginPacket loginPacket);

  Future<ApiWrapper<SignUpDto?>> signUp(LoginPacket loginPacket);

  Future<ApiWrapper<UserDto?>> getMe(String? authToken);
}
