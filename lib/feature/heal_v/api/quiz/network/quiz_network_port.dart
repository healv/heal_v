import 'package:heal_v/feature/heal_v/api/quiz/model/request/complete_quiz_request.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/complete_quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class QuizNetworkPort {
  Future<ApiWrapper<QuizDto?>> getQuiz();

  Future<ApiWrapper<CompleteQuizDto?>> completeQuiz(CompleteQuizRequest completeQuizRequest);
}
