import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/progress_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class ProgressNetworkAdapter implements ProgressNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  ProgressNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<DailyProgressDto?>> getDailyProgress(String? date) {
    return parseHttpResponse<DailyProgressDto>(healVNetworkWebService.getDailyProgress, [date]);
  }

  @override
  Future<ApiWrapper<TreeGrowthDto?>> getTreeGrowth() {
    return parseHttpResponse<TreeGrowthDto>(healVNetworkWebService.getTreeGrowth, []);
  }
}
