import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/stretching/network/stretching_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/stretching/network/stretching_network_port.dart';
import 'package:heal_v/feature/heal_v/api/stretching/repo/stretching_repo.dart';
import 'package:heal_v/feature/heal_v/api/stretching/repo/stretching_repo_impl.dart';

extension StretchingModule on GetIt {
  Future<void> stretchingsModule() async {
    registerLazySingleton<StretchingNetworkPort>(() => StretchingNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<StretchingRepo>(() => StretchingRepoImpl(port: get()));
  }
}
