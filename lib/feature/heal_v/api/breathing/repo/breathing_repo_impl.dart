import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/breathing/bounds/breathings_categories_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/bounds/breathings_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';
import 'package:heal_v/feature/heal_v/api/breathing/repo/breathing_repo.dart';

base class BreathingsRepoImpl implements BreathingsRepo {
  final BreathingsNetworkPort port;

  BreathingsRepoImpl({required this.port});

  @override
  Stream<Resource<MeditationBreathings>> breathing() {
    return BreathingsNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<List<BreathingsCategoriesDto>>> breathingCategories() {
    return BreathingsCategoriesNetworkBounds(port: port).call();
  }
}
