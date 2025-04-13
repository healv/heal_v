import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_type_enum.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';

class BreathingsNetworkBounds extends HttpBounds<MeditationBreathings, ApiWrapper<BreathingsDto?>> {
  final BreathingsNetworkPort port;

  BreathingsNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<BreathingsDto?>?> fetchFromNetwork() {
    return port.breathings();
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
                    type: MeditationTypeEnum.breathings,
                    id: e.id,
                    name: e.name,
                    author: e.author,
                    category: e.category ?? tr('breathing'),
                    photoUrl: e.photoUrl,
                    audioUrl: e.audioUrl,
                    duration: e.duration ?? '15',
                    description: e.description ?? 'Both can be full-body practices, although stretching focuses on one muscle group at a time while yoga can include full-body movements.',
                    isEnable: e.name == '6' || e.name == '5' || e.name == '5' //todo remove
                    ),
              )
              .toList(),
        ),
      _ => data,
    };
  }
}
