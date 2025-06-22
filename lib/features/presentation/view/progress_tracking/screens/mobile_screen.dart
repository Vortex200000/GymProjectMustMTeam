part of '../progress_tracking_layout.dart';

class _MopileScreen extends StatelessWidget {
  const _MopileScreen(this._user);
  final UserEntity _user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.rW),
          child: _Header(
            account: _user,
          ),
        ),
        _ProgressUserDisplay(
          entity: _user,
        ),
        const _Body()
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.account});
  final UserEntity account;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.rH),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  back;
                },
                child: Row(
                  spacing: 10,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: SvgPicture.asset(
                        MyIcons.triangelFilledRounded,
                        width: 20,
                        height: 20,
                        // ignore: deprecated_member_use
                        color: MyColours.onTerniary,
                      ),
                    ),
                    Text(
                      'Progress Tracking',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 135, 112, 228),
                          fontSize: 22.rF,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  InkWell(
                      onTap: () {
                        // Get.offAll(
                        //   Routes.loginRoute,
                        // );
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    // padding: const EdgeInsets.all(10),
                                    width: SizeConfig.screenWidth * .5,
                                    height: SizeConfig.screenWidth * .3,
                                    decoration: const BoxDecoration(
                                        color: MyColours.onPrimary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'You Sure You Want',
                                          style:
                                              TextStyle(color: MyColours.white),
                                        ),
                                        SizedBox(
                                          height: 10.rH,
                                        ),
                                        const Text(
                                          'To Sign Out ',
                                          style:
                                              TextStyle(color: MyColours.white),
                                        ),
                                        SizedBox(
                                          height: 10.rH,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: CustomButton(
                                                onTap: () {
                                                  authBloc(context)
                                                      .add(SignOutEvent());
                                                  Get.offAllNamed(
                                                      Routes.loginRoute);
                                                },
                                                lapel: 'Yes',
                                                lapelColur: MyColours.black,
                                                backgroundColor:
                                                    MyColours.onTerniary,
                                              )),
                                              Expanded(
                                                  child: CustomButton(
                                                onTap: () {
                                                  back;
                                                },
                                                lapel: 'No',
                                                backgroundColor:
                                                    MyColours.onSecondary,
                                              )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: const Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 135, 112, 228),
                      )),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.userProfile,
                          arguments: UserProfileLayout(
                            user: account,
                          ));
                    },
                    child: SvgPicture.asset(
                      MyIcons.profile,
                      height: 30,
                      width: 30,
                      // ignore: deprecated_member_use
                      color: const Color.fromARGB(255, 135, 112, 228),
                    ),
                  ),
                ],
              )
            ],
          )
        ]));
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.rW, vertical: 20.rH),
      child: const Column(
        children: [_ProgressCard()],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.rH, horizontal: 40.rW),
      decoration: BoxDecoration(
          border: Border.all(color: MyColours.white, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        spacing: 15.rH,
        children: [
          Row(
            spacing: 50.rW,
            children: const [
              _Borgress(type: 'video'),
              _Borgress(type: 'article')
            ],
          ),
          Container(
            color: Colors.grey.shade400,
            width: SizeConfig.screenWidth,
            height: 2,
          ),
          Row(
            spacing: 25.rH,
            children: const [
              Text('Videos', style: TextStyle(color: MyColours.onTerniary)),
              Text('Articles', style: TextStyle(color: MyColours.onTerniary)),
            ],
          )
        ],
      ),
    );
  }
}

class _Borgress extends StatefulWidget {
  const _Borgress({required this.type});
  final String type;
  @override
  State<_Borgress> createState() => __BorgressState();
}

class __BorgressState extends State<_Borgress> {
  int total = 0;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    total = await locator<UserRemoteData>().getTotalItems(
        widget.type == 'video' ? 'videos_collection' : 'articles_collection');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return total != 0
        ? StreamBuilder(
            stream: locator<UserRemoteData>()
                .getUserProgress(widget.type == 'video' ? 'video' : 'article'),
            builder: (context, snapshot) {
              double progress = snapshot.hasData ? snapshot.data! / total : 0;
              log(snapshot.data.toString());
              return SizedBox(
                height: SizeConfig.screenWidth * 0.5,
                child: RotatedBox(
                  quarterTurns: 3, // Rotates the progress bar to be vertical
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(20),

                    value: progress, // 50% progress
                    backgroundColor: Colors.grey[300],
                    color: MyColours.onTerniary,

                    minHeight: 25, // Thickness of the progress bar
                  ),
                ),
              );
            },
          )
        : const SizedBox.shrink();
  }
}

class _ProgressUserDisplay extends StatelessWidget {
  const _ProgressUserDisplay({required this.entity});
  final UserEntity entity;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      color: MyColours.onSecondary,
      padding: EdgeInsets.symmetric(vertical: 20.rH, horizontal: 50.rW),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10.rW,
                children: [
                  Text(
                    entity.fullName,
                    style: TextStyle(
                        color: MyColours.white,
                        fontSize: 22.rF,
                        fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(
                    entity.gender == 'male' ? MyIcons.male : MyIcons.female,
                    // ignore: deprecated_member_use
                    color: MyColours.onTerniary,
                    width: 20.rW,
                    height: 20.rH,
                  )
                ],
              ),
              Text(
                'age:${entity.age}',
                style: TextStyle(
                    color: MyColours.white,
                    fontSize: 12.rF,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 50.rW,
                children: [
                  _UserHightCont(lapel: 'weight', entity: entity),
                  _UserHightCont(lapel: 'height', entity: entity)
                ],
              )
            ],
          ),
          CustomImageWidget(
            url: entity.photoUrl,
            isShadow: false,
            width: 100.rW,
            height: 100.rH,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}

class _UserHightCont extends StatelessWidget {
  const _UserHightCont({required this.lapel, required this.entity});
  final String lapel;
  final UserEntity entity;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.rW,
      children: [
        Container(
          width: 5.rW,
          height: 25.rH,
          decoration: const BoxDecoration(
              color: MyColours.onTerniary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
        ),
        lapel == 'weight'
            ? Column(
                children: [
                  Text(
                    '${entity.weight.toString()} Kg',
                    style: TextStyle(
                        color: MyColours.white,
                        fontSize: 12.rF,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Weight',
                    style: TextStyle(
                        color: MyColours.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.rF),
                  )
                ],
              )
            : Column(
                children: [
                  Text(
                    '${entity.hight.toString()} CM',
                    style: TextStyle(
                        color: MyColours.white,
                        fontSize: 12.rF,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Hight',
                    style: TextStyle(
                        color: MyColours.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.rF),
                  )
                ],
              )
      ],
    );
  }
}
