import 'package:dio/dio.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/auth/bounds/get_me_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/bounds/update_user_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/bounds/upload_image_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/network/auth_network_port.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/update_user_packet.dart';

import 'auth_repo.dart';

base class AuthRepoImpl implements AuthRepo {
  final AuthNetworkPort port;

  AuthRepoImpl({required this.port});

  @override
  Stream<Resource<UserDto>> getMe(String? email, String? displayName) {
    return GetMeNetworkBounds(port: port, email: email, displayName: displayName).call();
  }

  @override
  Stream<Resource<UserDto>> updateUser(UpdateUserPacket body) {
    return UpdateUserNetworkBounds(port: port, body: body).call();
  }

  @override
  Stream<Resource<UserDto>> uploadImage(FormData data) {
    return UploadImageNetworkBounds(port: port, data: data).call();
  }
}
