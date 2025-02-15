part of 'steps.dart';

class _FooterSteps extends StatelessWidget {
  const _FooterSteps(this.stepsController);
  final StepsController stepsController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.rH),
      child: BulrredButton(
        onTap: stepsController.nextPage,
        radius: 50,
        lapel: 'Continue',
      ),
    );
  }
}
