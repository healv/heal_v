import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/auth/web_service/heal_v_network_web_service.dart';

import '../network/auth_network_adapter.dart';
import '../network/auth_network_port.dart';
import '../repo/auth_repo.dart';
import '../repo/auth_repo_impl.dart';

extension AuthModule on GetIt {
  Future<void> authModule() async {
    registerLazySingleton<HealVNetworkWebService>(() => HealVNetworkWebService(get()));
    registerLazySingleton<AuthNetworkPort>(() => AuthNetworkAdapter(authNetworkWebService: get()));
    registerLazySingleton<AuthRepo>(() => AuthRepoImpl(port: get()));
  }
}
