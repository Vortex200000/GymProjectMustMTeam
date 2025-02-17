import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageWidget extends StatefulWidget {
  const CustomImageWidget({
    super.key,
    this.width,
    this.height,
    required this.url,
    this.isShadow = true,
    this.isBorder = false,
    this.fit = BoxFit.contain,
    this.name,
  });

  final double? width;
  final double? height;
  final String? name;
  final String url;
  final bool isShadow;
  final BoxFit fit;
  final bool isBorder;

  @override
  State<CustomImageWidget> createState() => _CustomImageWidgetState();
}

class _CustomImageWidgetState extends State<CustomImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Uri.parse(widget.url).scheme.isEmpty
        ? _buildLocalImage()
        : _buildNetworkImage();
  }

  Widget _buildLocalImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: widget.isBorder
            ? Border.all(color: Colors.grey, width: 2)
            : const Border.fromBorderSide(BorderSide.none),
      ),
      child: Container(
        width: widget.width ?? SizeConfig.screenWidth * .3,
        height: widget.height ?? SizeConfig.screenHeight * .3,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: widget.isShadow
              ? [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: .5),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
          shape: BoxShape.circle,
        ),
        child: widget.url == ''
            ? SizedBox(
                width: widget.width ?? SizeConfig.screenWidth * .3,
                height: widget.height ?? SizeConfig.screenHeight * .3,
                child: Image.asset(
                  'assets/images/blank.png',
                  fit: widget.fit,
                ),
              )
            : Image.file(
                File(widget.url),
                fit: widget.fit,
              ),
      ),
    );
  }

  Widget _buildNetworkImage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: widget.isBorder
              ? Border.all(color: Colors.grey, width: 2)
              : const Border.fromBorderSide(BorderSide.none),
        ),
        child: Container(
          width: widget.width ?? SizeConfig.screenWidth * .3,
          height: widget.height ?? SizeConfig.screenHeight * .3,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: widget.isShadow
                ? [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImage(
            // height: 100,

            imageUrl: widget.url,
            fit: widget.fit,
            placeholder: (context, url) => _buildShimmerEffect(),
            errorWidget: (context, url, error) {
              // log(MyLottiesAnimations.error2);
              return Container(
                width: 50.rW,
                height: 50.rH,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[500]!, // Dark grey
                ),
              );

              //  Lottie.asset(MyLottiesAnimations.error2);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Light grey
      highlightColor: Colors.grey[100]!, // V
      child: Container(
        width: widget.width ?? SizeConfig.screenWidth * .3,
        height: widget.height ?? SizeConfig.screenHeight * .3,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // Ensure the container has a color
        ),
      ),
    );
  }
}
