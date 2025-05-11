import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/put_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/network/journal_network_port.dart';
import 'package:heal_v/feature/heal_v/api/journal/packet/put_journal_packet.dart';

class PutJournalNetworkBounds extends HttpBounds<PutJournalDto, ApiWrapper<PutJournalDto?>> {
  final JournalNetworkPort port;
  final String date;
  final PutJournalPacket putJournalPacket;

  PutJournalNetworkBounds({required this.port, required this.date, required this.putJournalPacket});

  @override
  Future<ApiWrapper<PutJournalDto?>?> fetchFromNetwork() {
    return port.putJournal(date, putJournalPacket);
  }

  @override
  Future<PutJournalDto?> processResponse(ApiWrapper<PutJournalDto?>? response, {PutJournalDto? data}) async {
    return switch (response) {
      Success<PutJournalDto?>() => response.value,
      _ => data,
    };
  }
}
