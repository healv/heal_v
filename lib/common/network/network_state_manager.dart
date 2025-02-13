import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:heal_v/common/bloc/base_state.dart';

class NetworkState extends BaseState {
  final bool? isOnline;
  final bool? isNetworkReconnected;

  const NetworkState._({this.isOnline, this.isNetworkReconnected});

  factory NetworkState.initial() => const NetworkState._();

  NetworkState changedState({
    required bool? isOnline,
    required bool? isNetworkReconnected,
  }) {
    return NetworkState._(
      isOnline: isOnline,
      isNetworkReconnected: isNetworkReconnected,
    );
  }

  NetworkState onNetworkReconnected({
    required bool? isNetworkReconnected,
  }) {
    return NetworkState._(
      isNetworkReconnected: isNetworkReconnected,
      isOnline: isOnline,
    );
  }

  @override
  List<Object?> get props => [isOnline, isNetworkReconnected];
}

final class NetworkStateManager {
  NetworkState _state = NetworkState.initial();

  NetworkState get state => _state;

  final _connectivity = Connectivity();

  late Stream<NetworkState> networkStateStream = _connectivity.onConnectivityChanged.asBroadcastStream().transform<NetworkState>(messageTransformer);

  late StreamTransformer<List<ConnectivityResult>, NetworkState> messageTransformer = StreamTransformer.fromHandlers(
    handleData: _transformData,
  );

  Stream<NetworkState> get states => networkStateStream.asBroadcastStream();

  NetworkStateManager._();

  static final NetworkStateManager _instance = NetworkStateManager._();

  factory NetworkStateManager() => _instance;

  void _transformData(List<ConnectivityResult> connectivityResult, EventSink sink) {
    switch (connectivityResult[0]) {
      case ConnectivityResult.none:
        _state = _state.changedState(isOnline: false, isNetworkReconnected: false);
      default:
        _state = _state.changedState(isOnline: true, isNetworkReconnected: state.isNetworkReconnected != null);
    }
    sink.add(_state);
  }

  Future<bool> isNetworkAvailable() async {
    final connectivityResult = await (_connectivity.checkConnectivity());
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  void close() {}
}
