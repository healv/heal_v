import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/progress_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/progress_network_port.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/progress_repo.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/progress_repo_impl.dart';

extension ProgressModule on GetIt {
  Future<void> progressModule() async {
    registerLazySingleton<ProgressNetworkPort>(() => ProgressNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<ProgressRepo>(() => ProgressRepoImpl(port: get()));
  }
}
