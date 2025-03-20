import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/bounds/daily_progress_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/daily_progress_network_port.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/daily_progress_repo.dart';

base class DailyProgressRepoImpl implements DailyProgressRepo {
  final DailyProgressNetworkPort port;

  DailyProgressRepoImpl({required this.port});

  @override
  Stream<Resource<DailyProgressDto>> getDailyProgress() {
    return DailyProgressNetworkBounds(port: port).call();
  }
}
