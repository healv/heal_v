import 'package:get_it/get_it.dart';
import 'package:heal_v/feature/heal_v/api/quiz/network/quiz_network_adapter.dart';
import 'package:heal_v/feature/heal_v/api/quiz/network/quiz_network_port.dart';
import 'package:heal_v/feature/heal_v/api/quiz/repo/quiz_repo.dart';
import 'package:heal_v/feature/heal_v/api/quiz/repo/quiz_repo_impl.dart';

extension QuizModule on GetIt {
  Future<void> quizModule() async {
    registerLazySingleton<QuizNetworkPort>(() => QuizNetworkAdapter(healVNetworkWebService: get()));
    registerLazySingleton<QuizRepo>(() => QuizRepoImpl(port: get()));
  }
}
