import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/delete_journal_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/network/journal_network_port.dart';

class DeleteJournalNetworkBounds extends HttpBounds<DeleteJournalDto, ApiWrapper<DeleteJournalDto?>> {
  final JournalNetworkPort port;
  final String date;

  DeleteJournalNetworkBounds({required this.port, required this.date});

  @override
  Future<ApiWrapper<DeleteJournalDto?>?> fetchFromNetwork() {
    return port.deleteJournal(date);
  }

  @override
  Future<DeleteJournalDto?> processResponse(ApiWrapper<DeleteJournalDto?>? response, {DeleteJournalDto? data}) async {
    return switch (response) {
      Success<DeleteJournalDto?>() => response.value,
      _ => data,
    };
  }
}
