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
import 'package:heal_v/shared/feature/progress/progress_bloc.dart';
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
      resizeToAvoidBottomInset: false,
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
              Expanded(child: _questionsColumn(context)),
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
          '${tr('question')} ${state.currentQuestionIndex + 1} ${tr('of')} ${(state.quiz?.questions?.length ?? 0) + 1}',
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
          itemCount: (state.quiz?.questions?.length ?? 0) + 1,
          activeIndex: state.currentQuestionIndex,
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
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (state.quiz?.questions?.length ?? 0) + 1,
            controller: pageController,
            itemBuilder: (BuildContext context, int index) {
              if (index != state.quiz?.questions?.length) {
                final question = state.quiz?.questions?[index];
                return Column(
                  children: [
                    _questionText(context, question?.title ?? emptyString),
                    const SizedBox(height: 20),
                    Expanded(child: _answersList(context, question)),
                  ],
                );
              } else {
                return BlocBuilder<QuizPageBloc, QuizPageState>(
                  buildWhen: (oldState, newState) => oldState.lastQuestionAnswerErrorMsg != newState.lastQuestionAnswerErrorMsg,
                  builder: (BuildContext context, QuizPageState state) {
                    return Column(
                      children: [
                        TextFormField(
                          onTapOutside: (_) => context.unFocus(),
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                          controller: lastQuestionTextController,
                          maxLines: 10,
                          onChanged: (answer) {
                            context.read<QuizPageBloc>().add(QuizPageEvent.lastQuestionAnswerChanged(answer: answer));
                          },
                          keyboardType: TextInputType.text,
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
                            hintText: tr('typeHere'),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color: context.onBackground.withValues(alpha: 0.3),
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
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
          return ListView.separated(
            itemCount: question?.answers?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16.0);
            },
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
        padding: const EdgeInsets.all(12),
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
              child: answers[question?.id] == question?.answers?[index].id
                  ? Center(
                      child: AppIcons.checkMark.svgAsset(
                        colorFilter: ColorFilter.mode(context.primary, BlendMode.srcIn),
                      ),
                    )
                  : null,
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
      buildWhen: (oldState, newState) => oldState.currentQuestionIndex != newState.currentQuestionIndex || oldState.quiz != newState.quiz,
      builder: (BuildContext context, QuizPageState state) {
        final bloc = context.read<QuizPageBloc>();
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
                        bloc.add(QuizPageEvent.currentQuestionIndexChanged(index: state.currentQuestionIndex - 1));
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
                  if (state.currentQuestionIndex < (state.quiz?.questions?.length ?? 0)) {
                    if (bloc.state.answers?[state.quiz?.questions?[state.currentQuestionIndex].id] != null) {
                      pageController.nextPage(duration: kTabScrollDuration, curve: Curves.ease);
                      bloc.add(QuizPageEvent.currentQuestionIndexChanged(index: state.currentQuestionIndex + 1));
                    }
                  } else {
                    bloc.add(QuizPageEvent.validate());
                  }
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
                      state.currentQuestionIndex < (state.quiz?.questions?.length ?? 0) ? tr('next') : tr('complete'),
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
              context.read<ProgressBloc>().add(ProgressEvent.getDailyProgress());
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
