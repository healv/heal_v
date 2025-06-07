import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/request/complete_quiz_request.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/complete_quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/network/quiz_network_port.dart';

class CompleteQuizNetworkBounds extends HttpBounds<CompleteQuizDto, ApiWrapper<CompleteQuizDto?>> {
  final QuizNetworkPort port;
  final CompleteQuizRequest completeQuizRequest;

  CompleteQuizNetworkBounds({required this.port, required this.completeQuizRequest});

  @override
  Future<ApiWrapper<CompleteQuizDto?>?> fetchFromNetwork() {
    return port.completeQuiz(completeQuizRequest);
  }

  @override
  Future<CompleteQuizDto?> processResponse(ApiWrapper<CompleteQuizDto?>? response, {CompleteQuizDto? data}) async {
    return switch (response) {
      Success<CompleteQuizDto?>() => response.value,
      _ => data,
    };
  }
}
