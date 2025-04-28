import 'dart:math';

import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';

import '../../../../../app/main/feature/common/model/meditation_type_enum.dart';

class MeditationsNetworkBounds extends HttpBounds<MeditationBreathings, ApiWrapper<MeditationsDto?>> {
  final MeditationsNetworkPort port;
  final String? searchQuery;

  MeditationsNetworkBounds({required this.port, this.searchQuery});

  @override
  Future<ApiWrapper<MeditationsDto?>?> fetchFromNetwork() {
    return port.meditations(searchQuery: searchQuery);
  }

  @override
  Future<MeditationBreathings?> processResponse(ApiWrapper<MeditationsDto?>? response, {MeditationBreathings? data}) async {
    return switch (response) {
      Success<MeditationsDto?>() => MeditationBreathings(
          nextCursor: response.value?.nextCursor,
          prevCursor: response.value?.prevCursor,
          meditationBreathing: response.value?.meditations?.map(
            (e) {
              final index = Random().nextInt(5);
              return MeditationBreathing(
                  type: MeditationTypeEnum.meditations,
                  id: e.id,
                  name: e.name,
                  author: e.author,
                  category: e.category?.map((categoryElement) => MeditationBreathingCategory(id: categoryElement.id, name: categoryElement.name)).toList(),
                  photoUrl: e.photoUrl
                      ?.map((photoUrlElement) => MeditationBreathingMediaUrl(
                            downloadURL: photoUrlElement.downloadURL,
                            lastModifiedTS: photoUrlElement.lastModifiedTS,
                            name: photoUrlElement.name,
                            ref: photoUrlElement.ref,
                            type: photoUrlElement.type,
                          ))
                      .toList(),
                  audioUrl: e.audioUrl
                      ?.map((audioUrlElement) => MeditationBreathingMediaUrl(
                            downloadURL: audioUrlElement.downloadURL,
                            lastModifiedTS: audioUrlElement.lastModifiedTS,
                            name: audioUrlElement.name,
                            ref: audioUrlElement.ref,
                            type: audioUrlElement.type,
                          ))
                      .toList(),
                  duration: '15',
                  description: 'Both can be full-body practices, although stretching focuses on one muscle group at a time while yoga can include full-body movements.',
                  isEnable: e.name == '6' || e.name == '5' || e.name == '5',
                  //todo remove
                  demoImage: 'assets/icons/ic_meditation_$index.png');
            },
          ).toList(),
        ),
      _ => data,
    };
  }
}
