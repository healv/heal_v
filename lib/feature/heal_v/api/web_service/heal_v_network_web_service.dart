import 'package:dio/dio.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/put_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_week_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../auth/packet/update_user_packet.dart';
import '../journal/model/delete_journal_dto.dart';
import '../journal/model/journal_history_dto.dart';
import '../journal/packet/put_journal_packet.dart';
import '../meditation/model/meditation_lessons_dto.dart';
import '../stretching/model/stretching_complete_dto.dart';

part 'heal_v_network_web_service.g.dart';

@RestApi(baseUrl: AuthConstants.baseUrl)
abstract class HealVNetworkWebService {
  factory HealVNetworkWebService(Dio dio, {String baseUrl}) = _HealVNetworkWebService;

  @GET('user')
  Future<HttpResponse<UserDto?>> me(@Query('email') String? email, @Query('displayName') String? displayName);

  @PUT('user/update')
  Future<HttpResponse<UserDto?>> updateUser(@Body() UpdateUserPacket body);

  @PUT('user/upload-image')
  Future<HttpResponse<UserDto?>> uploadImage(@Body() FormData formData);

  @DELETE('user/delete-image')
  Future<HttpResponse<UserDto?>> deleteImage();

  @GET('stretching')
  Future<HttpResponse<List<StretchingWeekDto>?>> getStretchingWeeks();

  @GET('stretching/{weekId}')
  Future<HttpResponse<StretchingLessonsDto>> getStretchingLessons(@Path('weekId') String id);

  @GET('stretching/{weekId}/lesson/{lessonId}')
  Future<HttpResponse<StretchingLessonDto>> getStretchingLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @PATCH('/stretching/{weekId}/lesson/{lessonId}/complete')
  Future<HttpResponse<StretchingCompleteDto>> completeStretchingLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @GET('meditation')
  Future<HttpResponse<List<MeditationWeekDto>?>> getMeditationWeeks();

  @GET('meditation/{weekId}')
  Future<HttpResponse<MeditationLessonsDto>> getMeditationLessons(@Path('weekId') String id);

  @GET('meditation/{weekId}/lesson/{lessonId}')
  Future<HttpResponse<MeditationLessonDto>> getMeditationLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @PATCH('/meditation/{weekId}/lesson/{lessonId}/complete')
  Future<HttpResponse<MeditationCompleteDto>> completeMeditationLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  //-------------------------------------------------------------------------------------------------------------------------------

  @GET('shared-content')
  Future<HttpResponse<SharedContentDto?>> sharedContent();

  @GET('daily-progress')
  Future<HttpResponse<DailyProgressDto?>> getDailyProgress();

  @GET('breathings')
  Future<HttpResponse<BreathingsDto?>> breathings(@Query('search') String? searchQuery);

  @GET('breathings/categories')
  Future<HttpResponse<List<BreathingsCategoriesDto>?>> breathingsCategories();

  @GET('journal')
  Future<HttpResponse<List<JournalHistoryDto>?>> getJournalHistory();

  @PUT('journal/{date}')
  Future<HttpResponse<PutJournalDto?>> putJournal(@Path('date') String date, @Body() PutJournalPacket putJournalPacket);

  @DELETE('journal/{date}')
  Future<HttpResponse<DeleteJournalDto?>> deleteJournal(@Path('date') String date);
}
