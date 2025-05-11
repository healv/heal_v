import 'package:heal_v/feature/heal_v/api/journal/model/delete_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/put_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/packet/put_journal_packet.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class JournalNetworkPort {
  Future<ApiWrapper<List<JournalHistoryDto>?>> journalHistory();

  Future<ApiWrapper<PutJournalDto?>> putJournal(String date, PutJournalPacket putJournalPacket);

  Future<ApiWrapper<DeleteJournalDto?>> deleteJournal(String date);
}
