part of 'steps.dart';

class _BodySteps extends StatelessWidget {
  const _BodySteps(this.stepsController);
  final StepsController stepsController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: stepsController.pageController,
        itemCount: stepsController.steps.length,
        itemBuilder: (context, index) => stepsController.steps[index],
      ),
    );
  }
}
