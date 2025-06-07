import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/quiz/quiz_page_bloc.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/common/widgets/progress_bar/segment_progress_bar.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/flutter/widgets/framework.dart';
import '../../../../common/tools/localization_tools.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends BlocDependentSideEffectState<QuizPage, QuizPageBloc, QuizPageSideEffect> {
  final TextEditingController lastQuestionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.simple(title: tr('dailyQuiz')),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 48.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _questionsColumn(context),
          _buttonsRow(context),
        ],
      ),
    );
  }

  Widget _questionsColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _currentQuestionIndexText(context),
        const SizedBox(height: 8),
        _segmentProgressBar(context),
        const SizedBox(height: 8),
        _infoText(context),
      ],
    );
  }

  Widget _currentQuestionIndexText(BuildContext context) {
    return BlocBuilder<QuizPageBloc, QuizPageState>(
      buildWhen: (oldState, newState) => oldState.quiz != newState.quiz || oldState.currentQuestionIndex != newState.currentQuestionIndex,
      builder: (BuildContext context, QuizPageState state) {
        return Text(
          '${tr('question')} ${state.currentQuestionIndex + 1} ${tr('of')} ${state.quiz?.questions?.length ?? 1}',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: context.primary,
          ),
        );
      },
    );
  }

  Widget _segmentProgressBar(BuildContext context) {
    return BlocBuilder<QuizPageBloc, QuizPageState>(
      buildWhen: (oldState, newState) => oldState.currentQuestionIndex != newState.currentQuestionIndex || oldState.quiz != newState.quiz,
      builder: (BuildContext context, QuizPageState state) {
        return SegmentProgressBar(
          itemCount: state.quiz?.questions?.length ?? 1,
          activeIndex: state.currentQuestionIndex - 1,
          activeColor: context.primary,
          inActiveColor: context.quizDialogItemColor,
        );
      },
    );
  }

  Widget _infoText(BuildContext context) {
    return Text(
      '*${tr('thisInformationWillNotBeSharedWithAnyone')}',
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: context.primary,
      ),
    );
  }

  Widget _buttonsRow(BuildContext context) {
    return BlocBuilder<QuizPageBloc, QuizPageState>(
      buildWhen: (oldState, newState) => oldState.currentQuestionIndex != newState.currentQuestionIndex,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: state.currentQuestionIndex == 0
                    ? null
                    : () async {
                        Navigator.of(context).pop();
                      },
                style: OutlinedButton.styleFrom(
                  backgroundColor: context.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: context.onBackground.withValues(alpha: 0.2),
                    ),
                  ),
                  elevation: 0,
                  minimumSize: const Size(129, 36),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppIcons.arrowLeft.svgAsset(
                      width: 7.35,
                      height: 13.33,
                      colorFilter: ColorFilter.mode(
                        context.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(tr('back'),
                        style: TextStyle(
                          color: context.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: state.currentQuestionIndex == (state.quiz?.questions?.length ?? 0) - 1 && lastQuestionTextController.text.isEmpty ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  minimumSize: const Size(129, 36),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      state.currentQuestionIndex == (state.quiz?.questions?.length ?? 0) - 1 ? tr('complete') : tr('next'),
                      style: TextStyle(
                        color: context.background,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    AppIcons.arrowRight.svgAsset(
                      width: 7.35,
                      height: 13.33,
                      colorFilter: ColorFilter.mode(
                        context.background,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> handleSideEffect(QuizPageSideEffect effect) {
    switch (effect) {}
  }

  @override
  void dispose() {
    super.dispose();
    lastQuestionTextController.dispose();
  }
}
