import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/quiz/bounds/complete_quiz_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/quiz/bounds/get_quiz_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/request/complete_quiz_request.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/complete_quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/network/quiz_network_port.dart';
import 'package:heal_v/feature/heal_v/api/quiz/repo/quiz_repo.dart';

base class QuizRepoImpl implements QuizRepo {
  final QuizNetworkPort port;

  QuizRepoImpl({required this.port});

  @override
  Stream<Resource<QuizDto>> getQuiz() {
    return GetQuizNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<CompleteQuizDto>> completeQuiz(CompleteQuizRequest completeQuizRequest) {
    return CompleteQuizNetworkBounds(port: port, completeQuizRequest: completeQuizRequest).call();
  }
}
