import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:just_audio/just_audio.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../../app/main/feature/common/model/meditation_breathing_ui_model.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../dart/optional.dart';

part 'audio_player_widget_event.dart';
part 'audio_player_widget_state.dart';

class AudioPlayerWidgetBloc extends BaseBloc<AudioPlayerWidgetEvent, AudioPlayerWidgetState> {
  final _player = AudioPlayer();

  AudioPlayerWidgetBloc() : super(AudioPlayerWidgetState.initial()) {
    on<_Initial>(_handleInitialEvent);
    on<_SubscribeToPosition>(_handleSubscribeToPositionEvent);
    on<_SubscribeToDuration>(_handleSubscribeToDurationEvent);
    on<_SubscribeToBuffer>(_handleSubscribeToBufferEvent);
    on<_SubscribeToPlayerState>(_handleSubscribeToPlayerStateEvent);
    on<_ProgressSeek>(_handleProgressSeekEvent);
    on<_Play>(_handlePlayEvent);
    on<_Pause>(_handlePauseEvent);
    on<_Forward10Seconds>(_handleForward10SecondsEvent);
    on<_Replay10Seconds>(_handleReplay10SecondsEvent);
    on<_ChangeVolumeState>(_handleChangeVolumeStateEvent);
    on<_SubscribeToVolumeState>(_handleSubscribeVolumeStateEvent);
  }

  Future<void> _handleInitialEvent(_Initial event, Emitter<AudioPlayerWidgetState> emitter) async {
    await _player.setUrl(event.item.audioUrl?.first.downloadURL ?? emptyString);
    emitter(state.copyWith(
      item: Optional.value(event.item),
      duration: Optional.value(_player.duration),
    ));
    add(AudioPlayerWidgetEvent.subscribeToPlayerState());
    add(AudioPlayerWidgetEvent.subscribeToPosition());
    add(AudioPlayerWidgetEvent.subscribeToDuration());
    add(AudioPlayerWidgetEvent.subscribeToBuffer());
    add(AudioPlayerWidgetEvent.subscribeToVolumeState());
    await _player.play();
  }

  Future<void> _handleSubscribeToPositionEvent(_SubscribeToPosition event, Emitter<AudioPlayerWidgetState> emitter) async {
    await emitter.forEach(_player.positionStream, onData: (duration) {
      return state.copyWith(position: Optional.value(duration));
    });
  }

  Future<void> _handleSubscribeToDurationEvent(_SubscribeToDuration event, Emitter<AudioPlayerWidgetState> emitter) async {
    await emitter.forEach(_player.durationStream, onData: (duration) {
      return state.copyWith(duration: Optional.value(duration));
    });
  }

  Future<void> _handleSubscribeToBufferEvent(_SubscribeToBuffer event, Emitter<AudioPlayerWidgetState> emitter) async {
    await emitter.forEach(_player.bufferedPositionStream, onData: (duration) {
      return state.copyWith(buffer: Optional.value(duration));
    });
  }

  Future<void> _handleSubscribeToPlayerStateEvent(_SubscribeToPlayerState event, Emitter<AudioPlayerWidgetState> emitter) async {
    await emitter.forEach(_player.playerStateStream, onData: (playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _player.pause();
        _player.seek(Duration.zero);
      }
      log("AUDIO_PLAYER_STATE_CHANGED: $playerState");
      return state.copyWith(playerState: Optional.value(playerState));
    });
  }

  Future<void> _handleProgressSeekEvent(_ProgressSeek event, Emitter<AudioPlayerWidgetState> emitter) async {
    await _player.seek(event.position);
  }

  Future<void> _handlePlayEvent(_Play event, Emitter<AudioPlayerWidgetState> emitter) async {
    await _player.play();
  }

  Future<void> _handlePauseEvent(_Pause event, Emitter<AudioPlayerWidgetState> emitter) async {
    await _player.pause();
  }

  Future<void> _handleForward10SecondsEvent(_Forward10Seconds event, Emitter<AudioPlayerWidgetState> emitter) async {
    if ((_player.duration?.inSeconds ?? 0) - _player.position.inSeconds < 10) {
      await _player.seek(_player.duration);
    } else {
      await _player.seek(Duration(seconds: _player.position.inSeconds + 10));
    }
  }

  Future<void> _handleReplay10SecondsEvent(_Replay10Seconds event, Emitter<AudioPlayerWidgetState> emitter) async {
    if (_player.position.inSeconds < 15) {
      await _player.seek(Duration.zero);
    } else {
      await _player.seek(Duration(seconds: _player.position.inSeconds - 10));
    }
  }

  Future<void> _handleChangeVolumeStateEvent(_ChangeVolumeState event, Emitter<AudioPlayerWidgetState> emitter) async {
    switch (event.mute) {
      case true:
        await _player.setVolume(0.0);
        break;
      case false:
        await _player.setVolume(1.0);
        break;
    }
  }

  Future<void> _handleSubscribeVolumeStateEvent(_SubscribeToVolumeState event, Emitter<AudioPlayerWidgetState> emitter) async {
    VolumeController.instance.addListener((data) {
      _player.setVolume(data);
    });
    await emitter.forEach(_player.volumeStream, onData: (volume) {
      log("AUDIO_PLAYER_VOLUME_CHANGED: $volume");
      return state.copyWith(volume: Optional.value(volume));
    });
  }

  @override
  Future<void> close() {
    _player.dispose();
    VolumeController.instance.removeListener();
    return super.close();
  }
}
