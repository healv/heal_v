import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/details/journal_history_details_bloc.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/details/journal_history_details_bottom_sheet_dialog.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/journal_history_page_bloc.dart';
import 'package:heal_v/common/extensions/date_time_extension.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/main.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/feature/empty/empty_widget.dart';

class JournalHistoryPage extends StatelessWidget {
  const JournalHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.simple(title: tr('journal_history'), isBackEnable: true),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: BlocBuilder<JournalHistoryPageBloc, JournalHistoryPageState>(
        builder: (BuildContext context, JournalHistoryPageState state) {
          if (state.loading == true) {
            return _shimmer(context);
          }
          if (state.journalHistory == null) {
            return const SizedBox();
          }
          if (state.grouped!.isEmpty) {
            return const Center(
              child: EmptyWidget(),
            );
          }
          return _historyListView(context, state.grouped ?? {});
        },
      ),
    );
  }

  Widget _historyListView(BuildContext context, Map<String, List<JournalHistoryDto>> history) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: ListView(
        children: history.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: context.onBackground),
              ),
              const SizedBox(height: 8),
              ...entry.value.map((item) => _buildItem(context, item)),
              const SizedBox(height: 24),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, JournalHistoryDto item) {
    final format = DateFormat('dd/MM/yyyy');
    final date = format.parse(item.date!);
    final badgeColor = Colors.primaries[date.day].shade200;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFFE3D6),
        ),
      ),
      child: ListTile(
        leading: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            children: [
              Positioned.fill(
                child: AppIcons.save.svgAsset(
                  colorFilter: ColorFilter.mode(badgeColor, BlendMode.srcIn),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: Text(
          date.mmmmDD(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            letterSpacing: 0.2,
            color: context.onBackground,
          ),
        ),
        subtitle: Text(
          item.message ?? emptyString,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.3,
            color: context.onBackground.withValues(alpha: 0.2),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: context.onBackground, size: 20),
        onTap: () {
          showModalBottomSheet<JournalHistoryDetailsEffect>(
              backgroundColor: context.background,
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (_) => JournalHistoryDetailsBloc(getIt.get())..add(JournalHistoryDetailsEvent.initial(item)),
                  child: const JournalHistoryDetailsBottomSheetDialog(),
                );
              }).then((effect) {
            switch (effect) {
              case JournalDeleted():
                switch (effect.status) {
                  case ResourceStatusEnum.success:
                    if (context.mounted) context.read<JournalHistoryPageBloc>().add(JournalHistoryPageEvent.initial());
                    break;
                  default:
                    break;
                }
                break;
              default:
                break;
            }
          });
        },
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.separated(
        itemBuilder: (context, index) => SizedBox(
          height: 50,
          child: Shimmer.fromColors(
            baseColor: context.onBackground.withValues(alpha: 0.3),
            highlightColor: context.onBackground.withValues(alpha: 0.1),
            child: Container(
              decoration: BoxDecoration(
                color: context.onBackground.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        shrinkWrap: true,
        itemCount: 20,
      ),
    );
  }
}
