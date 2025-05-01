import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/network/auth_network_port.dart';

class GetMeNetworkBounds extends HttpBounds<UserWrapperDto, ApiWrapper<UserWrapperDto?>> {
  final AuthNetworkPort port;

  GetMeNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<UserWrapperDto?>?> fetchFromNetwork() {
    return port.getMe();
  }

  @override
  Future<UserWrapperDto?> processResponse(ApiWrapper<UserWrapperDto?>? response, {UserWrapperDto? data}) async {
    return switch (response) {
      Success<UserWrapperDto?>() => response.value,
      _ => data,
    };
  }
}
