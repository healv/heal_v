import 'package:heal_v/feature/heal_v/api/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login/login_firebase_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login/login_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/sign_up/sign_up_packet.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class AuthNetworkPort {
  Future<ApiWrapper<LoginDto?>> login(LoginPacket loginPacket);

  Future<ApiWrapper<LoginDto?>> loginFirebase(LoginFirebasePacket loginFirebasePacket);

  Future<ApiWrapper<SignUpDto?>> signUp(SignUpPacket loginPacket);

  Future<ApiWrapper<UserWrapperDto?>> getMe();
}
