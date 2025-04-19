import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/network/auth_network_port.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login/login_firebase_packet.dart';

class LoginFirebaseNetworkBounds extends HttpBounds<LoginDto, ApiWrapper<LoginDto?>> {
  final AuthNetworkPort port;
  final LoginFirebasePacket packet;

  LoginFirebaseNetworkBounds({required this.port, required this.packet});

  @override
  Future<ApiWrapper<LoginDto?>?> fetchFromNetwork() {
    return port.loginFirebase(packet);
  }

  @override
  Future<LoginDto?> processResponse(ApiWrapper<LoginDto?>? response, {LoginDto? data}) async {
    return switch (response) {
      Success<LoginDto?>() => response.value,
      _ => data,
    };
  }
}
