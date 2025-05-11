import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/delete_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/put_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/packet/put_journal_packet.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

import 'journal_network_port.dart';

base class JournalNetworkAdapter implements JournalNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  JournalNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<List<JournalHistoryDto>?>> journalHistory() {
    return parseHttpResponse<List<JournalHistoryDto>>(healVNetworkWebService.getJournalHistory, []);
  }

  @override
  Future<ApiWrapper<PutJournalDto?>> putJournal(String date, PutJournalPacket putJournalPacket) {
    return parseHttpResponse<PutJournalDto?>(healVNetworkWebService.putJournal, [date, putJournalPacket]);
  }

  @override
  Future<ApiWrapper<DeleteJournalDto?>> deleteJournal(String date) {
    return parseHttpResponse<DeleteJournalDto?>(healVNetworkWebService.deleteJournal, [date]);
  }
}
