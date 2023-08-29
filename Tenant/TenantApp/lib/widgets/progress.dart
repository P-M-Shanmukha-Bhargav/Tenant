import 'package:flutter/material.dart';


Container circularProgress({Color? color}) {
  return Container(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color ?? Colors.teal),
    ),
    alignment: Alignment.center,
  );
}

Container circularProgressSmall({Color? color, double size = 15}) {
  return Container(
    height: size,
    width: size,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color ?? Colors.teal),
    ),
    alignment: Alignment.center,
  );
}

Container linearProgress({Color? color}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color ?? Colors.teal),
    ),
  );
}
