import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/journal_history_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        color: const Color(0xFFFFEAE0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              date.day.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          '${date.month} ${date.day}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          item.message ?? emptyString,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: context.primary, size: 20),
        onTap: () {
          // Navigate to article or perform action
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
            baseColor: context.onBackground.withOpacity(0.3),
            highlightColor: context.onBackground.withOpacity(0.1),
            child: Container(
              decoration: BoxDecoration(
                color: context.onBackground.withOpacity(0.7),
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
