import 'package:flutter/material.dart';
import 'package:mgym/features/presentation/view/complete_profile/widget/steper/steps/steps.dart';

class StepsController {
  late PageController _pageController;
  PageController get pageController => _pageController;
  late List<Widget> _steps;
  List<Widget> get steps => _steps;
  void initializeController(PageController pageController) {
    _pageController = pageController;
    _steps = [Step1(), Step2(), Step3(), Step4()];
  }

  void nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
  }

  void previousPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
  }
}
