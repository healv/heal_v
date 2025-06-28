import 'package:heal_v/app/main/feature/home/model/daily_goal_enum.dart';

import '../../../../../res/images/app_icons.dart';

class DailyGoalModel {
  final DailyGoalEnum dailyGoalEnum;
  final String title;
  final AppIcons icon;
  final bool isCompleted;

  const DailyGoalModel({required this.dailyGoalEnum, required this.title, required this.icon, required this.isCompleted});
}
