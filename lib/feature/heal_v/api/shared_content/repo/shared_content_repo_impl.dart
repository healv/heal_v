import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/bounds/shared_content_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/network/shared_content_network_port.dart';

import 'shared_content_repo.dart';

base class SharedContentRepoImpl implements SharedContentRepo {
  final SharedContentNetworkPort port;

  SharedContentRepoImpl({required this.port});

  @override
  Stream<Resource<SharedContentDto>> sharedContent() {
    return SharedContentNetworkBounds(port: port).call();
  }
}
