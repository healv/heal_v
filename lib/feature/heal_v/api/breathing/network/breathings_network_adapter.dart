import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class BreathingsNetworkAdapter implements BreathingsNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  BreathingsNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<List<BreathingWeekDto>?>> getBreathingWeeks() {
    return parseHttpResponse<List<BreathingWeekDto>>(healVNetworkWebService.getBreathingWeeks, []);
  }

  @override
  Future<ApiWrapper<BreathingLessonsDto?>> getBreathingLessons({required String weekId}) {
    return parseHttpResponse<BreathingLessonsDto?>(healVNetworkWebService.getBreathingLessons, [weekId]);
  }

  @override
  Future<ApiWrapper<BreathingLessonDto?>> getBreathingLesson({required String weekId, required String lessonId}) {
    return parseHttpResponse<BreathingLessonDto?>(healVNetworkWebService.getBreathingLesson, [weekId, lessonId]);
  }

  @override
  Future<ApiWrapper<BreathingCompleteDto?>> completeBreathingLesson({required String weekId, required String lessonId}) {
    return parseHttpResponse<BreathingCompleteDto?>(healVNetworkWebService.completeBreathingLesson, [weekId, lessonId]);
  }
}
