import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';

abstract interface class JournalRepo {
  Stream<Resource<List<JournalHistoryDto>>> getJournalHistory();
}
