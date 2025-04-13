import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';

import '../../../../../app/main/feature/common/model/meditation_type_enum.dart';

class MeditationsNetworkBounds extends HttpBounds<MeditationBreathings, ApiWrapper<MeditationsDto?>> {
  final MeditationsNetworkPort port;

  MeditationsNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<MeditationsDto?>?> fetchFromNetwork() {
    return port.meditations();
  }

  @override
  Future<MeditationBreathings?> processResponse(ApiWrapper<MeditationsDto?>? response, {MeditationBreathings? data}) async {
    return switch (response) {
      Success<MeditationsDto?>() => MeditationBreathings(
          nextCursor: response.value?.nextCursor,
          prevCursor: response.value?.prevCursor,
          meditationBreathing: response.value?.meditations
              ?.map(
                (e) => MeditationBreathing(
                  type: MeditationTypeEnum.meditations,
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
