part of 'steps.dart';

class _HeaderSteps extends StatelessWidget {
  const _HeaderSteps(this.stepsController);
  final StepsController stepsController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                if (stepsController.pageController.page!.round() == 0) {
                  back;
                }
                stepsController.previousPage();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: MyColours.onTerniary,
              )),
          Text(
            'Back',
            style: TextStyle(color: MyColours.onTerniary),
          )
        ],
      ),
    );
  }
}
