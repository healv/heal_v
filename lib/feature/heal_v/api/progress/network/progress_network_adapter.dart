import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/request/daily_progress_request.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_list_dto.dart';
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
  Future<ApiWrapper<DailyProgressDto?>> updateDailyProgress(String? date, DailyProgressRequest? dailyProgressRequest) {
    return parseHttpResponse<DailyProgressDto?>(healVNetworkWebService.updateDailyProgress, [date, dailyProgressRequest]);
  }

  @override
  Future<ApiWrapper<DailyProgressListDto?>> getDailyProgressList(String? startDate, String? endDate, int? page, int? pageSize) {
    return parseHttpResponse<DailyProgressListDto?>(healVNetworkWebService.getDailyProgressList, [startDate, endDate, page, pageSize]);
  }

  @override
  Future<ApiWrapper<TreeGrowthDto?>> getTreeGrowth() {
    return parseHttpResponse<TreeGrowthDto>(healVNetworkWebService.getTreeGrowth, []);
  }
}
