import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login/login_firebase_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login/login_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/sign_up/sign_up_packet.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

import 'auth_network_port.dart';

base class AuthNetworkAdapter implements AuthNetworkPort {
  final HealVNetworkWebService authNetworkWebService;

  AuthNetworkAdapter({required this.authNetworkWebService});

  @override
  Future<ApiWrapper<UserDto?>> getMe() {
    return parseHttpResponse<UserDto>(authNetworkWebService.me, []);
  }

  @override
  Future<ApiWrapper<LoginDto?>> login(LoginPacket loginPacket) {
    return parseHttpResponse<LoginDto>(authNetworkWebService.login, [loginPacket]);
  }

  @override
  Future<ApiWrapper<LoginDto?>> loginFirebase(LoginFirebasePacket loginFirebasePacket) {
    return parseHttpResponse<LoginDto>(authNetworkWebService.loginFirebase, [loginFirebasePacket]);
  }

  @override
  Future<ApiWrapper<SignUpDto?>> signUp(SignUpPacket signUpPacket) {
    return parseHttpResponse<SignUpDto>(authNetworkWebService.signUp, [signUpPacket]);
  }
}
