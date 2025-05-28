import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class MeditationsNetworkAdapter implements MeditationsNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  MeditationsNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<List<MeditationWeekDto>?>> getMeditationWeeks({String? searchQuery}) {
    return parseHttpResponse<List<MeditationWeekDto>>(healVNetworkWebService.getMeditationWeeks, []);
  }

  @override
  Future<ApiWrapper<MeditationLessonsDto?>> getMeditationLessons({required String weekId}) {
    return parseHttpResponse<MeditationLessonsDto>(healVNetworkWebService.getMeditationLessons, [weekId]);
  }

  @override
  Future<ApiWrapper<MeditationLessonDto?>> getMeditationLesson({required String weekId, required String lessonId}) {
    return parseHttpResponse<MeditationLessonDto>(healVNetworkWebService.getMeditationLesson, [weekId, lessonId]);
  }

  @override
  Future<ApiWrapper<MeditationCompleteDto?>> completeMeditationLesson({required String weekId, required String lessonId}) {
    return parseHttpResponse<MeditationCompleteDto>(healVNetworkWebService.completeMeditationLesson, [weekId, lessonId]);
  }
}
