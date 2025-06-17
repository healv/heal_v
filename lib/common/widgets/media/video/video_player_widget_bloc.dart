import 'dart:developer';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:better_player_plus/src/video_player/video_player_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../dart/optional.dart';

part 'video_player_widget_event.dart';
part 'video_player_widget_state.dart';

class VideoPlayerWidgetBloc extends BaseBloc<VideoPlayerWidgetEvent, VideoPlayerWidgetState> {
  final controller = BetterPlayerController(
    const BetterPlayerConfiguration(
      aspectRatio: 1,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        showControls: false,
      ),
    ),
  );

  VideoPlayerWidgetBloc() : super(VideoPlayerWidgetState.initial()) {
    listenToControllerEvents();
    listenToVolumeStatChange();
    on<_Initial>(_handleInitialEvent);
    on<_PositionChanged>(_handlePositionChangedEvent);
    on<_DurationChanged>(_handleDurationChangedEvent);
    on<_BufferChanged>(_handleBufferChangedEvent);
    on<_IsPlayingChanged>(_handleIsPlayingChangedEvent);
    on<_ProgressSeek>(_handleProgressSeekEvent);
    on<_ChangeControllerVolume>(_handleChangeControllerVolumeEvent);
    on<_ChangeVolumeState>(_handleChangeVolumeStateEvent);
    on<_Replay10Seconds>(_handleReplay10SecondsEvent);
    on<_Forward10Seconds>(_handleForward10SecondsEvent);
    on<_Play>(_handlePlayEvent);
    on<_Pause>(_handlePauseEvent);
    on<_EnterFullScreen>(_handleEnterFullScreenEvent);
  }

  void listenToControllerEvents() {
    controller.addEventsListener((event) async {
      switch (event.betterPlayerEventType) {
        case BetterPlayerEventType.progress:
          final progress = controller.videoPlayerController?.value.position;
          if (progress != null) {
            add(VideoPlayerWidgetEvent.positionChanged(progress));
          }
          break;
        case BetterPlayerEventType.play:
          add(VideoPlayerWidgetEvent.isPlayingChanged(true));
          break;
        case BetterPlayerEventType.pause:
          add(VideoPlayerWidgetEvent.isPlayingChanged(false));
          break;
        case BetterPlayerEventType.bufferingUpdate:
          log("BetterPlayerEventType.bufferingUpdate:${event.parameters?["buffered"]}");
          final bufferedRanges = event.parameters?["buffered"] as List<DurationRange>;
          if (bufferedRanges.isNotEmpty) {
            add(VideoPlayerWidgetEvent.bufferChanged(bufferedRanges.last.end));
          }
          break;
        case BetterPlayerEventType.finished:
          add(VideoPlayerWidgetEvent.isPlayingChanged(false));
          await controller.seekTo(Duration.zero);
          await controller.pause();
          break;
        case BetterPlayerEventType.setVolume:
          add(VideoPlayerWidgetEvent.changeVolumeState(event.parameters?["volume"] as double));
          break;
        case BetterPlayerEventType.openFullscreen:
          controller.setBetterPlayerControlsConfiguration(const BetterPlayerControlsConfiguration(showControls: true));
          break;
        case BetterPlayerEventType.hideFullscreen:
          controller.setBetterPlayerControlsConfiguration(const BetterPlayerControlsConfiguration(showControls: false));
          break;
        default:
          break;
      }
    });
  }

  void listenToVolumeStatChange() {
    VolumeController.instance.addListener((data) async {
      await controller.setVolume(data);
    });
  }

  Future<void> _handleInitialEvent(_Initial event, Emitter<VideoPlayerWidgetState> emitter) async {
    final url = event.url ?? emptyString;
    // final url = 'https://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_640x360.m4v';
    emitter(state.copyWith(url: Optional.value(url), duration: Optional.value(event.duration)));
    await controller.setupDataSource(BetterPlayerDataSource.network(url));
    await controller.play();
  }

  Future<void> _handlePositionChangedEvent(_PositionChanged event, Emitter<VideoPlayerWidgetState> emitter) async {
    emitter(state.copyWith(position: Optional.value(event.position)));
  }

  Future<void> _handleDurationChangedEvent(_DurationChanged event, Emitter<VideoPlayerWidgetState> emitter) async {
    emitter(state.copyWith(duration: Optional.value(event.duration)));
  }

  Future<void> _handleBufferChangedEvent(_BufferChanged event, Emitter<VideoPlayerWidgetState> emitter) async {
    emitter(state.copyWith(buffer: Optional.value(event.buffer)));
  }

  Future<void> _handleIsPlayingChangedEvent(_IsPlayingChanged event, Emitter<VideoPlayerWidgetState> emitter) async {
    emitter(state.copyWith(isPlaying: Optional.value(event.isPlaying)));
  }

  Future<void> _handleProgressSeekEvent(_ProgressSeek event, Emitter<VideoPlayerWidgetState> emitter) async {
    await controller.seekTo(event.position);
  }

  Future<void> _handleChangeControllerVolumeEvent(_ChangeControllerVolume event, Emitter<VideoPlayerWidgetState> emitter) async {
    switch (event.mute) {
      case true:
        await controller.setVolume(0.0);
        break;
      case false:
        await controller.setVolume(1.0);
        break;
    }
  }

  Future<void> _handleChangeVolumeStateEvent(_ChangeVolumeState event, Emitter<VideoPlayerWidgetState> emitter) async {
    emitter(state.copyWith(volume: Optional.value(event.volume)));
  }

  Future<void> _handleReplay10SecondsEvent(_Replay10Seconds event, Emitter<VideoPlayerWidgetState> emitter) async {
    final position = await controller.videoPlayerController?.position ?? Duration.zero;
    if (position.inSeconds < 15) {
      await controller.seekTo(Duration.zero);
    } else {
      await controller.seekTo(Duration(seconds: position.inSeconds - 10));
    }
  }

  Future<void> _handleForward10SecondsEvent(_Forward10Seconds event, Emitter<VideoPlayerWidgetState> emitter) async {
    final duration = controller.videoPlayerController?.value.duration ?? Duration.zero;
    final position = await controller.videoPlayerController?.position ?? Duration.zero;
    if ((duration.inSeconds) - position.inSeconds < 10) {
      await controller.seekTo(duration);
    } else {
      await controller.seekTo(Duration(seconds: position.inSeconds + 10));
    }
  }

  Future<void> _handlePlayEvent(_Play event, Emitter<VideoPlayerWidgetState> emitter) async {
    await controller.play();
  }

  Future<void> _handlePauseEvent(_Pause event, Emitter<VideoPlayerWidgetState> emitter) async {
    await controller.pause();
  }

  Future<void> _handleEnterFullScreenEvent(_EnterFullScreen event, Emitter<VideoPlayerWidgetState> emitter) async {
    controller.enterFullScreen();
  }

  @override
  Future<void> close() {
    controller.dispose();
    VolumeController.instance.removeListener();
    return super.close();
  }
}
