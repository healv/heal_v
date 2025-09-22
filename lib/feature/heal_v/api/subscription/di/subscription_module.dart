import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';
import 'package:heal_v/feature/heal_v/api/subscription/repo/subscription_repo_impl.dart';

import '../repo/subscription_repo.dart';

extension SubscriptionModule on GetIt {
  Future<void> subscriptionModule() async {
    registerLazySingleton<SubscriptionNetworkPort>(() => SubscriptionNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<SubscriptionRepo>(() => SubscriptionRepoImpl(port: get()));
  }
}
