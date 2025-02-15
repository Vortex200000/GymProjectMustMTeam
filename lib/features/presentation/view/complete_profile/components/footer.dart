part of '../complete_profile_layout.dart';

class _FooterPage extends StatelessWidget {
  const _FooterPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.4,
      color: MyColours.onPrimary,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.rH),
              child: Text(
                textAlign: TextAlign.center,
                "Consistency Is \n The Key To Progress. \n Don't Give Up!",
                style: TextStyle(
                    color: MyColours.onTerniary,
                    fontSize: 25.rH,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: (SizeConfig.screenHeight * 0.4) / 3,
              width: SizeConfig.screenWidth,
              color: MyColours.onSecondary,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Press Next To Continue",
                  style: TextStyle(
                      color: MyColours.black,
                      fontSize: 10.rH,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: BulrredButton(
                onTap: () {
                  Get.toNamed(Routes.steps);
                },
                radius: 50,
                lapel: 'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
