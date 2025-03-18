import 'package:dio/dio.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';
import 'package:retrofit/retrofit.dart';

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

  @GET('/shared-content')
  Future<HttpResponse<SharedContentDto?>> sharedContent();
}
