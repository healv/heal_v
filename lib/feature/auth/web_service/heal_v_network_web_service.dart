import 'package:dio/dio.dart';
import 'package:heal_v/feature/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/auth/packet/login_packet.dart';
import 'package:heal_v/feature/auth/utils/auth_constants.dart';
import 'package:retrofit/retrofit.dart';

import '../model/user/user_dto.dart';

part 'heal_v_network_web_service.g.dart';

@RestApi(baseUrl: AuthConstants.baseUrl)
abstract class HealVNetworkWebService {
  factory HealVNetworkWebService(Dio dio, {String baseUrl}) = _HealVNetworkWebService;

  @POST('/auth/login')
  Future<HttpResponse<LoginDto?>> login(@Body() LoginPacket body);

  @POST('/auth/signup')
  Future<HttpResponse<SignUpDto?>> signUp(@Body() LoginPacket body);

  @GET('/auth/user')
  Future<HttpResponse<UserDto?>> me(@Header('Authorization') String authToken);
}
