import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/widgets/media/audio/audio_player_widget_bloc.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerWidgetState();
  }
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> with WidgetsBindingObserver, TickerProviderStateMixin {
  late final AnimationController _playPauseController;
  late final AnimationController _repeatController;
  late final Animation<double> _playPauseRotation;
  late final Animation<double> _repeatRotation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _playPauseController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _repeatController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _repeatRotation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _repeatController,
      curve: Curves.easeInOut,
    ));
    _playPauseRotation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _playPauseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state != AppLifecycleState.resumed) {
      if (mounted) {
        context.read<AudioPlayerWidgetBloc>().add(AudioPlayerWidgetEvent.pause());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerWidgetBloc = context.read<AudioPlayerWidgetBloc>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _progressBar(context),
        const SizedBox(height: 20),
        _playerControl(context, audioPlayerWidgetBloc),
        const SizedBox(height: 29),
      ],
    );
  }

  Widget _progressBar(BuildContext context) {
    return BlocBuilder<AudioPlayerWidgetBloc, AudioPlayerWidgetState>(
      buildWhen: (oldState, newState) => oldState.duration != newState.duration || oldState.position != newState.position || oldState.buffer != newState.buffer,
      builder: (context, state) {
        return ProgressBar(
          barHeight: 6,
          baseBarColor: context.quizDialogItemColor,
          progressBarColor: context.primary,
          thumbColor: context.primary,
          thumbRadius: 3.0,
          buffered: state.buffer,
          bufferedBarColor: context.background.withValues(alpha: 0.5),
          timeLabelTextStyle: TextStyle(fontSize: 12, color: context.onBackground, letterSpacing: 0.2, fontWeight: FontWeight.w400),
          progress: state.position ?? const Duration(),
          total: state.duration ?? const Duration(),
          timeLabelPadding: 8,
          timeLabelLocation: TimeLabelLocation.below,
          onSeek: (position) {
            context.read<AudioPlayerWidgetBloc>().add(AudioPlayerWidgetEvent.progressSeek(position));
          },
        );
      },
    );
  }

  Widget _playerControl(BuildContext context, AudioPlayerWidgetBloc audioPlayerWidgetBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _volume(context, audioPlayerWidgetBloc),
        _replay10(context),
        _playPause(context, audioPlayerWidgetBloc),
        _forward10(context),
        _repeat(context, audioPlayerWidgetBloc),
      ],
    );
  }

  Widget _volume(BuildContext context, AudioPlayerWidgetBloc audioPlayerWidgetBloc) {
    return BlocSelector<AudioPlayerWidgetBloc, AudioPlayerWidgetState, double?>(
      selector: (AudioPlayerWidgetState state) => state.volume,
      builder: (BuildContext context, double? volume) {
        return IconButton(
          onPressed: () {
            audioPlayerWidgetBloc.add(AudioPlayerWidgetEvent.changeVolumeState(volume != 0.0));
          },
          icon: volume == 0.0
              ? AppIcons.volumeOff.svgAsset(
                  width: 26,
                  height: 20,
                  colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn),
                )
              : AppIcons.volumeOn.svgAsset(
                  width: 26,
                  height: 20,
                  colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn),
                ),
        );
      },
    );
  }

  Widget _replay10(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AudioPlayerWidgetBloc>().add(AudioPlayerWidgetEvent.replay10Seconds());
      },
      icon: AppIcons.replay10.svgAsset(width: 26, height: 20, colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn)),
    );
  }

  Widget _playPause(BuildContext context, AudioPlayerWidgetBloc audioPlayerWidgetBloc) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.primary,
      ),
      child: BlocSelector<AudioPlayerWidgetBloc, AudioPlayerWidgetState, PlayerState?>(
        selector: (state) => state.playerState,
        builder: (BuildContext context, playerState) {
          return InkWell(
            onTap: () {
              if (playerState?.playing == true) {
                audioPlayerWidgetBloc.add(AudioPlayerWidgetEvent.pause());
              } else {
                audioPlayerWidgetBloc.add(AudioPlayerWidgetEvent.play());
              }
              _playPauseController.forward(from: 0);
            },
            child: Center(
              child: RotationTransition(
                turns: _playPauseRotation,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: playerState?.playing == true
                      ? AppIcons.pause.svgAsset(
                          colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn),
                          width: 20,
                          height: 26,
                        )
                      : AppIcons.play.svgAsset(
                          colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn),
                          width: 20,
                          height: 26,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _forward10(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AudioPlayerWidgetBloc>().add(AudioPlayerWidgetEvent.forward10Seconds());
      },
      icon: AppIcons.forward10.svgAsset(width: 26, height: 20, colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn)),
    );
  }

  Widget _repeat(BuildContext context, AudioPlayerWidgetBloc audioPlayerWidgetBloc) {
    return BlocSelector<AudioPlayerWidgetBloc, AudioPlayerWidgetState, LoopMode?>(
      selector: (AudioPlayerWidgetState state) => state.loopMode,
      builder: (BuildContext context, LoopMode? loopMode) {
        return RotationTransition(
          turns: _repeatRotation,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              onPressed: () {
                _repeatController.forward(from: 0);
                audioPlayerWidgetBloc.add(AudioPlayerWidgetEvent.changeLoopMode(loopMode == LoopMode.one ? LoopMode.all : LoopMode.one));
              },
              icon: loopMode == LoopMode.one
                  ? AppIcons.repeat.svgAsset(
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn),
                    )
                  : Stack(
                      children: [
                        Positioned(
                          child: AppIcons.repeat.svgAsset(
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn),
                          ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: context.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _repeatController.dispose();
    _playPauseController.dispose();
  }
}
