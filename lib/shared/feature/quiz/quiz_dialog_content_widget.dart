import 'package:flutter/material.dart';
import 'package:heal_v/theme/ext/extension.dart';

class QuizDialogContentWidget extends StatefulWidget {
  final VoidCallback onDone;

  const QuizDialogContentWidget({required this.onDone, super.key});

  @override
  State<StatefulWidget> createState() => _QuizDialogContentWidgetState();
}

class _QuizDialogContentWidgetState extends State<QuizDialogContentWidget> {
  final List<String> options = ["Meditation Class", "Breathing Exercise", "Stretching Routine", "Be Health Article"];
  final Set<String> selectedAnswer = {};
  int pageIndex = 0;

  final items = const QuizModel(
    optionsModel: [
      OptionsModel(question: 'Share your thoughts on your recent meditation session. How did it make you feel?', answers: ['hello ', 'world', 'c']),
      OptionsModel(question: 'bbb', answers: ['android', 'ios', 'c']),
      OptionsModel(question: 'ccc', answers: ['flutter', 'flutter', 'c']),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (pageIndex != items.optionsModel.length) ...[
            const SizedBox(height: 10),
            _title(context),
            const SizedBox(height: 12),
            _question(context),
            const SizedBox(height: 18),
            _counter(context),
            const SizedBox(height: 18),
            _answerListView(context),
            const SizedBox(height: 50),
          ] else ...[
            thankYou(context),
          ]
        ],
      ),
    );
  }

  Widget thankYou(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Center(
        child: Text(
          'Thank you',
          style: TextStyle(fontWeight: FontWeight.w700, color: context.onBackground, fontSize: 18),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      "Don't Forget to do\nyour daily quiz!",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: context.onBackground),
    );
  }

  Widget _counter(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "${pageIndex + 1}/${items.optionsModel.length}",
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _question(BuildContext context) {
    return Text(
      items.optionsModel[pageIndex].question,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: context.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _answerListView(BuildContext context) {
    final answers = items.optionsModel[pageIndex].answers;
    return Column(
      children: List.generate(answers.length, (index) {
        final isSelected = selectedAnswer.contains(answers[index]);
        return _buildOption(answers[index], isSelected);
      }),
    );
  }

  Widget _buildOption(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          backgroundColor: context.quizDialogItemColor,
        ),
        onPressed: () async {
          setState(() {
            selectedAnswer.add(text);
          });
          await Future.delayed(const Duration(milliseconds: 400));
          pageIndex++;
          setState(() {});
          if (pageIndex == items.optionsModel.length) {
            await Future.delayed(const Duration(milliseconds: 1000));
            widget.onDone.call();
          }
        },
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: context.onBackground,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizModel {
  final List<OptionsModel> optionsModel;

  const QuizModel({required this.optionsModel});
}

class OptionsModel {
  final String question;
  final List<String> answers;

  const OptionsModel({
    required this.question,
    required this.answers,
  });
}
