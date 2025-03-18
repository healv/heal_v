import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/network/shared_content_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/network/shared_content_network_port.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/repo/shared_content_repo.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/repo/shared_content_repo_impl.dart';

extension SharedContentModule on GetIt {
  Future<void> sharedContentModule() async {
    registerLazySingleton<SharedContentNetworkPort>(() => SharedContentNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<SharedContentRepo>(() => SharedContentRepoImpl(port: get()));
  }
}
