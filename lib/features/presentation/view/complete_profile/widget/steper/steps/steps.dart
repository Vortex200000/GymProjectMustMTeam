import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/constants/my_constants.dart';
import 'package:mgym/core/size_config/size_config.dart';

class Step1 extends StatelessWidget {
  Step1({super.key});
  final ValueNotifier<String> val = ValueNotifier<String>('male');
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColours.onPrimary,
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: val,
            builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "What's Your Gender",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.rH,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenWidth * 0.2,
                  color: MyColours.onSecondary,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Please select your gender by tapping\non the buttons below',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          val.value = 'male';
                        },
                        child: Material(
                          type: MaterialType.transparency,
                          color: Colors.transparent,
                          child: Container(
                            width: SizeConfig.screenWidth * 0.4,
                            height: SizeConfig.screenWidth * 0.4,
                            padding: EdgeInsets.all(35),
                            decoration: BoxDecoration(
                                color: value == 'male'
                                    ? MyColours.onTerniary
                                    : Color(0xff373737),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    style: value == 'male'
                                        ? BorderStyle.none
                                        : BorderStyle.solid,
                                    width: 1,
                                    color: Colors.white)),
                            child: SvgPicture.asset(
                              MyIcons.male,
                              // ignore: deprecated_member_use
                              color: value == 'male'
                                  ? MyColours.onPrimary
                                  : Colors.white,
                              width: SizeConfig.screenWidth * 0.2,
                              height: SizeConfig.screenWidth * 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Male',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          val.value = 'female';
                        },
                        child: Material(
                          type: MaterialType.transparency,
                          color: Colors.transparent,
                          child: Container(
                            width: SizeConfig.screenWidth * 0.4,
                            height: SizeConfig.screenWidth * 0.4,
                            padding: EdgeInsets.all(35),
                            decoration: BoxDecoration(
                                color: value == 'female'
                                    ? MyColours.onTerniary
                                    : Color(0xff373737),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    style: value == 'female'
                                        ? BorderStyle.none
                                        : BorderStyle.solid,
                                    width: 1,
                                    color: Colors.white)),
                            child: SvgPicture.asset(
                              MyIcons.female,
                              // ignore: deprecated_member_use
                              color: value == 'female'
                                  ? MyColours.onPrimary
                                  : Colors.white,
                              width: SizeConfig.screenWidth * 0.2,
                              height: SizeConfig.screenWidth * 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Female',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final List<int> ages = List.generate(
    150,
    (index) => index,
  );

  final PageController pageControllerAge = PageController(
    viewportFraction: 0.2, // Adjust how many numbers are visible at once
    initialPage: 28,
  );

  ValueNotifier<int> currentAge = ValueNotifier<int>(28);
  @override
  void initState() {
    super.initState();

    // Listen to page changes and update currentAge
    pageControllerAge.addListener(() {
      int newAge = pageControllerAge.page?.round() ?? 28;
      if (newAge != currentAge.value) {
        currentAge.value = newAge;
      }
    });
  }

  @override
  void dispose() {
    pageControllerAge.dispose();
    currentAge.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColours.onPrimary,
      child: ValueListenableBuilder(
        valueListenable: currentAge,
        builder: (context, value, child) => Column(
          spacing: 100.rH,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "How Old Are You?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.rH,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Column(
                spacing: 20.rH,
                children: [
                  Text(
                    value.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.rH,
                        fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(
                    MyIcons.triangelFilledRounded,
                    // ignore: deprecated_member_use
                    color: MyColours.onTerniary,
                    width: 20.rH,
                    height: 20.rH,
                  ),
                  SizedBox(
                    height: 120.rH,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                              color: MyColours.onSecondary,
                              width: SizeConfig.screenWidth, // Adjust width
                              height: 120.rH,
                              child: Center(
                                  child: PageView.builder(
                                      controller: pageControllerAge,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: ages.length,
                                      itemBuilder: (context, index) => Center(
                                            child: Text(
                                              ages[index].toString(),
                                              style: TextStyle(
                                                fontSize: value == index
                                                    ? 45.rF
                                                    : 30.rF,
                                                color: value == index
                                                    ? Colors.white
                                                    : MyColours.onPrimary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )))),
                        ),
                        IgnorePointer(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 90.rH,
                              height: 120.rH,
                              // color: Colors.amber,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.symmetric(
                                      vertical: BorderSide(
                                          width: 2, color: MyColours.white))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Step3 extends StatefulWidget {
  const Step3();

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  final List<int> weight = List.generate(400, (index) => index);

  final PageController _weightController = PageController(
    viewportFraction: 0.2,
    initialPage: 75,
  );

  final PageController _rulerController = PageController(
    viewportFraction: 0.2,
    initialPage: 75,
  );
  ValueNotifier<int> currentWight = ValueNotifier<int>(28);
  @override
  void initState() {
    super.initState();

    // _weightController.addListener(() {
    //   if (_weightController.position.isScrollingNotifier.value) {
    //     _rulerController.animateTo(
    //       _weightController.offset,
    //       duration: Duration(milliseconds: 200),
    //       curve: Curves.easeInCubic,
    //     );
    //   }
    // });

    _rulerController.addListener(() {
      if (_rulerController.position.isScrollingNotifier.value) {
        _weightController.animateTo(
          _rulerController.offset,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInCubic,
        );
      }
    });
    _weightController.addListener(() {
      int newAge = _weightController.page?.round() ?? 28;
      if (newAge != currentWight.value) {
        currentWight.value = newAge;
      }
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _rulerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColours.onPrimary,
      child: ValueListenableBuilder(
        valueListenable: currentWight,
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            spacing: 10.rH,
            children: [
              const SizedBox(height: 50),
              Text(
                "What Is Your Weight?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: 60,
                  decoration: BoxDecoration(
                    color: MyColours.onTerniary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('KG',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Container(color: Colors.black, width: 2, height: 40),
                      Text('LB',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Weight Selector
              SizedBox(
                height: 50.rH,
                child: PageView.builder(
                  controller: _weightController,
                  scrollDirection: Axis.horizontal,
                  itemCount: weight.length,
                  itemBuilder: (context, index) => Center(
                    child: Text(
                      weight[index].toString(),
                      style: TextStyle(
                          fontSize: 30.rF,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              // Ruler
              Container(
                color: MyColours.onSecondary,
                height: 120.rH,
                child: PageView.builder(
                  controller: _rulerController,
                  scrollDirection: Axis.horizontal,
                  itemCount: weight.length,
                  itemBuilder: (context, index) => Center(
                    child: _buildRulerMark(index),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SvgPicture.asset(
                  MyIcons.triangelFilledRounded,
                  width: 50.rW,
                  height: 50.rH,
                  // ignore: deprecated_member_use
                  color: MyColours.onTerniary,
                ),
              ),

              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value.toString(),
                    style: TextStyle(
                        fontSize: 40.rF,
                        fontWeight: FontWeight.bold,
                        color: MyColours.white),
                  ),
                  Text(
                    'Kg',
                    style: TextStyle(
                        fontSize: 15.rF,
                        fontWeight: FontWeight.bold,
                        color: MyColours.white.withValues(alpha: 0.5)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRulerMark(int index) {
    bool isMajor = index % 5 == 0; // Every 5th mark is larger
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 2,
          height: isMajor ? 80.rH : 50.rH,
          color: isMajor ? MyColours.onTerniary : Colors.white,
        ),
        if (isMajor)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              '$index',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}

class Step4 extends StatelessWidget {
  const Step4();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColours.onPrimary,
        child: Column(
          children: [],
        ));
  }
}
