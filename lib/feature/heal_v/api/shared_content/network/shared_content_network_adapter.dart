import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

import 'shared_content_network_port.dart';

base class SharedContentNetworkAdapter implements SharedContentNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  SharedContentNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<SharedContentDto?>> sharedContent() {
    return parseHttpResponse<SharedContentDto>(healVNetworkWebService.sharedContent, []);
  }
}
