import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/network/journal_network_port.dart';

class JournalHistoryNetworkBounds extends HttpBounds<List<JournalHistoryDto>, ApiWrapper<List<JournalHistoryDto>?>> {
  final JournalNetworkPort port;

  JournalHistoryNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<List<JournalHistoryDto>?>?> fetchFromNetwork() {
    return port.journalHistory();
  }

  @override
  Future<List<JournalHistoryDto>?> processResponse(ApiWrapper<List<JournalHistoryDto>?>? response, {List<JournalHistoryDto>? data}) async {
    return switch (response) {
      Success<List<JournalHistoryDto>?>() => response.value,
      _ => data,
    };
  }
}
