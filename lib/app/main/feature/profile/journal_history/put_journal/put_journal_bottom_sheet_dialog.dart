import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/put_journal/put_journal_bloc.dart';
import 'package:heal_v/common/extensions/date_time_extension.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../../common/flutter/widgets/framework.dart';
import '../../../../../../common/utils/constants.dart';
import '../../../../../../res/images/app_icons.dart';

class PutJournalBottomSheetDialog extends StatefulWidget {
  const PutJournalBottomSheetDialog({super.key});

  @override
  State<StatefulWidget> createState() => _PutJournalBottomSheetDialogState();
}

class _PutJournalBottomSheetDialogState extends BlocDependentSideEffectState<PutJournalBottomSheetDialog, PutJournalBloc, PutJournalEffect> {
  final messageTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PutJournalBloc, PutJournalState>(
      listenWhen: (oldState, newState) => oldState.message != newState.message && messageTextEditingController.text != newState.message,
      listener: (context, state) {
        messageTextEditingController.text = state.message ?? emptyString;
      },
      child: _body(context),
    );
  }

  Widget _appBar(BuildContext context) {
    final date = DateFormat('MMM d').format(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.pop();
          },
          child: AppIcons.close.svgAsset(width: 20.0, height: 20.0),
        ),
        Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            letterSpacing: 0.2,
            color: context.onBackground,
          ),
        ),
        InkWell(
          onTap: () {
            context.read<PutJournalBloc>().add(PutJournalEvent.putJournal(DateTime.now().yyyyMMdd(), messageTextEditingController.text));
          },
          child: AppIcons.greenCheckMark.svgAsset(width: 20.0, height: 20.0),
        )
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appBar(context),
          const SizedBox(height: 24.0),
          _messageTextField(context),
        ],
      ),
    );
  }

  Widget _messageTextField(BuildContext context) {
    return BlocBuilder<PutJournalBloc, PutJournalState>(
      buildWhen: (oldState, newState) => oldState.messageErrorMsg != newState.messageErrorMsg,
      builder: (BuildContext context, PutJournalState state) {
        return Expanded(
          child: TextField(
            maxLines: 1000,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
            controller: messageTextEditingController,
            onChanged: (changedMessage) {
              context.read<PutJournalBloc>().add(PutJournalEvent.messageChanged(changedMessage));
            },
            textCapitalization: TextCapitalization.words,
            cursorColor: context.onBackground,
            decoration: InputDecoration(
              errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: state.message?.isNotEmpty != true ? '${tr('writeText')}...' : emptyString,
              errorText: state.messageErrorMsg,
              hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> handleSideEffect(PutJournalEffect effect) async {
    switch (effect) {
      case JournalPut():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            context.pop(effect);
            break;
          default:
            context.pop();
            break;
        }
        break;
    }
  }
}
