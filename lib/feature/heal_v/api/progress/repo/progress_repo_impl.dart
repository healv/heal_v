import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/bounds/daily_progress_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/bounds/tree_growth_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
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
  Stream<Resource<TreeGrowthDto>> getTreeGrowth() {
    return TreeGrowthNetworkBounds(port: port).call();
  }
}
