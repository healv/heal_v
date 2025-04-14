import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/journal/network/journal_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/journal/network/journal_network_port.dart';
import 'package:heal_v/feature/heal_v/api/journal/repo/journal_repo.dart';
import 'package:heal_v/feature/heal_v/api/journal/repo/journal_repo_impl.dart';

extension JournalModule on GetIt {
  Future<void> journalModule() async {
    registerLazySingleton<JournalNetworkPort>(() => JournalNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<JournalRepo>(() => JournalRepoImpl(port: get()));
  }
}
