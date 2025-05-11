import 'package:dio/dio.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/put_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_week_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../auth/model/user/user_wrapper_dto.dart';
import '../auth/packet/update_user_packet.dart';
import '../journal/model/delete_journal_dto.dart';
import '../journal/model/journal_history_dto.dart';
import '../journal/packet/put_journal_packet.dart';

part 'heal_v_network_web_service.g.dart';

@RestApi(baseUrl: AuthConstants.baseUrl)
abstract class HealVNetworkWebService {
  factory HealVNetworkWebService(Dio dio, {String baseUrl}) = _HealVNetworkWebService;

  @GET('auth/user')
  Future<HttpResponse<UserDto?>> me(@Query('email') String? email, @Query('displayName') String? displayName);

  @PUT('auth/update')
  Future<HttpResponse<UserWrapperDto?>> updateUser(@Body() UpdateUserPacket body);

  @POST('auth/upload-image')
  Future<HttpResponse<UserWrapperDto?>> uploadImage(@Body() FormData formData);

  @GET('shared-content')
  Future<HttpResponse<SharedContentDto?>> sharedContent();

  @GET('daily-progress')
  Future<HttpResponse<DailyProgressDto?>> getDailyProgress();

  @GET('meditations')
  Future<HttpResponse<MeditationsDto?>> meditations(@Query('search') String? searchQuery);

  @GET('breathings')
  Future<HttpResponse<BreathingsDto?>> breathings(@Query('search') String? searchQuery);

  @GET('meditations/categories')
  Future<HttpResponse<List<MeditationsCategoriesDto>?>> meditationsCategories();

  @GET('breathings/categories')
  Future<HttpResponse<List<BreathingsCategoriesDto>?>> breathingsCategories();

  @GET('journal')
  Future<HttpResponse<List<JournalHistoryDto>?>> getJournalHistory();

  @PUT('journal/{date}')
  Future<HttpResponse<PutJournalDto?>> putJournal(@Path('date') String date, @Body() PutJournalPacket putJournalPacket);

  @DELETE('journal/{date}')
  Future<HttpResponse<DeleteJournalDto?>> deleteJournal(@Path('date') String date);

  @GET('stretching')
  Future<HttpResponse<List<StretchingWeekDto>?>> getStretchingWeeks();

  @GET('stretching/{id}')
  Future<HttpResponse<StretchingLessonsDto>> getStretchingLessons(@Path('id') String id);
}
