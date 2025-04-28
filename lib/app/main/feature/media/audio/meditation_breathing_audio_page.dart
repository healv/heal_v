import 'dart:async';

import 'package:flutter/material.dart' show AppBar, Colors, IconButton, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/media/audio/meditation_breathing_audio_page_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/flutter/widgets/framework.dart';
import '../../../../../common/widgets/media/audio/audio_player_widget.dart';

class MeditationBreathingAudioPage extends StatefulWidget {
  const MeditationBreathingAudioPage({super.key});

  @override
  State<StatefulWidget> createState() => _MeditationBreathingAudioPageState();
}

class _MeditationBreathingAudioPageState extends BlocDependentSideEffectState<MeditationBreathingAudioPage, MeditationBreathingAudioPageBloc, MeditationBreathingAudioPageSideEffect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.onBackground),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: AppIcons.share.svgAsset(width: 20, height: 20),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _image(),
              const SizedBox(height: 24),
              _title(context),
              const SizedBox(height: 8),
              _description(context),
              const SizedBox(height: 40),
              _audioWidget(context),
              const SizedBox(height: 78),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return BlocSelector<MeditationBreathingAudioPageBloc, MeditationBreathingAudioPageState, MeditationBreathing?>(
      selector: (MeditationBreathingAudioPageState state) => state.item,
      builder: (BuildContext context, MeditationBreathing? item) {
        if (item != null) {
          final imageUrl = item.photoUrl?.first.downloadURL;
          final demoUrl = item.demoImage ?? emptyString;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 332,
            child: imageUrl != null || imageUrl?.isNotEmpty == true
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(key: ValueKey(demoUrl), demoUrl, width: double.infinity, height: 140, fit: BoxFit.cover),
                  ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _title(BuildContext context) {
    return BlocSelector<MeditationBreathingAudioPageBloc, MeditationBreathingAudioPageState, MeditationBreathing?>(
      selector: (MeditationBreathingAudioPageState state) => state.item,
      builder: (BuildContext context, MeditationBreathing? item) {
        if (item != null) {
          return Text(
            item.name ?? emptyString,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: context.onBackground,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _description(BuildContext context) {
    return BlocSelector<MeditationBreathingAudioPageBloc, MeditationBreathingAudioPageState, MeditationBreathing?>(
      selector: (MeditationBreathingAudioPageState state) => state.item,
      builder: (BuildContext context, MeditationBreathing? item) {
        if (item != null) {
          return Text(
            item.description ?? emptyString,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: context.onBackground.withValues(alpha: 0.6),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _audioWidget(BuildContext context) {
    return BlocSelector<MeditationBreathingAudioPageBloc, MeditationBreathingAudioPageState, MeditationBreathing?>(
      selector: (MeditationBreathingAudioPageState state) => state.item,
      builder: (BuildContext context, MeditationBreathing? item) {
        return item != null ? const AudioPlayerWidget() : const SizedBox.shrink();
      },
    );
  }

  @override
  Future<void> handleSideEffect(MeditationBreathingAudioPageSideEffect effect) {
    switch (effect) {}
  }
}
