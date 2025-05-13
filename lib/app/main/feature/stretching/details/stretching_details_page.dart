import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/stretching/details/stretching_details_page_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/tools/localization_tools.dart';

class StretchingDetailsPage extends StatefulWidget {
  const StretchingDetailsPage({super.key});

  @override
  State<StatefulWidget> createState() => _StretchingDetailsPageState();
}

class _StretchingDetailsPageState extends State<StretchingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 40,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.unselectedItemColor,
              ),
              child: Center(
                child: AppIcons.arrowLeft.svgAsset(colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn)),
              ),
            ),
          ),
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<StretchingDetailsPageBloc, StretchingDetailsPageState>(
      buildWhen: (oldState, newState) => oldState.stretchingLesson != newState.stretchingLesson,
      builder: (BuildContext context, StretchingDetailsPageState? state) {
        return state?.stretchingLesson == null
            ? const SizedBox.shrink()
            : Stack(
                children: [
                  _image(context, state!.stretchingLesson!),
                  _bottomColumn(context, state.stretchingLesson!, state.weekTitle ?? emptyString),
                ],
              );
      },
    );
  }

  Widget _image(BuildContext context, StretchingLesson stretchingLesson) {
    return Image.network(
      height: MediaQuery.of(context).size.height * 0.50,
      // todo Remove hardcoded photo
      'https://media.istockphoto.com/id/1310511832/photo/asian-woman-stretching-her-back-in-a-training-gym.jpg?s=1024x1024&w=is&k=20&c=mPm3qGkYFAts-30ewEZ9HiIUB_ZUE7ZXNPJZh-ygq3s=',
      fit: BoxFit.cover,
    );
  }

  Widget _bottomColumn(BuildContext context, StretchingLesson stretchingLesson, String weekTitle) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 32),
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          color: context.background,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleText(context, stretchingLesson),
                    const SizedBox(height: 8),
                    _descriptionText(context, stretchingLesson),
                    const SizedBox(height: 24),
                    _infoRow(context, stretchingLesson, weekTitle),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _startButton(context, stretchingLesson),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleText(BuildContext context, StretchingLesson? stretchingLesson) {
    return Text(
      stretchingLesson?.title ?? emptyString,
      style: TextStyle(
        color: context.onBackground,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _descriptionText(BuildContext context, StretchingLesson? stretchingLesson) {
    return Text(
      // stretchingLesson?.description ?? emptyString,
      emptyString,
      style: TextStyle(
        color: context.onBackground,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _infoRow(BuildContext context, StretchingLesson? stretchingLesson, String weekTitle) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _infoItemWeek(context, stretchingLesson, weekTitle),
        _infoItemDuration(context, stretchingLesson),
      ],
    );
  }

  Widget _infoItemWeek(BuildContext context, StretchingLesson? stretchingLesson, String weekTitle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.pink.shade100,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppIcons.calendar.svgAsset(width: 20, height: 22),
            const SizedBox(height: 8),
            Text(
              weekTitle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                color: Colors.pink.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItemDuration(BuildContext context, StretchingLesson? stretchingLesson) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.pink.shade100,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppIcons.clock.svgAsset(width: 20, height: 22),
            const SizedBox(height: 8),
            Text(
              '${stretchingLesson?.duration ?? zero} ${tr('mins')}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                color: Colors.pink.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _startButton(BuildContext context, StretchingLesson? stretchingLesson) {
    return ElevatedButton(
      onPressed: () {
        StretchingVideoRoute(stretchingLesson: jsonEncode(stretchingLesson)).push(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: context.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 0,
        minimumSize: Size(MediaQuery.of(context).size.width, 56),
      ),
      child: Text(tr('start'),
          style: TextStyle(
            color: context.background,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          )),
    );
  }
}
