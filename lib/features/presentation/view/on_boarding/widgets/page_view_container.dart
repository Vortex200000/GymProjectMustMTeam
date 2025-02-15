part of '../on_boarding_layout.dart';

class _PageViewContainers extends StatefulWidget {
  const _PageViewContainers({this.child, this.index});
  final Widget? child;
  final int? index;
  @override
  State<_PageViewContainers> createState() => __PageViewContainersState();
}

class __PageViewContainersState extends State<_PageViewContainers> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            // height: 100.rH,
            decoration: BoxDecoration(color: MyColours.onSecondary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.child ?? SizedBox.shrink(),
                SizedBox(height: 10),
                DottedIndecator(
                    indexx: widget.index ?? 1,
                    length: 3,
                    dotColorActive: Colors.white,
                    dotColorInActive: Color(0xff896cfe))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
