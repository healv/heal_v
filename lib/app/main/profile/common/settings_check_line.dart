import 'package:flutter/material.dart';
import 'package:heal_v/theme/ext/extension.dart';

class SettingsCheckLine extends StatelessWidget {
  const SettingsCheckLine({
    required this.title,
    required this.checkedStatus,
    required this.callback,
    super.key,
  });

  final String title;
  final bool checkedStatus;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.onBackground.withOpacity(0.1),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: checkedStatus ? context.primary : context.onBackground,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (checkedStatus)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.check,
                    color: context.primary,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
