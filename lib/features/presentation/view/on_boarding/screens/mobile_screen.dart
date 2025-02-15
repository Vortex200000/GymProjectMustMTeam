part of '../on_boarding_layout.dart';

class _MobileScreen extends StatefulWidget {
  const _MobileScreen();

  @override
  State<_MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<_MobileScreen> {
// final
  final _OnBoardingController _controller = _OnBoardingController();

  final ValueNotifier<int> indexx = ValueNotifier<int>(0);
  final PageController pageController = PageController();

  void preloadImages(BuildContext context) {
    for (var path in _controller.paths) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.initialize(pageController);
    pageController.addListener(
      () {
        indexx.value = pageController.page!.round();
      },
    );
    // Preload images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      preloadImages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ListView.builder(
        //   itemCount: paths.length,
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, index) => _ListViewContainer(paths[index]),
        // ),
        ValueListenableBuilder(
            valueListenable: indexx,
            builder: (context, value, child) =>
                _ListViewContainer(_controller.paths[value])),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenWidth * 0.5,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) => _PageViewContainers(
                    index: index,
                    child: _controller.steps[index],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(
                        50), // Ensure it matches your button's radius
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                      child: Container(
                        width:
                            SizeConfig.screenWidth * 0.4, // Match button size
                        height: 40, // Match button height
                        color: Colors.white.withValues(
                            alpha:
                                0.1), // Slight white tint to enhance blur effect
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: indexx,
                    builder: (context, value, child) => CustomButton(
                      onTap:
                          value != 2 ? _controller.nextStep : _controller.route,
                      radius: 50,
                      width: SizeConfig.screenWidth * 0.4,
                      backgroundColor: Colors.transparent,
                      borderWidth: 1,
                      borderColour: Colors.white,
                      lapel: value != 2 ? 'Next' : 'Get Started',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: indexx,
          builder: (context, value, child) => Visibility(
            visible: value != 2,
            child: Positioned(
                top: 50.rH,
                right: 20.rW,
                child: Row(
                  spacing: 10.rW,
                  children: [
                    Text('Skip',
                        style: TextStyle(
                          color: MyColours.onTerniary,
                          fontWeight: FontWeight.bold,
                        )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: MyColours.onTerniary,
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}

class _ListViewContainer extends StatelessWidget {
  const _ListViewContainer(this.path);
  final String? path;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(path ?? ''), fit: BoxFit.cover)),
    );
  }
}

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
    waita();
  }

  void waita() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offNamed(Routes.onBoarding);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: SafeArea(
            child: Scaffold(
                // backgroundColor: Colors.white,
                backgroundColor: MyColours.onPrimary,
                body: Stack(
                  children: [
                    // Center(
                    //     child: Text(
                    //   'a7a',
                    //   style: TextStyle(color: Colors.white),
                    // )),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/image1.jpg'),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ))));
  }
}
