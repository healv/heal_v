import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login/login_firebase_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login/login_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/sign_up/sign_up_packet.dart';

abstract interface class AuthRepo {
  Stream<Resource<LoginDto>> login(LoginPacket loginPacket);

  Stream<Resource<LoginDto>> loginFirebase(LoginFirebasePacket loginFirebasePacket);

  Stream<Resource<SignUpDto>> signUp(SignUpPacket signUpPacket);

  Stream<Resource<UserDto>> getMe();
}
