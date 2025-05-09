import 'package:dio/dio.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

import '../model/user/user_wrapper_dto.dart';
import '../packet/update_user_packet.dart';
import 'auth_network_port.dart';

base class AuthNetworkAdapter implements AuthNetworkPort {
  final HealVNetworkWebService authNetworkWebService;

  AuthNetworkAdapter({required this.authNetworkWebService});

  @override
  Future<ApiWrapper<UserDto?>> getMe(String? email, String? displayName) {
    return parseHttpResponse<UserDto>(authNetworkWebService.me, [email, displayName]);
  }

  @override
  Future<ApiWrapper<UserWrapperDto?>> updateUser(UpdateUserPacket body) {
    return parseHttpResponse<UserWrapperDto>(authNetworkWebService.updateUser, [body]);
  }

  @override
  Future<ApiWrapper<UserWrapperDto?>> uploadImage(FormData data) {
    return parseHttpResponse<UserWrapperDto>(authNetworkWebService.uploadImage, [data]);
  }
}
