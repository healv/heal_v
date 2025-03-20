import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/network/auth_network_port.dart';

class GetMeNetworkBounds extends HttpBounds<UserDto, ApiWrapper<UserDto?>> {
  final AuthNetworkPort port;

  GetMeNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<UserDto?>?> fetchFromNetwork() {
    return port.getMe();
  }

  @override
  Future<UserDto?> processResponse(ApiWrapper<UserDto?>? response, {UserDto? data}) async {
    return switch (response) {
      Success<UserDto?>() => response.value,
      _ => data,
    };
  }
}
