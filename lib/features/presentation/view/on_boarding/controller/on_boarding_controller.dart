part of '../on_boarding_layout.dart';

class _OnBoardingController {
  late List<_Step> _steps;
  late List<String> _paths;
  late PageController pageController; 
  List<_Step> get steps => _steps;
  List<String> get paths => _paths;
  void initialize(PageController pageController) {
    this.pageController = pageController;
    _steps = [
      _Step(
        widget: SvgPicture.asset(
          MyIcons.walkingMan1,
          width: 50,
          height: 50,
          // ignore: deprecated_member_use
          color: MyColours.onTerniary,
        ),
        article: ConstantStrings.onBoardingArticle1,
      ),
      _Step(
        widget: SvgPicture.asset(
          MyIcons.nutrition,
          width: 50,
          height: 50,
          // ignore: deprecated_member_use
          color: MyColours.onTerniary,
        ),
        article: ConstantStrings.onBoardingArticle2,
      ),
      _Step(
        widget: SvgPicture.asset(
          MyIcons.communityFilled1,
          width: 50,
          height: 50,
          // ignore: deprecated_member_use
          color: MyColours.onTerniary,
        ),
        article: ConstantStrings.onBoardingArticle3,
      ),
    ];

    _paths = [
      // 'assets/images/image2.jpg',
      // 'assets/images/image4.jpg',
      // 'assets/images/imag5.jpg'
      MyImages.image2,
      MyImages.image4,
      MyImages.image5,
    ];
  }

  void route() {
    Get.toNamed(Routes.loginRoute);
  }

  void nextStep() {
    pageController.nextPage(
        duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
  }
}
