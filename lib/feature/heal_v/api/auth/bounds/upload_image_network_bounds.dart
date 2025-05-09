import 'package:dio/dio.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_wrapper_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/network/auth_network_port.dart';

class UploadImageNetworkBounds extends HttpBounds<UserDto, ApiWrapper<UserWrapperDto?>> {
  final AuthNetworkPort port;
  final FormData data;

  UploadImageNetworkBounds({required this.port, required this.data});

  @override
  Future<ApiWrapper<UserWrapperDto?>?> fetchFromNetwork() {
    return port.uploadImage(data);
  }

  @override
  Future<UserDto?> processResponse(ApiWrapper<UserWrapperDto?>? response, {UserDto? data}) async {
    return switch (response) {
      Success<UserWrapperDto?>() => response.value?.user,
      _ => data,
    };
  }
}
