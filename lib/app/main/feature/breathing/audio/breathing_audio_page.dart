import 'dart:async';

import 'package:flutter/material.dart' show AppBar, Colors, IconButton, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/breathing/audio/breathing_audio_page_bloc.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/media/audio_player_widget_bloc.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/flutter/widgets/framework.dart';
import '../../../../../common/widgets/media/audio_player_widget.dart';

class BreathingAudioPage extends StatefulWidget {
  final MeditationBreathing breathing;

  const BreathingAudioPage({super.key, required this.breathing});

  @override
  State<StatefulWidget> createState() => _BreathingAudioPageState();
}

class _BreathingAudioPageState extends BlocDependentSideEffectState<BreathingAudioPage, BreathingAudioPageBloc, BreathingAudioPageSideEffect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.background),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: AppIcons.heart.svgAsset(width: 24, height: 24),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox.expand(child: _image(widget.breathing.photoUrl?.first.downloadURL, widget.breathing.demoImage ?? emptyString)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BlocProvider<AudioPlayerWidgetBloc>(
                create: (BuildContext context) => AudioPlayerWidgetBloc()
                  ..add(
                    AudioPlayerWidgetEvent.initial(widget.breathing),
                  ),
                child: const AudioPlayerWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(String? imageUrl, String demoUrl) {
    return imageUrl != null || imageUrl?.isNotEmpty == true
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(key: ValueKey(demoUrl), demoUrl, width: double.infinity, height: 140, fit: BoxFit.cover),
          );
  }

  @override
  Future<void> handleSideEffect(BreathingAudioPageSideEffect effect) {
    switch (effect) {}
  }
}
