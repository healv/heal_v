import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class JournalNetworkPort {
  Future<ApiWrapper<List<JournalHistoryDto>?>> journalHistory();
}
