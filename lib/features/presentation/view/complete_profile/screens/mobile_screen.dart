part of '../complete_profile_layout.dart';

class _MobileScreen extends StatelessWidget {
  const _MobileScreen(this.userCredential);
  final UserEntity? userCredential;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _BodyPage(),
        Align(
            alignment: Alignment.bottomCenter,
            child: _FooterPage(userCredential)),
      ],
    );
  }
}
