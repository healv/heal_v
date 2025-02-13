import 'package:equatable/equatable.dart';

enum ResourceStatusEnum {
  success,
  error,
  loading;

  bool get isSuccess => (this == ResourceStatusEnum.success);
}

class Resource<T> extends Equatable {
  final ResourceStatusEnum status;
  final Exception? error;
  final T? data;

  const Resource({required this.status, this.data, this.error});

  @override
  List<Object?> get props => [status, error, data];

  factory Resource.success(T? data) => Resource(status: ResourceStatusEnum.success, data: data);

  factory Resource.error({Exception? error, T? data}) => Resource(status: ResourceStatusEnum.error, data: data, error: error);

  factory Resource.loading() => const Resource(status: ResourceStatusEnum.loading);
}
