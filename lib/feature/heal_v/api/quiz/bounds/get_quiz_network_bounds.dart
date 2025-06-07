import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/network/quiz_network_port.dart';

class GetQuizNetworkBounds extends HttpBounds<QuizDto, ApiWrapper<QuizDto?>> {
  final QuizNetworkPort port;

  GetQuizNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<QuizDto?>?> fetchFromNetwork() {
    return port.getQuiz();
  }

  @override
  Future<QuizDto?> processResponse(ApiWrapper<QuizDto?>? response, {QuizDto? data}) async {
    return switch (response) {
      Success<QuizDto?>() => response.value,
      _ => data,
    };
  }
}
