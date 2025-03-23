import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class BreathingsNetworkAdapter implements BreathingsNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  BreathingsNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<BreathingsDto?>> breathings() {
    return parseHttpResponse<BreathingsDto>(healVNetworkWebService.breathings, []);
  }

  @override
  Future<ApiWrapper<List<BreathingsCategoriesDto>?>> breathingsCategories() {
    return parseHttpResponse<List<BreathingsCategoriesDto>>(healVNetworkWebService.breathingsCategories, []);
  }
}
