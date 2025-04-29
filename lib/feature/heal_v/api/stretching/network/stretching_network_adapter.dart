import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
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
}
