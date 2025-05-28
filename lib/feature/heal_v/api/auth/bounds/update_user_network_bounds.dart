import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/network/auth_network_port.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/update_user_packet.dart';

class UpdateUserNetworkBounds extends HttpBounds<UserDto, ApiWrapper<UserDto?>> {
  final AuthNetworkPort port;
  final UpdateUserPacket body;

  UpdateUserNetworkBounds({required this.port, required this.body});

  @override
  Future<ApiWrapper<UserDto?>?> fetchFromNetwork() {
    return port.updateUser(body);
  }

  @override
  Future<UserDto?> processResponse(ApiWrapper<UserDto?>? response, {UserDto? data}) async {
    return switch (response) {
      Success<UserDto?>() => response.value,
      _ => data,
    };
  }
}
