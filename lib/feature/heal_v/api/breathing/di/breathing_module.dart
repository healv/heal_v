import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';
import 'package:heal_v/feature/heal_v/api/breathing/repo/breathing_repo.dart';
import 'package:heal_v/feature/heal_v/api/breathing/repo/breathing_repo_impl.dart';

extension BreathingsModule on GetIt {
  Future<void> breathingsModule() async {
    registerLazySingleton<BreathingsNetworkPort>(() => BreathingsNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<BreathingsRepo>(() => BreathingsRepoImpl(port: get()));
  }
}
