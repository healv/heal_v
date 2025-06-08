import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/quiz/quiz_page_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/common/widgets/progress_bar/segment_progress_bar.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/flutter/widgets/framework.dart';
import '../../../../common/tools/localization_tools.dart';
import '../../../../common/utils/alert.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends BlocDependentSideEffectState<QuizPage, QuizPageBloc, QuizPageSideEffect> {
  final TextEditingController lastQuestionTextController = TextEditingController();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.simple(title: tr('dailyQuiz')),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<QuizPageBloc, QuizPageState>(
            listenWhen: (oldState, newState) => oldState.lastQuestionAnswer != newState.lastQuestionAnswer,
            listener: (BuildContext context, QuizPageState state) {
              lastQuestionTextController.text = state.lastQuestionAnswer ?? emptyString;
            },
          ),
        ],
        child: Padding(
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
        ));
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
        const SizedBox(height: 32),
        _questionsPageView(context),
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

  Widget _questionsPageView(BuildContext context) {
    return BlocBuilder<QuizPageBloc, QuizPageState>(
      buildWhen: (oldState, newState) => oldState.quiz != newState.quiz,
      builder: (BuildContext context, QuizPageState state) {
        return Expanded(
          child: PageView.builder(
            itemCount: (state.quiz?.questions?.length ?? 0) + 1,
            controller: pageController,
            itemBuilder: (BuildContext context, int index) {
              final question = state.quiz?.questions?[index];
              if (index != state.quiz?.questions?.length) {
                return Column(
                  children: [
                    _questionText(context, question?.title ?? emptyString),
                    const SizedBox(height: 20),
                    _answersList(context, question),
                  ],
                );
              } else {
                return BlocBuilder<QuizPageBloc, QuizPageState>(
                  buildWhen: (oldState, newState) => oldState.lastQuestionAnswerErrorMsg != newState.lastQuestionAnswerErrorMsg,
                  builder: (BuildContext context, QuizPageState state) {
                    return TextFormField(
                      onTapOutside: (_) => context.unFocus(),
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                      controller: lastQuestionTextController,
                      onChanged: (email) {
                        // context.read<SignInPageBloc>().add(SignInPageEvent.emailChanged(email: email));
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: context.onBackground,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: context.primary),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                        errorText: state.lastQuestionAnswerErrorMsg,
                        labelText: tr('email'),
                        labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0, color: context.onBackground),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _questionText(BuildContext context, String question) {
    return Text(
      question,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        color: context.onBackground,
      ),
    );
  }

  Widget _answersList(BuildContext context, QuizQuestionDto? question) {
    return BlocSelector<QuizPageBloc, QuizPageState, Map<String, String>>(
        selector: (QuizPageState state) => state.answers ?? {},
        builder: (BuildContext context, Map<String, String> answers) {
          return ListView.builder(
            itemCount: question?.answers?.length ?? 0,
            itemBuilder: (context, index) {
              return _selectableAnswerItem(context, index, question, answers);
            },
          );
        });
  }

  Widget _selectableAnswerItem(BuildContext context, int index, QuizQuestionDto? question, Map<String, String> answers) {
    return InkWell(
      onTap: () {
        context.read<QuizPageBloc>().add(
              QuizPageEvent.answerSelected(
                questionId: question?.id ?? emptyString,
                answerId: question?.answers?[index].id ?? emptyString,
              ),
            );
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: context.onBackground.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8.0),
          color: answers[question?.id] == question?.answers?[index].id ? context.primary : context.background,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: answers[question?.id] == question?.answers?[index].id ? null : Border.all(color: context.quizDialogItemColor),
                shape: BoxShape.circle,
                color: context.background,
              ),
              child: answers[question?.id] == question?.answers?[index].id ? Center(child: AppIcons.checkMark.svgAsset()) : null,
            ),
            const SizedBox(width: 10.0),
            Text(
              question?.answers?[index].title ?? emptyString,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                letterSpacing: 0.2,
                color: context.onBackground,
              ),
            ),
          ],
        ),
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
                        pageController.previousPage(duration: kTabScrollDuration, curve: Curves.ease);
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
                onPressed: () {
                  if (state.currentQuestionIndex != (state.quiz?.questions?.length ?? 0)) {
                    if (state.answers?[state.quiz?.questions?[state.currentQuestionIndex].id] != null) {
                      pageController.nextPage(duration: kTabScrollDuration, curve: Curves.ease);
                    }
                  } else {}
                },
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
                      state.currentQuestionIndex == (state.quiz?.questions?.length ?? 0) ? tr('complete') : tr('next'),
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
  Future<void> handleSideEffect(QuizPageSideEffect effect) async {
    switch (effect) {
      case QuizCompleted():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            await showAlertDialog(title: tr('success'), message: tr('quizCompleted'));
            if (mounted) {
              context.pop();
            }
            break;
          case ResourceStatusEnum.error:
            break;
          case ResourceStatusEnum.loading:
            break;
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    lastQuestionTextController.dispose();
    pageController.dispose();
  }
}
