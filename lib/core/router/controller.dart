import 'package:get/get.dart';

Future<void> get back async => Get.back();

void toNamed(String page, {dynamic arguments}) =>
    Get.toNamed(page, arguments: arguments);

void offNamed(String page, {dynamic arguments}) =>
    Get.offNamed(page, arguments: arguments);

extension RoutesParse on String {
  void toPage({dynamic arguments}) => Get.toNamed(this, arguments: arguments);
  void offPage({dynamic arguments}) => Get.offNamed(this, arguments: arguments);
}

void openTo(dynamic child,
        {dynamic arguments,
        double duration = .5,
        Transition transition = Transition.downToUp}) =>
    Get.to(
      () => child,
      transition: transition,
      fullscreenDialog: true,
      arguments: arguments,
      duration: Duration(milliseconds: (duration * 1000).toInt()),
    );

Future<dynamic>? openPage(dynamic child) => Get.to(child);
