import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productive_families_admin/core/utils/extensions/string_extensions.dart';

import 'extensions/device_extensions.dart';
import 'functions.dart';

T? makeNullable<T>(T? value) => value;

enum PageRouteAnimation { Fade, Scale, Rotate, Slide, SlideBottomTop }

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

void toast(
  String? value, {
  ToastGravity? gravity,
  length = Toast.LENGTH_SHORT,
  Color? bgColor,
  Color? textColor,
  bool print = false,
}) {
  if (value!.validate().isEmpty || isLinux) {
    Functions.printNormal(value ?? "");
  } else {
    Fluttertoast.showToast(
      msg: value.validate(),
      gravity: gravity,
      toastLength: length,
      backgroundColor: bgColor,
      textColor: textColor,
    );
    if (print) Functions.printNormal(value ?? "");
  }
}

void toastLong(
  String? value, {
  BuildContext? context,
  ToastGravity gravity = ToastGravity.BOTTOM,
  length = Toast.LENGTH_LONG,
  Color? bgColor,
  Color? textColor,
  bool print = false,
}) {
  toast(
    value,
    gravity: gravity,
    bgColor: bgColor,
    textColor: textColor,
    length: length,
    print: print,
  );
}

void snackBar(
  BuildContext context, {
  String title = '',
  Widget? content,
  SnackBarAction? snackBarAction,
  Function? onVisible,
  Color? textColor,
  Color? backgroundColor,
  EdgeInsets? margin,
  EdgeInsets? padding,
  Animation<double>? animation,
  double? width,
  ShapeBorder? shape,
  Duration? duration,
  SnackBarBehavior? behavior,
  double? elevation,
}) {
  if (title.isEmpty && content == null) {
    Functions.printNormal('SnackBar message is empty');
  } else {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: backgroundColor,
    //     action: snackBarAction,
    //     margin: margin,
    //     animation: animation,
    //     width: width,
    //     shape: shape,
    //     duration: duration ?? 4.seconds,
    //     behavior: margin != null ? SnackBarBehavior.floating : behavior,
    //     elevation: elevation,
    //     onVisible: onVisible?.call(),
    //     content: content ??
    //         Padding(
    //           padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
    //           child: Text(
    //             title,
    //           ),
    //         ),
    //   ),
    // )
  }
}
