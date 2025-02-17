import 'package:flutter/material.dart';
import 'package:mgym/core/helpers/screen_helpers.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton(
      {super.key,
      this.lapel,
      this.onTap,
      this.width = double.infinity,
      this.height = 40,
      this.backgroundColor,
      // this.radius,
      this.padding = const EdgeInsets.all(0),
      this.isPadding = true,
      this.listOfWidget,
      this.isSadow = true,
      this.spacing,
      this.isBorder = false});
  final String? lapel;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  // final double? radius;
  final EdgeInsets padding;
  final bool isPadding;
  final List<Widget>? listOfWidget;
  final bool isSadow;
  final double? spacing;
  final bool isBorder;
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
              shape: BoxShape.circle,
              border: isBorder
                  ? Border.all(width: 2, color: Colors.white)
                  : const Border.fromBorderSide(BorderSide.none),
              // border: Border.all(color: Colors.transparent),
              // borderRadius: BorderRadius.circular(radius ?? 15),
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
                      Text(
                        lapel ?? '',
                        // style: customTextTheme(context)
                        //     .bodyMedium!
                        //     .copyWith(color: Colors.white),
                      )
                    ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
