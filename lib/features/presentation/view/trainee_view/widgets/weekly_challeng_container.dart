import 'package:flutter/material.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/size_config/size_config.dart';

class WeeklyChallenge extends StatefulWidget {
  const WeeklyChallenge({super.key});

  @override
  State<WeeklyChallenge> createState() => _WeeklyChallengeState();
}

class _WeeklyChallengeState extends State<WeeklyChallenge> {
  double initialHight = 0;
  final GlobalKey _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          initialHight = _key.currentContext!.size!.height;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      color: MyColours.onSecondary,
      padding: EdgeInsets.all(30),
      child: Stack(
        key: _key,
        children: [
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: MyColours.onPrimary,
                border: Border.fromBorderSide(BorderSide.none),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weekly\nChallenge',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MyColours.onTerniary,
                          fontSize: 20.rF,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Plank With Hip And Twist',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: MyColours.white,
                          fontSize: 10.rF,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // color: Colors.red,
              // width: SizeConfig.screenWidth * 0.4,
              // height: 50,
              child: Image.asset(
                'assets/images/push_up_hip_twist.jpg',
                width: SizeConfig.screenWidth * 0.4,
                height: initialHight,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
