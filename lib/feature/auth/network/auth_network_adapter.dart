import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/auth/packet/login_packet.dart';
import 'package:heal_v/feature/auth/web_service/heal_v_network_web_service.dart';

import 'auth_network_port.dart';

base class AuthNetworkAdapter implements AuthNetworkPort {
  final HealVNetworkWebService authNetworkWebService;

  AuthNetworkAdapter({required this.authNetworkWebService});

  @override
  Future<ApiWrapper<UserDto?>> getMe(String? authToken) {
    return parseHttpResponse<UserDto>(authNetworkWebService.me, [authToken]);
  }

  @override
  Future<ApiWrapper<LoginDto?>> login(LoginPacket loginPacket) {
    return parseHttpResponse<LoginDto>(authNetworkWebService.login, [loginPacket]);
  }

  @override
  Future<ApiWrapper<SignUpDto?>> signUp(LoginPacket loginPacket) {
    return parseHttpResponse<SignUpDto>(authNetworkWebService.signUp, [loginPacket]);
  }
}
