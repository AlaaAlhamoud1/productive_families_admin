// import 'package:flutter/material.dart';

extension IntExtensions on int? {
  int validate({int value = 0}) {
    if (this == null) {
      return value;
    } else {
      return this!;
    }
  }
}

//   bool isSuccessful() => this! >= 200 && this! <= 206;

//   Widget get height => SizedBox(height: this!.toDouble());
//   Widget get width => SizedBox(width: this!.toDouble());

//   Duration get microseconds => Duration(microseconds: validate());
//   Duration get milliseconds => Duration(milliseconds: validate());
//   Duration get seconds => Duration(seconds: validate());
//   Duration get minutes => Duration(minutes: validate());
//   Duration get hours => Duration(hours: validate());
//   Duration get days => Duration(days: validate());

//   double get h => ((this! *
//           MediaQueryData.fromView(WidgetsBinding.instance.window).size.height) /
//       getIt<AppStore>().defaultHeight);

//   double get w => ((this! *
//           MediaQueryData.fromView(WidgetsBinding.instance.window).size.width) /
//       getIt<AppStore>().defaultWidth);

//   double get sp =>
//       ((MediaQueryData.fromView(WidgetsBinding.instance.window).size.width *
//               MediaQueryData.fromView(WidgetsBinding.instance.window)
//                   .size
//                   .height) *
//           this!) /
//       (getIt<AppStore>().defaultHeight * getIt<AppStore>().defaultWidth);
// }
