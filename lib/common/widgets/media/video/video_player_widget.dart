import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/widgets/media/video/video_player_widget_bloc.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerWidgetState();
  }
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> with WidgetsBindingObserver {
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
        context.read<VideoPlayerWidgetBloc>().add(VideoPlayerWidgetEvent.pause());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoPlayerWidgetBloc = context.read<VideoPlayerWidgetBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(16.0), child: BetterPlayer(controller: videoPlayerWidgetBloc.controller)),
          Column(
            children: [
              _progressBar(context, videoPlayerWidgetBloc),
              const SizedBox(height: 40),
              _playerControl(context, videoPlayerWidgetBloc),
            ],
          )
        ],
      ),
    );
  }

  Widget _progressBar(BuildContext context, VideoPlayerWidgetBloc videoPlayerWidgetBloc) {
    return BlocBuilder<VideoPlayerWidgetBloc, VideoPlayerWidgetState>(
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
          timeLabelType: TimeLabelType.remainingTime,
          timeLabelLocation: TimeLabelLocation.below,
          onSeek: (position) {
            context.read<VideoPlayerWidgetBloc>().add(VideoPlayerWidgetEvent.progressSeek(position));
          },
        );
      },
    );
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    if (d.inHours > 0) {
      return '${d.inHours}:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  Widget _playerControl(BuildContext context, VideoPlayerWidgetBloc videoPlayerWidgetBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _volume(context, videoPlayerWidgetBloc),
        _replay10(context),
        _controllerPlayPause(context, videoPlayerWidgetBloc),
        _forward10(context),
        _fullScreen(context, videoPlayerWidgetBloc),
      ],
    );
  }

  Widget _volume(BuildContext context, VideoPlayerWidgetBloc videoPlayerWidgetBloc) {
    return BlocSelector<VideoPlayerWidgetBloc, VideoPlayerWidgetState, double?>(
      selector: (VideoPlayerWidgetState state) => state.volume,
      builder: (BuildContext context, double? volume) {
        return IconButton(
          onPressed: () {
            videoPlayerWidgetBloc.add(VideoPlayerWidgetEvent.changeControllerVolume(volume != 0.0));
          },
          icon: volume == 0.0
              ? AppIcons.volumeOn.svgAsset(
                  width: 26,
                  height: 20,
                  colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn),
                )
              : AppIcons.volumeOff.svgAsset(
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
        context.read<VideoPlayerWidgetBloc>().add(VideoPlayerWidgetEvent.replay10Seconds());
      },
      icon: AppIcons.replay10.svgAsset(width: 26, height: 20, colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn)),
    );
  }

  Widget _controllerPlayPause(BuildContext context, VideoPlayerWidgetBloc videoPlayerWidgetBloc) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.primary,
      ),
      child: BlocSelector<VideoPlayerWidgetBloc, VideoPlayerWidgetState, bool?>(
        selector: (VideoPlayerWidgetState state) => state.isPlaying,
        builder: (BuildContext context, bool? isPlaying) {
          final icon = isPlaying == true ? AppIcons.pause : AppIcons.play;
          return InkWell(
            onTap: () {
              if (isPlaying == true) {
                videoPlayerWidgetBloc.add(VideoPlayerWidgetEvent.pause());
              } else {
                videoPlayerWidgetBloc.add(VideoPlayerWidgetEvent.play());
              }
            },
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: icon.svgAsset(
                  colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn),
                  width: 20,
                  height: 26,
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
        context.read<VideoPlayerWidgetBloc>().add(VideoPlayerWidgetEvent.forward10Seconds());
      },
      icon: AppIcons.forward10.svgAsset(width: 26, height: 20, colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn)),
    );
  }

  Widget _fullScreen(BuildContext context, VideoPlayerWidgetBloc videoPlayerWidgetBloc) {
    return IconButton(
      onPressed: () {
        videoPlayerWidgetBloc.add(VideoPlayerWidgetEvent.enterFullScreen());
      },
      icon: AppIcons.fullScreen.svgAsset(width: 26, height: 20, colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn)),
    );
  }
}
