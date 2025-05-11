import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/put_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/packet/put_journal_packet.dart';

import '../model/delete_journal_dto.dart';

abstract interface class JournalRepo {
  Stream<Resource<List<JournalHistoryDto>>> getJournalHistory();

  Stream<Resource<PutJournalDto?>> putJournal(String date,PutJournalPacket putJournalPacket);

  Stream<Resource<DeleteJournalDto?>> deleteJournal(String date);
}
