import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_week_ui_model.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/stretching/bounds/stretching_lessons_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/stretching/bounds/stretching_weeks_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/stretching/network/stretching_network_port.dart';
import 'package:heal_v/feature/heal_v/api/stretching/repo/stretching_repo.dart';

base class StretchingRepoImpl implements StretchingRepo {
  final StretchingNetworkPort port;

  StretchingRepoImpl({required this.port});

  @override
  Stream<Resource<List<StretchingWeek>?>> getStretchingWeeks() {
    return StretchingWeeksNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<StretchingLessons?>> getStretchingLessons(String id) {
    return StretchingLessonsNetworkBounds(port: port, id: id).call();
  }
}
