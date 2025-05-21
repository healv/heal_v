import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/network/stretching_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class StretchingNetworkAdapter implements StretchingNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  StretchingNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<List<StretchingWeekDto>?>> getStretchingWeeks() {
    return parseHttpResponse<List<StretchingWeekDto>?>(healVNetworkWebService.getStretchingWeeks, []);
  }

  @override
  Future<ApiWrapper<StretchingLessonsDto?>> getStretchingLessons({String? id}) {
    return parseHttpResponse<StretchingLessonsDto?>(healVNetworkWebService.getStretchingLessons, [id]);
  }

  @override
  Future<ApiWrapper<StretchingLessonDto?>> getStretchingLesson({String? weekId, String? lessonId}) {
    return parseHttpResponse<StretchingLessonDto?>(healVNetworkWebService.getStretchingLesson, [weekId, lessonId]);
  }

  @override
  Future<ApiWrapper<StretchingCompleteDto?>> completeStretchingLesson({String? weekId, String? lessonId}) {
    return parseHttpResponse<StretchingCompleteDto?>(healVNetworkWebService.completeStretchingLesson, [weekId, lessonId]);
  }
}
