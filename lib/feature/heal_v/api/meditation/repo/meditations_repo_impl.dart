import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/meditation/bounds/meditations_categories_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/bounds/meditations_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';
import 'package:heal_v/feature/heal_v/api/meditation/repo/meditations_repo.dart';

base class MeditationsRepoImpl implements MeditationsRepo {
  final MeditationsNetworkPort port;

  MeditationsRepoImpl({required this.port});

  @override
  Stream<Resource<MeditationBreathings>> meditations() {
    return MeditationsNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<List<MeditationsCategoriesDto>>> meditationsCategories() {
    return MeditationsCategoriesNetworkBounds(port: port).call();
  }
}
