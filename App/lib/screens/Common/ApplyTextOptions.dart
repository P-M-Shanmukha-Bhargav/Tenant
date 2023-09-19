import 'package:flutter/material.dart';

class ApplyTextOptions extends StatelessWidget {
  const ApplyTextOptions({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textDirection = TextDirection.ltr;
    final textScaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;

    Widget widget = MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: textScaleFactor,
      ),
      child: child,
    );
    return textDirection == null
        ? widget
        : Directionality(textDirection: textDirection, child: widget);
  }
}
