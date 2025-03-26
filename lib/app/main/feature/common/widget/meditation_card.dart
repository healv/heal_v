import 'package:flutter/material.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

class MeditationCard extends StatelessWidget {
  final List<MeditationBreathing> items;

  const MeditationCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.primary, width: 1.5),
            color: context.background,
          ),
          child: Row(
            children: [
              _image(item.photoUrl),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description ?? emptyString,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.play_circle_fill,
                color: context.primary,
                size: 40,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, index) => const SizedBox(height: 0),
      itemCount: items.length,
    );
  }

  Widget _image(String? imageUrl) {
    return imageUrl != null || imageUrl?.isNotEmpty == true
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppIcons.demoImage.imageAsset(width: 80, height: 80),
          );
  }
}
