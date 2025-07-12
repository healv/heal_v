import 'package:dio/dio.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_list_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/total_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/cancel_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/create_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/resume_subscription_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../auth/model/user/validate_user_dto.dart';
import '../auth/packet/update_user_packet.dart';
import '../breathing/model/breathing_lessons_dto.dart';
import '../meditation/model/meditation_lessons_dto.dart';
import '../progress/model/request/daily_progress_request.dart';
import '../quiz/model/request/complete_quiz_request.dart';
import '../quiz/model/response/complete_quiz_dto.dart';
import '../stretching/model/stretching_complete_dto.dart';
import '../subscription/model/subscription_history_dto.dart';
import '../subscription/model/subscription_status_dto.dart';

part 'heal_v_network_web_service.g.dart';

@RestApi(baseUrl: AuthConstants.baseHost)
abstract class HealVNetworkWebService {
  factory HealVNetworkWebService(Dio dio, {String baseUrl}) = _HealVNetworkWebService;

  @GET('/api/user')
  Future<HttpResponse<UserDto?>> me(@Query('email') String? email, @Query('displayName') String? displayName);

  @PUT('/api/user/update')
  Future<HttpResponse<UserDto?>> updateUser(@Body() UpdateUserPacket body);

  @PUT('/api/user/upload-image')
  Future<HttpResponse<UserDto?>> uploadImage(@Body() FormData formData);

  @DELETE('/api/user/delete-image')
  Future<HttpResponse<UserDto?>> deleteImage();

  @GET('/api/user/validate')
  Future<HttpResponse<ValidateUserDto?>> validateUser(@Query('email') String? email);

  @GET('/api/stretching')
  Future<HttpResponse<List<StretchingWeekDto>?>> getStretchingWeeks();

  @GET('/api/stretching/{weekId}')
  Future<HttpResponse<StretchingLessonsDto>> getStretchingLessons(@Path('weekId') String id);

  @GET('/api/stretching/{weekId}/lesson/{lessonId}')
  Future<HttpResponse<StretchingLessonDto>> getStretchingLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @PATCH('/api/stretching/{weekId}/lesson/{lessonId}/complete')
  Future<HttpResponse<StretchingCompleteDto>> completeStretchingLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @GET('/api/meditation')
  Future<HttpResponse<List<MeditationWeekDto>?>> getMeditationWeeks();

  @GET('/api/meditation/{weekId}')
  Future<HttpResponse<MeditationLessonsDto>> getMeditationLessons(@Path('weekId') String id);

  @GET('/api/meditation/{weekId}/lesson/{lessonId}')
  Future<HttpResponse<MeditationLessonDto>> getMeditationLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @PATCH('/api/meditation/{weekId}/lesson/{lessonId}/complete')
  Future<HttpResponse<MeditationCompleteDto>> completeMeditationLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @GET('/api/breathing')
  Future<HttpResponse<List<BreathingWeekDto>?>> getBreathingWeeks();

  @GET('/api/breathing/{weekId}')
  Future<HttpResponse<BreathingLessonsDto>> getBreathingLessons(@Path('weekId') String id);

  @GET('/api/meditation/{weekId}/lesson/{lessonId}')
  Future<HttpResponse<BreathingLessonDto>> getBreathingLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @PATCH('/api/breathing/{weekId}/lesson/{lessonId}/complete')
  Future<HttpResponse<BreathingCompleteDto>> completeBreathingLesson(@Path('weekId') String weekId, @Path('lessonId') String lessonId);

  @GET('/api/daily-progress')
  Future<HttpResponse<DailyProgressDto?>> getDailyProgress(@Query('date') String? date);

  @PATCH('/api/daily-progress')
  Future<HttpResponse<DailyProgressDto?>> updateDailyProgress(@Query('date') String? date, @Body() DailyProgressRequest dailyProgressRequest);

  @GET('/api/total-progress')
  Future<HttpResponse<TotalProgressDto?>> totalProgress();

  @GET('/api/daily-progress/list')
  Future<HttpResponse<DailyProgressListDto?>> getDailyProgressList(
    @Query('startDate') String? startDate,
    @Query('endDate') String? endDate,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  );

  @GET('/api/tree-growth')
  Future<HttpResponse<TreeGrowthDto?>> getTreeGrowth();

  @GET('/api/quiz')
  Future<HttpResponse<QuizDto?>> getQuiz();

  @POST('/api/quiz/complete')
  Future<HttpResponse<CompleteQuizDto?>> completeQuiz(@Body() CompleteQuizRequest completeQuizRequest);

  @GET('/api/subscription/status')
  Future<HttpResponse<SubscriptionStatusDto?>> getSubscriptionStatus();

  @POST('/api/subscription/create')
  Future<HttpResponse<CreateSubscriptionDto?>> createSubscription();

  @GET('/api/subscription/payment-history')
  Future<HttpResponse<SubscriptionHistoryDto?>> getSubscriptionHistory(
    @Query('limit') int? limit,
    @Query('includeZero') bool? includeZero,
  );

  @POST('/api/subscription/cancel')
  Future<HttpResponse<CancelSubscriptionDto?>> cancelSubscription();

  @POST('/api/subscription/resume')
  Future<HttpResponse<ResumeSubscriptionDto?>> resumeSubscription();
}
