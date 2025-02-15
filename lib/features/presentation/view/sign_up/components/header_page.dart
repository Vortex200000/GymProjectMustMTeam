part of '../sign_up_layout.dart';

class _HeaderPage extends StatelessWidget {
  const _HeaderPage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
                onPressed: () {
                  back;
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: MyColours.onTerniary,
                )),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: MyColours.onTerniary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
