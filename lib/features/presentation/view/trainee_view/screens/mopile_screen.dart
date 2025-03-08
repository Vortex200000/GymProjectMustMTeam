part of '../trainee_view_layout.dart';

class _MopileScreen extends StatelessWidget {
  const _MopileScreen(this.account);
  final UserEntity? account;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   account!.email,
          //   style: TextStyle(color: Colors.white),
          // ),
          // Text(account!.fullName),
          // Text(account.toString()),
          // CustomImageWidget(url: account!.photoUrl),
          // CustomButton(
          //   onTap: () {
          //     authBloc(context).add(SignOutEvent());
          //   },
          // )
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _HeaderH(
              account: account,
            ),
          ),
          _BodyH()
        ],
      ),
    );
  }
}

class _HeaderH extends StatelessWidget {
  const _HeaderH({this.account});
  final UserEntity? account;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.rH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hi, ${account!.fullName}',
                style: TextStyle(
                    color: const Color.fromARGB(255, 135, 112, 228),
                    fontSize: 30.rF,
                    fontWeight: FontWeight.bold),
              ),
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
              )
            ],
          ),
          Text(
            " it's time to challenge your Limits.",
            style: TextStyle(
                color: MyColours.white,
                fontSize: 12.rF,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class _BodyH extends StatefulWidget {
  const _BodyH();

  @override
  State<_BodyH> createState() => _BodyHState();
}

class _BodyHState extends State<_BodyH> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
  }

  int currentIndx = 0;

  List<Widget> widgetsList = [
    WorkOutTap(),
    ProgressTracking(),
    NutrationTap(),
    SupportTap()
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20.rH,
      children: [
        TabBar(
            indicator: BoxDecoration(color: Colors.transparent),
            dividerColor: Colors.transparent,
            controller: _controller,
            onTap: (value) {
              setState(() {
                currentIndx = value;
              });
            },
            tabs: [
              _TabItem(MyIcons.dumble, 'Work out', MyColours.onSecondary,
                  MyColours.onSecondary, 40),
              _TabItem(MyIcons.progressTrack, 'Progress Tracking',
                  MyColours.onSecondary, MyColours.onSecondary, 0),
              _TabItem(MyIcons.nutrition, 'Nutrition', MyColours.onSecondary,
                  MyColours.onSecondary, 0),
              _TabItem(MyIcons.communityFilled1, 'Communitiy',
                  MyColours.onSecondary, MyColours.onSecondary, 0),
            ]),
        widgetsList[currentIndx]
      ],
    );
  }
}

class WorkOutTap extends StatefulWidget {
  const WorkOutTap({super.key});

  @override
  State<WorkOutTap> createState() => _WorkOutTapState();
}

class _WorkOutTapState extends State<WorkOutTap> {
  @override
  void initState() {
    super.initState();
    // UserBloc bloc = UserBloc.get(context);
    // bloc.add(GetAllVideosEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.rH,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommendations',
                style:
                    TextStyle(color: const Color.fromARGB(255, 235, 255, 55)),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  spacing: 10,
                  children: [
                    Text(
                      'See All',
                      style: TextStyle(color: Colors.white),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: SvgPicture.asset(
                        MyIcons.triangelFilledRounded,
                        // ignore: deprecated_member_use
                        color: const Color.fromARGB(255, 235, 255, 55),
                        width: 10,
                        height: 20,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // controller.value.isInitialized
        //     ? AspectRatio(
        //         aspectRatio: controller.value.aspectRatio,
        //         child: CachedVideoPlayerPlus(controller),
        //       )
        //     : const CircularProgressIndicator.adaptive(),

        Videoss(),
        WeeklyChallenge(),

        Articls(),

        // CustomButton(
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => MyVideoPlayer(
        //               videoUrl:
        //                   'https://res.cloudinary.com/dpoqqpqjv/video/upload/v1741033538/Exercise_Tutorial_-_Squat_ujl1sa.mp4'),
        //         ));
        //   },
        // )
      ],
    );
  }
}

class ProgressTracking extends StatelessWidget {
  const ProgressTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '2',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class NutrationTap extends StatelessWidget {
  const NutrationTap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '3',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class SupportTap extends StatelessWidget {
  const SupportTap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Comming soon...',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
