import 'package:dio/dio.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/validate_user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/update_user_packet.dart';

abstract interface class AuthRepo {
  Stream<Resource<UserDto>> getMe(String? email, String? displayName);

  Stream<Resource<UserDto>> updateUser(UpdateUserPacket body);

  Stream<Resource<UserDto>> uploadImage(FormData data);

  Stream<Resource<UserDto>> deleteImage();

  Stream<Resource<ValidateUserDto>> validateUser(String email);
}
