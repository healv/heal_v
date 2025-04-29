import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/network/stretching_network_port.dart';

import '../../../../../app/main/feature/stretching/model/stretching_lessons_ui_model.dart';

class StretchingLessonsNetworkBounds extends HttpBounds<StretchingLessons, ApiWrapper<StretchingLessonsDto?>> {
  final StretchingNetworkPort port;
  final String id;

  StretchingLessonsNetworkBounds({required this.port, required this.id});

  @override
  Future<ApiWrapper<StretchingLessonsDto?>?> fetchFromNetwork() {
    return port.getStretchingLessons(id: id);
  }

  @override
  Future<StretchingLessons?> processResponse(ApiWrapper<StretchingLessonsDto?>? response, {StretchingLessons? data}) async {
    return switch (response) {
      Success<StretchingLessonsDto?>() => StretchingLessons.fromMap(response.value?.toJson() ?? {}),
      _ => data,
    };
  }
}
