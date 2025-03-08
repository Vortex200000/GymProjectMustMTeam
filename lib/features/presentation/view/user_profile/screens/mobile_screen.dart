part of '../user_profile_layout.dart';

class _MobileScreen extends StatefulWidget {
  final UserEntity? user;
  const _MobileScreen(this.user);

  @override
  State<_MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<_MobileScreen> {
  double size = 0;

  void updateSize(double sizee) {
    setState(() {
      size = sizee;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size,
            child: Stack(
              children: [
                _Header(
                  widget.user,
                  (p0) => updateSize(p0),
                ),
              ],
            ),
          ),
          StaggeredSlideIn(
              direction: SlideDirection.start, child: _Body(widget.user!))
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body(this.user);
  final UserEntity user;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: widget.user.email);
    TextEditingController nameController =
        TextEditingController(text: widget.user.fullName);
    TextEditingController phoneController =
        TextEditingController(text: widget.user.phoneNum);
    TextEditingController weightController =
        TextEditingController(text: '${widget.user.weight.toString()} Kg');
    TextEditingController hightontroller =
        TextEditingController(text: '${widget.user.hight.toString()} Cm');
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: TextStyle(color: const Color.fromARGB(255, 131, 101, 252)),
            ),
            CustomTextForm(
              controller: nameController,
            ),
            Text(
              'Email',
              style: TextStyle(color: const Color.fromARGB(255, 131, 101, 252)),
            ),
            CustomTextForm(
              controller: emailController,
            ),
            Text(
              'Mopile Number',
              style: TextStyle(color: const Color.fromARGB(255, 131, 101, 252)),
            ),
            CustomTextForm(
              controller: phoneController,
            ),
            Text(
              'Weight',
              style: TextStyle(color: const Color.fromARGB(255, 131, 101, 252)),
            ),
            CustomTextForm(
              controller: weightController,
            ),
            Text(
              'Hight',
              style: TextStyle(color: const Color.fromARGB(255, 131, 101, 252)),
            ),
            CustomTextForm(
              controller: hightontroller,
            ),
            SizedBox(
              height: 10.rH,
            ),
            Center(
              child: CustomButton(
                lapel: 'Update Profile',
                backgroundColor: MyColours.onTerniary,
                lapelColur: MyColours.onPrimary,
                radius: 50,
                width: SizeConfig.screenWidth * 0.3,
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  const _Header(this.user, this.onSizeUpfated);
  final UserEntity? user;
  final Function(double) onSizeUpfated;

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  final GlobalKey _mainContainerKey = GlobalKey();
  final GlobalKey _secondaryContainerKey = GlobalKey();

  double temp = 0;
  double mainContainerHignt = 0;
  double secondryContainerHignt = 0;
  double positionedHight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          mainContainerHignt = _mainContainerKey.currentContext!.size!.height;
          log(mainContainerHignt.toString());
          secondryContainerHignt =
              _secondaryContainerKey.currentContext!.size!.height;
          // temp = secondryContainerHignt * 0.5;
          // mainContainerHignt += temp;
          log(mainContainerHignt.toString());
          widget.onSizeUpfated(mainContainerHignt + secondryContainerHignt);
          // log(temp.toString());
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: SizeConfig.screenWidth,
              color: MyColours.onSecondary,
              key: _mainContainerKey,

              // height: 50,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      back;
                    },
                    child: Row(
                      spacing: 5,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: SvgPicture.asset(
                            MyIcons.triangelFilledRounded,
                            width: 20.rW,
                            height: 20.rH,
                            // ignore: deprecated_member_use
                            color: MyColours.onTerniary,
                          ),
                        ),
                        Text(
                          'My Profile',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  // CustomImageWidget(url: user!.photoUrl)
                  StaggeredSlideIn(
                    direction: SlideDirection.top,
                    child: Center(
                      child: CustomImageWidget(
                        isShadow: false,
                        width: 100.rW,
                        height: 100.rH,
                        fit: BoxFit.cover,
                        url: widget.user!.photoUrl,
                      ),
                    ),
                  ),

                  Text(
                    '${widget.user!.fullName} ${widget.user!.nickName}',
                    style: TextStyle(
                        fontSize: 25.rF,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    widget.user!.email,
                    style: TextStyle(
                        fontSize: 15.rF,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Text(
                    'Gender: ${widget.user!.gender}'
                    // user!.email,
                    ,
                    style: TextStyle(
                        fontSize: 15.rF,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(height: 50)
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          left: 0,
          top: mainContainerHignt - secondryContainerHignt * 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: StaggeredSlideIn(
              direction: SlideDirection.end,
              child: Container(
                // width: SizeConfig.screenWidth * 0.5,
                key: _secondaryContainerKey,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 120, 90, 240),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${widget.user!.weight.toString()} Kg',
                            style: TextStyle(color: MyColours.white),
                          ),
                          Text('Weight',
                              style: TextStyle(color: MyColours.white))
                        ],
                      ),
                      Container(
                        width: 2,
                        height: 50.rH,
                        color: MyColours.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Text('${widget.user!.age.toString()} Kg',
                                style: TextStyle(color: MyColours.white)),
                            Text('Years Old',
                                style: TextStyle(color: MyColours.white))
                          ],
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 50.rH,
                        color: MyColours.white,
                      ),
                      Column(
                        children: [
                          Text('${widget.user!.hight.toString()} Cm',
                              style: TextStyle(color: MyColours.white)),
                          Text('Hight',
                              style: TextStyle(color: MyColours.white))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
