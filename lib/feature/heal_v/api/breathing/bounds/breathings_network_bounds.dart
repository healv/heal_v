import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';

class BreathingsNetworkBounds extends HttpBounds<MeditationBreathings, ApiWrapper<BreathingsDto?>> {
  final BreathingsNetworkPort port;
  final String authToken;

  BreathingsNetworkBounds({required this.port, required this.authToken});

  @override
  Future<ApiWrapper<BreathingsDto?>?> fetchFromNetwork() {
    return port.breathings(authToken: authToken);
  }

  @override
  Future<MeditationBreathings?> processResponse(ApiWrapper<BreathingsDto?>? response, {MeditationBreathings? data}) async {
    return switch (response) {
      Success<BreathingsDto?>() => MeditationBreathings(
          nextCursor: response.value?.nextCursor,
          prevCursor: response.value?.prevCursor,
          meditationBreathing: response.value?.breathings
              ?.map(
                (e) => MeditationBreathing(
                  id: e.id,
                  name: e.name,
                  author: e.author,
                  category: e.category,
                  photoUrl: e.photoUrl,
                  audioUrl: e.audioUrl,
                ),
              )
              .toList(),
        ),
      _ => data,
    };
  }
}
