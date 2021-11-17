import 'package:flutter/material.dart';

class InkWrapper extends StatelessWidget {
  final Color? splashColor;
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets margin;
  final BorderRadius borderRadius;

  InkWrapper({
    this.splashColor = Colors.white24,
    required this.child,
    required this.onTap,
    this.margin = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        child,
        Positioned.fill(
          child: Container(
            margin: margin,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                borderRadius: borderRadius,
                splashColor: splashColor,
                onTap: onTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}