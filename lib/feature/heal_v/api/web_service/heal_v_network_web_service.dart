import 'package:dio/dio.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/login/login_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/sign_up/sign_up_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login/login_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/sign_up/sign_up_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'heal_v_network_web_service.g.dart';

@RestApi(baseUrl: AuthConstants.baseUrl)
abstract class HealVNetworkWebService {
  factory HealVNetworkWebService(Dio dio, {String baseUrl}) = _HealVNetworkWebService;

  @POST('/auth/login')
  Future<HttpResponse<LoginDto?>> login(@Body() LoginPacket body);

  @POST('/auth/signup')
  Future<HttpResponse<SignUpDto?>> signUp(@Body() SignUpPacket body);

  @GET('/auth/user')
  Future<HttpResponse<UserDto?>> me();

  @GET('/shared-content')
  Future<HttpResponse<SharedContentDto?>> sharedContent();

  @GET('/daily-progress')
  Future<HttpResponse<DailyProgressDto?>> getDailyProgress();

  @GET('/meditations')
  Future<HttpResponse<MeditationsDto?>> meditations(@Query('search') String? searchQuery);

  @GET('/breathings')
  Future<HttpResponse<BreathingsDto?>> breathings(@Query('search') String? searchQuery);

  @GET('/meditations/categories')
  Future<HttpResponse<List<MeditationsCategoriesDto>?>> meditationsCategories();

  @GET('/breathings/categories')
  Future<HttpResponse<List<BreathingsCategoriesDto>?>> breathingsCategories();
}
