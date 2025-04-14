import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/journal/bounds/journal_history_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/network/journal_network_port.dart';

import 'journal_repo.dart';

base class JournalRepoImpl implements JournalRepo {
  final JournalNetworkPort port;

  JournalRepoImpl({required this.port});

  @override
  Stream<Resource<List<JournalHistoryDto>>> getJournalHistory() {
    return JournalHistoryNetworkBounds(port: port).call();
  }
}
