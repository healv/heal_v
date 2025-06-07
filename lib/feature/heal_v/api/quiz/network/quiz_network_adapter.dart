import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/request/complete_quiz_request.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/complete_quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/network/quiz_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class QuizNetworkAdapter implements QuizNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  QuizNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<QuizDto?>> getQuiz() {
    return parseHttpResponse<QuizDto>(healVNetworkWebService.getQuiz, []);
  }

  @override
  Future<ApiWrapper<CompleteQuizDto?>> completeQuiz(CompleteQuizRequest completeQuizRequest) {
    return parseHttpResponse<CompleteQuizDto>(healVNetworkWebService.completeQuiz, [completeQuizRequest]);
  }
}
