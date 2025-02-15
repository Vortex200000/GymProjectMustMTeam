import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late EdgeInsets padding;
  static late double defaultSize;
  static late double devicePixelRatio;
  static late Orientation orientation;
  // static double smallDeviceWidth = 375.0;
  // static double smallDeviceHeight = 812.0;
  static const double mobile = 600;
  static const double mobileBreakpoint = 400;
  static const double tablet = 900;
  static const double tabletBreakpoint = 600;
  static const double desktop = 1200;
  static const double desktopBreakpoint = 1000;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    padding = _mediaQueryData.padding;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getScreenHeight(inputHeight) {
  double top = SizeConfig.padding.top;
  double bottom = SizeConfig.padding.bottom;
  double screenHeight = SizeConfig.screenHeight - (top + bottom);
  return (inputHeight / 812) * screenHeight; //812
}

// Get the proportionate height as per screen size
double getScreenWidth(inputWidth) {
  double scale = getScaleFactor();
  double responsiveWidth = inputWidth * scale;
  double lowerLimit = inputWidth * 0.8;
  double upperLimit = inputWidth * 1.2;
  return responsiveWidth.clamp(lowerLimit, upperLimit);
  // double screenWidth = SizeConfig.screenWidth;
  // return (inputWidth / 375) * screenWidth;
}

double getResponsiveFont(int fontSize) {
  double scale = getScaleFactor();
  double responsiveFontSize = fontSize * scale;
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor() {
  double width = SizeConfig.screenWidth;
  if (width < SizeConfig.mobile) {
    return width / SizeConfig.mobileBreakpoint;
  } else if (width < SizeConfig.tablet) {
    return width / SizeConfig.tabletBreakpoint;
  } else {
    return width / SizeConfig.desktopBreakpoint;
  }
}

extension ResponsiveDoubleExtension on double {
  double get rW => getScreenWidth(this);
  double get rH => getScreenHeight(this);
}

extension ResponsiveIntExtension on int {
  double get rW => getScreenWidth(this);
  double get rH => getScreenHeight(this);
  double get rF => getResponsiveFont(this);
}