part of '../on_boarding_layout.dart';

class _Step extends StatelessWidget {
  const _Step({this.article, this.widget});
  final String? article;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget ?? SizedBox.shrink(),
        SizedBox(
          height: 20,
        ),
        Text(article!.replaceRange(30, article!.length, ''),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        Text(article!.replaceRange(0, 30, ''),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
