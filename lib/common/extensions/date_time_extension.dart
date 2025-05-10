import 'package:easy_localization/easy_localization.dart';
import 'package:heal_v/common/utils/constants.dart';

extension DaateTimeExtension on DateTime? {
  bool isToday() => isSameDate(DateTime.now());

  bool isSameDate(DateTime? other) {
    return this?.year == other?.year && this?.month == other?.month && this?.day == other?.day;
  }

  bool? isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDate(yesterday);
  }

  String formatDate(String format) {
    final date = this;
    return date == null ? emptyString : DateFormat(format).format(date);
  }

  String hMMa() {
    return formatDate('H:mm a');
  }

  String hMM() {
    return formatDate('H:mm');
  }

  String ddMMM() {
    return formatDate('dd MMM');
  }

  String ddMMYYYY() {
    return formatDate('dd.MM.yyyy');
  }

  String mmmmYYYY() {
    return formatDate('MMMM yyyy');
  }

  String mmmmDD(){
    return formatDate('MMMM dd');
  }
}
