import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/shared/feature/empty/empty_widget.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/dart/optional.dart';
import '../../../../common/utils/alert.dart';
import '../../../../common/utils/constants.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<StatefulWidget> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  int selectedWeekIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.search(
        title: tr('meditation'),
        isBackEnable: false,
        onSearchTextChanged: (value) {
          context.read<MeditationPageBloc>().add(MeditationPageEvent.meditations(searchQuery: value));
        },
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        _weeks(context),
        Expanded(child: _meditations(context)),
      ],
    );
  }

  Widget _meditations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<MeditationPageBloc, MeditationPageState>(
        builder: (BuildContext context, MeditationPageState state) {
          if (state.loading == true) {
            return _meditationsShimmer(context);
          }
          if (state.items == null) {
            return const SizedBox();
          }
          if (state.items!.meditationBreathing!.isEmpty) {
            return const Center(
              child: EmptyWidget(),
            );
          }
          return _meditationsGridView(context, state.items?.meditationBreathing);
        },
      ),
    );
  }

  Widget _meditationsGridView(BuildContext context, List<MeditationBreathing>? items) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: items?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = items?[index];
        return GestureDetector(
          onTap: () {
            final value = item?.showDescription ?? false;
            items?[index] = item?.copyWith(showDescription: Optional.value(!value)) ?? const MeditationBreathing();
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: item?.isEnable == true ? context.primary : const Color(0xFFCCCCCC), width: 1),
              color: context.background,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: _image(items?[index].photoUrl, items?[index].demoImage ?? emptyString),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    item?.name ?? emptyString,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: context.onBackground,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    '${item?.category ?? emptyString} ${item?.duration != null ? ' • ${item?.duration}' : emptyString}',
                    style: TextStyle(
                      color: context.unselectedItemColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (item?.showDescription == true) const SizedBox(height: 8),
                if (item?.showDescription == true)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(),
                  ),
                if (item?.showDescription == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item?.description ?? emptyString,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
        // return _image(items?[index].photoUrl);
      },
    );
  }

  Widget _meditationsShimmer(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: context.onBackground.withOpacity(0.3),
          highlightColor: context.onBackground.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              color: context.onBackground.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      },
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 2,
      ),
    );
  }

  Widget _image(String? imageUrl, String demoUrl) {
    return imageUrl != null || imageUrl?.isNotEmpty == true
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(key: ValueKey(demoUrl), demoUrl, width: double.infinity, height: 140, fit: BoxFit.cover),
          );
  }

  Widget _weeks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          final isSelected = index == selectedWeekIndex;
          return SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () {
                showLockedDialog(context, tr('meditation_locked'), tr('meditation_locked_description'));
              },
              child: Column(
                children: [
                  Text('${tr('week')} ${index + 1}', style: TextStyle(color: isSelected ? context.onBackground : context.unselectedItemColor)),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 2,
                      width: 60,
                      color: context.onBackground,
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
