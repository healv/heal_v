import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/request/complete_quiz_request.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/complete_quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';

abstract interface class QuizRepo {
  Stream<Resource<QuizDto>> getQuiz();

  Stream<Resource<CompleteQuizDto>> completeQuiz(CompleteQuizRequest completeQuizRequest);
}
