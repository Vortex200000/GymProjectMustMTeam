part of '../trainee_view_layout.dart';

class _MopileScreenVad extends StatelessWidget {
  const _MopileScreenVad(this.account);
  final UserEntity? account;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          // Text(
          //   account!.fullName,
          //   style: TextStyle(color: Colors.white),
          // ),
          _HeaderVid(),
          _BodyVid()
        ],
      ),
    );
  }
}

class _HeaderVid extends StatelessWidget {
  const _HeaderVid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: [
          Text(
            'Videos',
            style: TextStyle(
                color: const Color.fromARGB(255, 135, 112, 228),
                fontSize: 30.rF,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _BodyVid extends StatefulWidget {
  const _BodyVid();

  @override
  State<_BodyVid> createState() => _BodyVidState();
}

class _BodyVidState extends State<_BodyVid> {
  @override
  void initState() {
    super.initState();
    userBloc(context).add(GetAllVideosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Expanded(
          child: AnimatedSwitcher(
            duration: Duration(microseconds: 200),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: state is GetAllVideosLoading
                ? SizedBox.shrink()
                : state is GetAllVideosLoaded
                    ? _VidListV(favorites: state.videos)
                    : state is GetAllFavoritesFailure
                        ? Text('Error')
                        : SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

class _VidListV extends StatelessWidget {
  const _VidListV({required this.favorites});
  final List<VideoEntity> favorites;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) => StaggeredSlideIn(
              direction: SlideDirection.start,
              child: _VideoCardVid(
                videoEntity: favorites[index],
              ),
            ));
  }
}

class _VideoCardVid extends StatefulWidget {
  const _VideoCardVid({required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  State<_VideoCardVid> createState() => _VideoCardVidState();
}

class _VideoCardVidState extends State<_VideoCardVid> {
  double initialHight = 0;
  double initialWidth = 0;

  // final GlobalKey _key = GlobalKey();
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (_) {
  //       setState(() {
  //         initialHight = _key.currentContext!.size!.height;
  //       });
  //     },
  //   );
  // }

  Duration? videoDuration;
  // late CachedVideoPlayerPlusController controller;

  final GlobalKey _key = GlobalKey();
  final GlobalKey _key2 = GlobalKey();

  late VideoPlayerController tempController;

  Future<void> _fetchVideoDuration() async {
    // ignore: unnecessary_null_comparison
    if (widget.videoEntity.videoUrl == null ||
        widget.videoEntity.videoUrl.isEmpty) {
      log("Invalid video URL");
      return;
    }

    try {
      // ignore: deprecated_member_use
      tempController =
          // ignore: deprecated_member_use
          VideoPlayerController.network(widget.videoEntity.videoUrl);

      await tempController.initialize().catchError((error) {
        log("Video initialization failed: $error");
      });

      if (tempController.value.isInitialized) {
        // setState(() {
        //   videoDuration = tempController.value.duration;
        // });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            initialHight = _key.currentContext!.size!.height;
            initialWidth = _key2.currentContext!.size!.width;

            log(initialWidth.toString());
            videoDuration = tempController.value.duration;
          });
        });
        log('Video Duration: ${videoDuration?.inSeconds} seconds');
        await tempController.dispose();
      } else {
        log("Video not initialized properly");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            initialHight = _key.currentContext!.size!.height;
          });
        });
      }

      // await tempController.dispose(); // Free memory
    } catch (e) {
      log("Error fetching video duration: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchVideoDuration();
  }

  @override
  void dispose() {
    tempController.dispose(); // Free memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(bottom: 20.0),

      child: Stack(
        key: _key,
        children: [
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: MyColours.white,
                border: Border.fromBorderSide(BorderSide.none),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              key: _key2,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      widget.videoEntity.videoTitle,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: MyColours.onPrimary,
                          fontSize: 15.rF,
                          fontWeight: FontWeight.w700),
                    ),
                    // Text(
                    //   widget.articleEntity.articelTitle.substring(
                    //       9, widget.articleEntity.articelTitle.length),
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //       color: MyColours.onPrimary,
                    //       fontSize: 15.rF,
                    //       fontWeight: FontWeight.w700),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            SvgPicture.asset(
                              MyIcons.clock,
                              // ignore: deprecated_member_use
                              color: Colors.black,
                              width: 10.rW,
                              height: 10.rH,
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: videoDuration != null
                                  ? Text(
                                      '${videoDuration?.inMinutes ?? 00} minutes')
                                  : SizedBox.shrink(),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            // Icon(Icons.f) ,
                            SvgPicture.asset(
                              MyIcons.fire,
                              // ignore: deprecated_member_use
                              color: Colors.black,
                              width: 10.rW,
                              height: 10.rH,
                            ),
                            Text(
                              '${widget.videoEntity.kal} kall',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(color: MyColours.onPrimary),
                            ),
                          ],
                        ),
                      ],
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    widget.videoEntity.videoImageCoverUrl,
                    width: (SizeConfig.screenWidth) - initialWidth,
                    height: initialHight,
                    fit: BoxFit.cover,
                  ),
                  videoDuration != null
                      ? Container(
                          decoration: BoxDecoration(
                              color: MyColours.onSecondary,
                              shape: BoxShape.circle),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyVideoPlayer(
                                        videoUrl: widget.videoEntity.videoUrl),
                                  ));
                            },
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: Icon(
                Icons.star_rate_rounded,
                color: widget.videoEntity.isFav ? Colors.amber : Colors.white,
              ))
        ],
      ),
    );
  }
}
