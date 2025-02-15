part of '../login_layout.dart';

class _MobileScreen extends StatelessWidget {
  const _MobileScreen();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50.rH,
          ),
          _HeaderPage(),
          SizedBox(
            height: 60.rH,
          ),
          _BodyPage(),
        ],
      ),
    );
  }
}
