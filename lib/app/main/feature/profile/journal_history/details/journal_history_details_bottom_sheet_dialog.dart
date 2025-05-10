import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/details/journal_history_details_bloc.dart';
import 'package:heal_v/common/extensions/date_time_extension.dart';
import 'package:heal_v/common/utils/alert.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../../common/flutter/widgets/framework.dart';
import '../../../../../../common/utils/constants.dart';
import '../../../../../../res/images/app_icons.dart';

class JournalHistoryDetailsBottomSheetDialog extends StatefulWidget {
  const JournalHistoryDetailsBottomSheetDialog({super.key});

  @override
  State<StatefulWidget> createState() => _JournalHistoryDetailsBottomSheetDialogState();
}

class _JournalHistoryDetailsBottomSheetDialogState extends BlocDependentSideEffectState<JournalHistoryDetailsBottomSheetDialog, JournalHistoryDetailsBloc, JournalHistoryDetailsEffect> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JournalHistoryDetailsBloc, JournalHistoryDetailsState>(
      buildWhen: (oldState, newState) => oldState.journalHistoryItem != newState.journalHistoryItem,
      builder: (BuildContext context, JournalHistoryDetailsState state) {
        return state.journalHistoryItem == null ? const SizedBox.shrink() : _body(context, state.journalHistoryItem);
      },
    );
  }

  Widget _appBar(BuildContext context, JournalHistoryDto? item) {
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
          DateFormat('dd/MM/yyyy').parse(item?.date ?? emptyString).mmmmDD(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            letterSpacing: 0.2,
            color: context.onBackground,
          ),
        ),
        InkWell(
          onTap: () {
            showDeleteJournalDialog(() {
              context.read<JournalHistoryDetailsBloc>().add(JournalHistoryDetailsEvent.deleteJournal(item?.date ?? emptyString));
              context.pop();
            });
          },
          child: AppIcons.trash.svgAsset(width: 20.0, height: 20.0),
        )
      ],
    );
  }

  Widget _body(BuildContext context, JournalHistoryDto? item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appBar(context, item),
          const SizedBox(height: 24.0),
          _messageText(context, item),
        ],
      ),
    );
  }

  Widget _messageText(BuildContext context, JournalHistoryDto? item) {
    return Text(
      item?.message ?? emptyString,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
        letterSpacing: 0.2,
        color: context.onBackground,
      ),
    );
  }

  @override
  Future<void> handleSideEffect(JournalHistoryDetailsEffect effect) async {
    switch (effect) {
      case JournalDeleted():
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
