import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../utils/constants.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  int visibleDot = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        visibleDot = (visibleDot + 1) % 4;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        height: MediaQuery.of(context).padding.top + 50,
        color: context.primary,
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: tr('no_internet_connection'), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                TextSpan(
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    text: visibleDot == 0
                        ? emptyString
                        : visibleDot == 1
                            ? doth
                            : visibleDot == 2
                                ? '$doth$doth'
                                : '$doth$doth$doth'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
