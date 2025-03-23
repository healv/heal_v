import 'package:flutter/material.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

class MeditationBreathingCategoriesWidget extends StatelessWidget {
  final bool selected;
  final String name;
  final String id;
  final bool loading;

  const MeditationBreathingCategoriesWidget({
    super.key,
    required this.name,
    required this.id,
    this.selected = false,
  }) : loading = false;

  const MeditationBreathingCategoriesWidget.loading({
    super.key,
  })  : name = '',
        id = '',
        selected = false,
        loading = true;

  @override
  Widget build(BuildContext context) {
    return loading
        ? _loadingShimmer()
        : GestureDetector(
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: selected ? context.primary : const Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: selected ? Colors.white : context.primary,
                  ),
                ),
              ),
            ),
          );
  }

  Widget _loadingShimmer() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        height: 30,
        child: Shimmer.fromColors(
          baseColor: context.onBackground.withOpacity(0.3),
          highlightColor: context.onBackground.withOpacity(0.1),
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: selected ? context.primary : const Color(0xFFE6E6E6),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 8.0),
      itemCount: 4,
    );
  }
}
