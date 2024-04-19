import 'package:flutter/material.dart';

enum DisplayType { mobile, tablet, error }


///Common breakpoints are :
///- 320px — 480px for mobile devices,
///- 481px — 768px for iPads & tablets,

DisplayType displayTypeOf(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  if (((orientation == Orientation.portrait) && (width > 320.0 && width < 480.0)) ||
      ((orientation == Orientation.landscape) && (height > 320.0 && height < 480.0))) {
    return DisplayType.mobile;
  }
  if (((orientation == Orientation.portrait) && (width > 481.0)) ||
      ((orientation == Orientation.landscape) && (height > 481.0))) {
    return DisplayType.tablet;
  }
  return DisplayType.error;
}

class ResponsiveWidgetBuilder extends StatelessWidget {
  final WidgetBuilder? mobile;
  final WidgetBuilder? tablet;

  ResponsiveWidgetBuilder.builder({
    Key? key,
    this.mobile,
    this.tablet,
  }) : super(key: key) {
    _checkIfMobileOrTabletIsSupplied();
  }

  void _checkIfMobileOrTabletIsSupplied() {
    final hasMobileLayout = mobile != null;
    final hasTabletLayout = tablet != null;

    assert(hasMobileLayout || hasTabletLayout);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (displayTypeOf(context) == DisplayType.mobile) {
        if (mobile != null) {
          return mobile!(context);
        } else {
          return const Placeholder(child: Text("Add Your Mobile Widget"));
        }
      } else if (displayTypeOf(context) == DisplayType.tablet) {
        if (tablet != null) {
          return tablet!(context);
        } else {
          return const Placeholder(child: Text("Add Your Tablet Widget"));
        }
      } else {
        return const Placeholder(child: Text("Your device is not supported"));
      }
    });
  }
}

class OrientationLayoutBuilder extends StatelessWidget {
  final WidgetBuilder? landscape;
  final WidgetBuilder portrait;

  const OrientationLayoutBuilder({
    Key? key,
    this.landscape,
    required this.portrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final orientation = MediaQuery.of(context).orientation;
        if (orientation == Orientation.landscape) {
          if (landscape != null) {
            return landscape!(context);
          }
        }

        return portrait(context);
      },
    );
  }
}