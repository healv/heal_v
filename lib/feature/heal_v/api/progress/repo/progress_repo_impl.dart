import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/bounds/daily_progress_list_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/bounds/daily_progress_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/bounds/total_progress_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/bounds/tree_growth_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/bounds/update_daily_progress_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/request/daily_progress_request.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_list_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/total_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/progress_network_port.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/progress_repo.dart';

base class ProgressRepoImpl implements ProgressRepo {
  final ProgressNetworkPort port;

  ProgressRepoImpl({required this.port});

  @override
  Stream<Resource<DailyProgressDto>> getDailyProgress({String? date}) {
    return DailyProgressNetworkBounds(port: port, date: date).call();
  }

  @override
  Stream<Resource<DailyProgressDto>> updateDailyProgress({String? date, DailyProgressRequest? dailyProgressRequest}) {
    return UpdateDailyProgressNetworkBounds(port: port, date: date, dailyProgressRequest: dailyProgressRequest).call();
  }

  @override
  Stream<Resource<DailyProgressListDto>> getDailyProgressList({String? startDate, String? endDate, int? page, int? pageSize}) {
    return DailyProgressListNetworkBounds(port: port, startDate: startDate, endDate: endDate, page: page, pageSize: pageSize).call();
  }

  @override
  Stream<Resource<TotalProgressDto>> totalProgress() {
    return TotalProgressNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<TreeGrowthDto>> getTreeGrowth() {
    return TreeGrowthNetworkBounds(port: port).call();
  }
}
