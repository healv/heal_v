import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/validate_user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/network/auth_network_port.dart';

class ValidateUserNetworkBounds extends HttpBounds<ValidateUserDto, ApiWrapper<ValidateUserDto?>> {
  final AuthNetworkPort port;
  final String email;

  ValidateUserNetworkBounds({required this.port, required this.email});

  @override
  Future<ApiWrapper<ValidateUserDto?>?> fetchFromNetwork() {
    return port.validateUser(email);
  }

  @override
  Future<ValidateUserDto?> processResponse(ApiWrapper<ValidateUserDto?>? response, {ValidateUserDto? data}) async {
    return switch (response) {
      Success<ValidateUserDto?>() => response.value,
      _ => data,
    };
  }
}
