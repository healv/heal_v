import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/auth/packet/login_packet.dart';

abstract interface class AuthRepo {
  Future<Resource<LoginDto>> login(LoginPacket loginPacket);

  Future<Resource<SignUpDto>> signUp(LoginPacket loginPacket);

  Future<Resource<UserDto>> getMe(String accessToken);
}
