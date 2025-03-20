import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/daily_progress_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/daily_progress_network_port.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/daily_progress_repo.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/daily_progress_repo_impl.dart';

extension DailyProgressModule on GetIt {
  Future<void> dailyProgressModule() async {
    registerLazySingleton<DailyProgressNetworkPort>(() => DailyProgressNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<DailyProgressRepo>(() => DailyProgressRepoImpl(port: get()));
  }
}
