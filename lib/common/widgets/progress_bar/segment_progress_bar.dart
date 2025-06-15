import 'package:flutter/cupertino.dart';

class SegmentProgressBar extends StatelessWidget {
  final int itemCount;
  final int activeIndex;
  final Color activeColor;
  final Color inActiveColor;

  const SegmentProgressBar({
    super.key,
    required this.itemCount,
    required this.activeIndex,
    required this.activeColor,
    required this.inActiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(itemCount, (index) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            height: 3,
            decoration: BoxDecoration(
              color: index <= activeIndex ? activeColor : inActiveColor,
              borderRadius: BorderRadius.circular(1000),
            ),
          ),
        );
      }),
    );
  }
}
