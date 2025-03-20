import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/network/auth_network_port.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/sign_up/sign_up_packet.dart';

class SignUpNetworkBounds extends HttpBounds<SignUpDto, ApiWrapper<SignUpDto?>> {
  final AuthNetworkPort port;
  final SignUpPacket packet;

  SignUpNetworkBounds({required this.port, required this.packet});

  @override
  Future<ApiWrapper<SignUpDto?>?> fetchFromNetwork() {
    return port.signUp(packet);
  }

  @override
  Future<SignUpDto?> processResponse(ApiWrapper<SignUpDto?>? response, {SignUpDto? data}) async {
    return switch (response) {
      Success<SignUpDto?>() => response.value,
      _ => data,
    };
  }
}
