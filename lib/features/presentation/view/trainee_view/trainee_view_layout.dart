import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/constants/my_constants.dart';
import 'package:mgym/core/locator/setup_locator.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/domain/entities/article_entity.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/entities/video_entity.dart';
import 'package:mgym/features/presentation/controllers/bloc/combonents_bloc.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';
import 'package:mgym/features/presentation/shared/slide_transition/slide.dart';

import 'package:mgym/features/presentation/view/trainee_view/widgets/articles_card.dart';
import 'package:mgym/features/presentation/view/trainee_view/widgets/my_video_player.dart';

import 'package:mgym/features/presentation/view/trainee_view/widgets/video_card.dart';
import 'package:mgym/features/presentation/view/trainee_view/widgets/weekly_challeng_container.dart';
import 'package:mgym/features/presentation/view/user_profile/user_profile_layout.dart';
import 'package:video_player/video_player.dart';

part './screens/mopile_screen.dart';
part './controller/home_controller.dart';
part './screens/mopile_screen_fav.dart';
part './screens/mopile_screen_vid.dart';
part './widgets/tab_item.dart';
part './widgets/fav_list.dart';

class TrainneeView extends StatefulWidget {
  const TrainneeView({super.key, this.account});
  final UserEntity? account;

  @override
  State<TrainneeView> createState() => _TrainneeViewState();
}

class _TrainneeViewState extends State<TrainneeView> {
  final HomeControllerT homeControllerT = HomeControllerT();
  @override
  void initState() {
    super.initState();
    homeControllerT.initializeHomeController(widget.account!);
  }

  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColours.black,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: MyColours.onPrimary,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex.value,
            onTap: (value) {
              currentIndex.value = value;
            },
            backgroundColor: MyColours.onSecondary,
            type: BottomNavigationBarType.fixed,
            items: homeControllerT.itemList),
        body: ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, value, child) => AdaptivLayoutWidget(
              mobileScreem: homeControllerT._widgetList[value],
              tabletScreen: homeControllerT._widgetList[value],
              desktopScreen: homeControllerT._widgetList[value]),
        ),
      )),
    );
  }
}
