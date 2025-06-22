part of 'video_player_widget_bloc.dart';

sealed class VideoPlayerWidgetEffect implements SideEffect {
  const VideoPlayerWidgetEffect();

  factory VideoPlayerWidgetEffect.videoPlayerFinished() => VideoPlayerFinished();
}

class VideoPlayerFinished extends VideoPlayerWidgetEffect {
  VideoPlayerFinished();
}
