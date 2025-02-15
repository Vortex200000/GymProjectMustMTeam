import 'package:flutter/material.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/helpers/screen_helpers.dart';
import 'package:mgym/core/size_config/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.lapel,
      this.onTap,
      this.width = double.infinity,
      this.height = 40,
      this.backgroundColor,
      this.radius,
      this.padding = const EdgeInsets.all(0),
      this.isPadding = true,
      this.listOfWidget,
      this.isSadow = true,
      this.spacing,
      this.borderColour,
      this.borderWidth});
  final String? lapel;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? radius;
  final EdgeInsets padding;
  final bool isPadding;
  final List<Widget>? listOfWidget;
  final bool isSadow;
  final double? spacing;
  final Color? borderColour;
  final double? borderWidth;

  // final CustomT

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding
          ? padding == const EdgeInsets.all(0)
              ? kpadding
              : const EdgeInsets.all(0)
          : padding,
      child: SafeArea(
        bottom: true,
        left: true,
        top: true,
        right: true,
        child: Container(
          width: width,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: height,
          decoration: BoxDecoration(
              color: backgroundColor ?? Colors.blue[600],
              // border: Border.all(color: Colors.transparent),
              border: Border.all(
                  color: borderColour ?? Colors.transparent,
                  width: borderWidth ?? 1),
              borderRadius: BorderRadius.circular(radius ?? 15),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: isSadow
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.transparent,
                    blurRadius: 12,
                    spreadRadius: 2),
              ]),
          child: Material(
            type: MaterialType.transparency,
            shadowColor: Colors.grey[50],
            elevation: 6.0,
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Row(
                spacing: spacing ?? 0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: listOfWidget ??
                    [
                      Text(lapel ?? '',
                          style: TextStyle(
                              color: MyColours.white, fontSize: 16.rF))
                    ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
