import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/presentation/shared/custom_button/custom_button.dart';

class BulrredButton extends StatelessWidget {
  const BulrredButton(
      {super.key, this.width, this.hight, this.lapel, this.onTap, this.radius});
  final double? width;
  final double? hight;
  final String? lapel;
  final VoidCallback? onTap;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(
              radius ?? 10), // Ensure it matches your button's radius
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10, sigmaY: 10), // Adjust blur intensity
            child: Container(
              width: width ?? SizeConfig.screenWidth * 0.4, // Match button size
              height: hight ?? 40, // Match button height
              color: Colors.white.withValues(
                  alpha: 0.1), // Slight white tint to enhance blur effect
            ),
          ),
        ),
        CustomButton(
          onTap: onTap,
          height: hight ?? 40,
          radius: radius ?? 10,
          width: width ?? SizeConfig.screenWidth * 0.4,
          backgroundColor: Colors.transparent,
          borderWidth: 1,
          borderColour: Colors.white,
          lapel: lapel,
        ),
      ],
    );
  }
}
