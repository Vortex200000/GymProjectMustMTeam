part of '../complete_profile_layout.dart';

class _BodyPage extends StatelessWidget {
  const _BodyPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                MyImages.completeProf1,
              ),
              fit: BoxFit.cover)),
    );
  }
}
