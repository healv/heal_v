import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/journal/bounds/delete_journal_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/journal/bounds/journal_history_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/journal/bounds/put_journal_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/delete_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/put_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/network/journal_network_port.dart';
import 'package:heal_v/feature/heal_v/api/journal/packet/put_journal_packet.dart';

import 'journal_repo.dart';

base class JournalRepoImpl implements JournalRepo {
  final JournalNetworkPort port;

  JournalRepoImpl({required this.port});

  @override
  Stream<Resource<List<JournalHistoryDto>>> getJournalHistory() {
    return JournalHistoryNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<PutJournalDto?>> putJournal(String date, PutJournalPacket putJournalPacket) {
    return PutJournalNetworkBounds(port: port, date: date, putJournalPacket: putJournalPacket).call();
  }

  @override
  Stream<Resource<DeleteJournalDto?>> deleteJournal(String date) {
    return DeleteJournalNetworkBounds(port: port, date: date).call();
  }
}
