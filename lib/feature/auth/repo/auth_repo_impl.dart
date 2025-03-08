import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/auth/bounds/get_me_network_bounds.dart';
import 'package:heal_v/feature/auth/bounds/login_network_bounds.dart';
import 'package:heal_v/feature/auth/bounds/sign_up_network_bounds.dart';
import 'package:heal_v/feature/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/auth/network/auth_network_port.dart';
import 'package:heal_v/feature/auth/packet/login_packet.dart';

import 'auth_repo.dart';

base class AuthRepoImpl implements AuthRepo {
  final AuthNetworkPort port;

  AuthRepoImpl({required this.port});

  @override
  Stream<Resource<UserDto>> getMe(String accessToken) {
    return GetMeNetworkBounds(port: port, accessToken: accessToken).call();
  }

  @override
  Stream<Resource<LoginDto>> login(LoginPacket loginPacket) {
    return LoginNetworkBounds(port: port, packet: loginPacket).call();
  }

  @override
  Stream<Resource<SignUpDto>> signUp(LoginPacket loginPacket) {
    return SignUpNetworkBounds(port: port, packet: loginPacket).call();
  }
}
