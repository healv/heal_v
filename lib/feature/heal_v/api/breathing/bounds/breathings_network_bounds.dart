import 'dart:math';

import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_type_enum.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';

class BreathingsNetworkBounds extends HttpBounds<MeditationBreathings, ApiWrapper<BreathingsDto?>> {
  final BreathingsNetworkPort port;
  final String? searchQuery;

  BreathingsNetworkBounds({required this.port, this.searchQuery});

  @override
  Future<ApiWrapper<BreathingsDto?>?> fetchFromNetwork() {
    return port.breathings(searchQuery: searchQuery);
  }

  @override
  Future<MeditationBreathings?> processResponse(ApiWrapper<BreathingsDto?>? response, {MeditationBreathings? data}) async {
    return switch (response) {
      Success<BreathingsDto?>() => MeditationBreathings(
          nextCursor: response.value?.nextCursor,
          prevCursor: response.value?.prevCursor,
          meditationBreathing: response.value?.breathings?.map((e) {
            final index = Random().nextInt(3);
            final path = index != 0 ? 'assets/icons/demo_image$index.png' : 'assets/icons/demo_image2.png';
            return MeditationBreathing(
              type: MeditationTypeEnum.breathings,
              id: e.id,
              name: e.name,
              author: e.author,
              category: e.category?.map((categoryElement) => MeditationBreathingCategory(id: categoryElement.id, name: categoryElement.name)).toList(),
              photoUrl: e.photoUrl
                  ?.map(
                    (photoUrlElement) => MeditationBreathingMediaUrl(
                      downloadURL: photoUrlElement.downloadURL,
                      lastModifiedTS: photoUrlElement.lastModifiedTS,
                      name: photoUrlElement.name,
                      ref: photoUrlElement.ref,
                      type: photoUrlElement.type,
                    ),
                  )
                  .toList(),
              audioUrl: e.audioUrl
                  ?.map(
                    (audioUrlElement) => MeditationBreathingMediaUrl(
                      downloadURL: audioUrlElement.downloadURL,
                      lastModifiedTS: audioUrlElement.lastModifiedTS,
                      name: audioUrlElement.name,
                      ref: audioUrlElement.ref,
                      type: audioUrlElement.type,
                    ),
                  )
                  .toList(),
              duration: e.duration ?? '15',
              description: e.description ?? 'Both can be full-body practices, although stretching focuses on one muscle group at a time while yoga can include full-body movements.',
              isEnable: e.name == '6' || e.name == '5' || e.name == '5',
              //todo remove
              demoImage: path,
            );
          }).toList(),
        ),
      _ => data,
    };
  }
}
