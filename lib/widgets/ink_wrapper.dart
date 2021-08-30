import 'package:flutter/material.dart';

class InkWrapper extends StatelessWidget {
  final Color splashColor;
  final Widget child;
  final VoidCallback onTap;

  InkWrapper({
    this.splashColor = Colors.black26,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: splashColor,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}