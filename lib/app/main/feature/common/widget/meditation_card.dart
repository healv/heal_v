import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_type_enum.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/alert.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

class MeditationCard extends StatefulWidget {
  final List<MeditationBreathing> items;
  final bool loading;

  const MeditationCard({
    super.key,
    required this.items,
  }) : loading = false;

  MeditationCard.loading({
    super.key,
  })  : loading = true,
        items = List.generate(7, (index) => const MeditationBreathing());

  @override
  State<StatefulWidget> createState() => _MeditationCardState();
}

class _MeditationCardState extends State<MeditationCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var item = widget.items[index];
        return widget.loading
            ? SizedBox(height: 80, child: _shimmer())
            : GestureDetector(
                onTap: () {
                  final value = item.showDescription ?? false;
                  widget.items[index] = item.copyWith(showDescription: Optional.value(!value));
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: item.isEnable == true ? context.primary : const Color(0xFFCCCCCC), width: 1),
                    color: context.background,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _image(item.photoUrl?.first.downloadURL, item.demoImage ?? emptyString),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  item.name ?? emptyString,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: context.onBackground,
                                  ),
                                ),
                                Text(
                                  '${item.category ?? emptyString} ${item.duration != null ? ' • ${item.duration}' : emptyString}',
                                  style: TextStyle(
                                    color: context.unselectedItemColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (item.isEnable == true) {
                                // todo navigate to player page
                              } else {
                                final title = item.type == MeditationTypeEnum.meditations ? tr('meditation_locked') : tr('breathing_locked');
                                final description = item.type == MeditationTypeEnum.meditations ? tr('meditation_locked_description') : tr('breathing_locked_description');
                                showLockedDialog(context, title, description);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: item.isEnable == true ? context.primary : const Color(0xFFCCCCCC),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (item.showDescription == true) const SizedBox(height: 8),
                      if (item.showDescription == true) const Divider(),
                      if (item.showDescription == true)
                        Text(
                          item.description ?? emptyString,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
      },
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemCount: widget.items.length,
    );
  }

  Widget _image(String? imageUrl, String demoImage) {
    return imageUrl != null || imageUrl?.isNotEmpty == true
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(key: ValueKey(demoImage), demoImage, width: 60, height: 60, fit: BoxFit.cover),
          );
  }

  Widget _shimmer() {
    return SizedBox(
      height: 80,
      child: Shimmer.fromColors(
        baseColor: context.onBackground.withValues(alpha: 0.3),
        highlightColor: context.onBackground.withValues(alpha: 0.1),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: context.onBackground.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
