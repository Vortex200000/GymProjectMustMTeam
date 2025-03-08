part of 'steps.dart';

class FooterSteps extends StatelessWidget {
  const FooterSteps(this.stepsController, {super.key});
  final StepsController? stepsController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.rH),
      child: BulrredButton(
        onTap: stepsController!.nextPage,
        radius: 50,
        lapel: 'Continue',
      ),
    );
  }
}
