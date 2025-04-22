import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/widgets/media/audio_player_widget_bloc.dart';
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

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: _progressBar(context)),
        const SizedBox(height: 30),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: _playerControl(context)),
        const SizedBox(height: 46),
      ],
    );
  }

  Widget _progressBar(BuildContext context) {
    return BlocBuilder<AudioPlayerWidgetBloc, AudioPlayerWidgetState>(
      buildWhen: (oldState, newState) => oldState.duration != newState.duration || oldState.position != newState.position || oldState.buffer != newState.buffer,
      builder: (context, state) {
        return ProgressBar(
          barHeight: 5,
          baseBarColor: context.quizDialogItemColor,
          progressBarColor: context.primary,
          thumbColor: context.primary,
          thumbRadius: 3.0,
          buffered: state.buffer,
          bufferedBarColor: context.background,
          timeLabelTextStyle: TextStyle(fontSize: 12, color: context.primary, letterSpacing: 0.2, fontWeight: FontWeight.w400),
          progress: state.position ?? const Duration(),
          total: state.duration ?? const Duration(),
          timeLabelPadding: 0,
          timeLabelLocation: TimeLabelLocation.above,
          onSeek: (position) {
            context.read<AudioPlayerWidgetBloc>().add(AudioPlayerWidgetEvent.progressSeek(position));
          },
        );
      },
    );
  }

  Widget _playerControl(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _volume(context),
        _replay10(context),
        _playPause(context),
        _forward10(context),
        _shuffle(context),
      ],
    );
  }

  Widget _volume(BuildContext context) {
    final audioPlayerWidgetBloc = context.read<AudioPlayerWidgetBloc>();
    return BlocSelector<AudioPlayerWidgetBloc, AudioPlayerWidgetState, double?>(
      selector: (AudioPlayerWidgetState state) => state.volume,
      builder: (BuildContext context, double? volume) {
        return IconButton(
          onPressed: () {
            audioPlayerWidgetBloc.add(AudioPlayerWidgetEvent.changeVolumeState(volume != 0.0));
          },
          icon: volume == 0.0 ? AppIcons.volumeOn.svgAsset(width: 26, height: 20) : AppIcons.volumeOff.svgAsset(width: 26, height: 20),
        );
      },
    );
  }

  Widget _replay10(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AudioPlayerWidgetBloc>().add(AudioPlayerWidgetEvent.replay10Seconds());
      },
      icon: AppIcons.replay10.svgAsset(width: 26, height: 20),
    );
  }

  Widget _playPause(BuildContext context) {
    final audioPlayerWidgetBloc = context.read<AudioPlayerWidgetBloc>();
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0XFFC7C8C2),
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
            },
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                child: playerState?.playing == true
                    ? AppIcons.pause.svgAsset(
                        colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn),
                        width: 26,
                        height: 20,
                      )
                    : AppIcons.play.svgAsset(
                        colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn),
                        width: 26,
                        height: 20,
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
      icon: AppIcons.forward10.svgAsset(width: 26, height: 20),
    );
  }

  // todo need to understand
  Widget _shuffle(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: AppIcons.shuffle.svgAsset(width: 20, height: 20),
    );
  }
}
