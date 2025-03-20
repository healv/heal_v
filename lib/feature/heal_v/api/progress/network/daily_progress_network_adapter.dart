import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/daily_progress_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class DailyProgressNetworkAdapter implements DailyProgressNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  DailyProgressNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<DailyProgressDto?>> getDailyProgress() {
    return parseHttpResponse<DailyProgressDto>(healVNetworkWebService.getDailyProgress, []);
  }
}
