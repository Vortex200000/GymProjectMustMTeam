import 'package:flutter/material.dart';
import 'package:mgym/core/size_config/size_config.dart';

class DottedIndecator extends StatelessWidget {
  const DottedIndecator(
      {super.key,
      this.length = 0,
      this.indexx = 0,
      this.dotColorActive,
      this.dotColorInActive});
  final int length;
  final int indexx;
  final Color? dotColorActive;
  final Color? dotColorInActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          length,
          (index) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: RoundedContainer(
                  isCurrent: indexx == index ? true : false,
                  dotColorActive: dotColorActive,
                  dotColorInActive: dotColorInActive,
                ),
              )),
    );
  }
}

class RoundedContainer extends StatefulWidget {
  const RoundedContainer({
    super.key,
    this.isCurrent = false,
    this.dotColorActive,
    this.dotColorInActive,
  });
  final bool isCurrent;
  final Color? dotColorActive;
  final Color? dotColorInActive;

  @override
  State<RoundedContainer> createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 5.rH,
      width: 20.rW,
      decoration: BoxDecoration(
          color: widget.isCurrent
              ? widget.dotColorActive ?? Colors.black
              : widget.dotColorInActive ?? Colors.grey[400],
          borderRadius: const BorderRadius.all(Radius.circular(5))),
    );
  }
}
