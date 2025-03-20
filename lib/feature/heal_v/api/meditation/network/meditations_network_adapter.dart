import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class MeditationsNetworkAdapter implements MeditationsNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  MeditationsNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<MeditationsDto?>> meditations({required String authToken}) {
    return parseHttpResponse<MeditationsDto>(healVNetworkWebService.meditations, [authToken]);
  }
}
