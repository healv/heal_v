import 'package:flutter/material.dart';
import 'package:heal_v/theme/ext/extension.dart';

final class LoadingElevatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final ButtonStyle? style;
  final bool? isLoading;
  final Color? progressIndicatorBackgroundColor;
  final Color? progressIndicatorColor;

  const LoadingElevatedButton({
    super.key,
    this.onPressed,
    this.child,
    this.style,
    this.isLoading,
    this.progressIndicatorBackgroundColor,
    this.progressIndicatorColor,
  });

  @override
  State<StatefulWidget> createState() => _LoadingElevatedButtonState();
}

final class _LoadingElevatedButtonState extends State<LoadingElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: widget.style,
      onPressed: widget.isLoading == true ? () {} : widget.onPressed,
      child: widget.isLoading == true
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: widget.progressIndicatorColor ?? context.onBackground,
                backgroundColor: widget.progressIndicatorBackgroundColor,
              ),
            )
          : widget.child,
    );
  }
}
