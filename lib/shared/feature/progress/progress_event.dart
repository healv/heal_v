part of 'progress_bloc.dart';

sealed class ProgressEvent extends BaseEvent {
  const ProgressEvent();

  factory ProgressEvent.initial() => Initial._();

  factory ProgressEvent.getDailyProgress({String? date}) => GetDailyProgress._(date);

  factory ProgressEvent.getTreeGrowth() => GetTreeGrowth._();

  factory ProgressEvent.updateDailyProgress({
    String? date,
    DailyProgressRequest? dailyProgressRequest,
  }) =>
      UpdateDailyProgress._(date, dailyProgressRequest);

  factory ProgressEvent.getDailyProgressList({
    String? startDate,
    String? endDate,
    int? page,
    int? pageSize,
  }) =>
      GetDailyProgressList._(startDate: startDate, endDate: endDate, page: page, pageSize: pageSize);
}

class Initial extends ProgressEvent {
  Initial._();
}

class GetDailyProgress extends ProgressEvent {
  String? date;

  GetDailyProgress._(this.date);
}

class GetTreeGrowth extends ProgressEvent {
  GetTreeGrowth._();
}

class UpdateDailyProgress extends ProgressEvent {
  String? date;
  DailyProgressRequest? dailyProgressRequest;

  UpdateDailyProgress._(this.date, this.dailyProgressRequest);
}

class GetDailyProgressList extends ProgressEvent {
  final String? startDate;
  final String? endDate;
  final int? page;
  final int? pageSize;

  GetDailyProgressList._({
    required this.startDate,
    required this.endDate,
    required this.page,
    required this.pageSize,
  });
}
