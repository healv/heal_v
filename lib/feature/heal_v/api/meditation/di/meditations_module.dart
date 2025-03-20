import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';
import 'package:heal_v/feature/heal_v/api/meditation/repo/meditations_repo.dart';
import 'package:heal_v/feature/heal_v/api/meditation/repo/meditations_repo_impl.dart';

extension MeditationsModule on GetIt {
  Future<void> meditationsModule() async {
    registerLazySingleton<MeditationsNetworkPort>(() => MeditationsNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<MeditationsRepo>(() => MeditationsRepoImpl(port: get()));
  }
}
