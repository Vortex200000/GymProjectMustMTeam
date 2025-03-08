part of '../trainee_view_layout.dart';

class _FavListV extends StatelessWidget {
  const _FavListV({required this.favorites});
  final List<dynamic> favorites;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        log(favorites[index].toString());
        final item = favorites[index];
        if (item is VideoEntity) {
          return StaggeredSlideIn(
              direction: SlideDirection.start,
              child: _VideoCardFav(videoEntity: item));
        } else if (item is ArticleEntity) {
          return StaggeredSlideIn(
            direction: SlideDirection.start,
            child: _ArticleCardFav(articleEntity: item),
          ); // Your ArticleCard widget
        } else {
          return SizedBox(); // Just in case
        }
      },
    );
  }
}

class _VideoCardFav extends StatefulWidget {
  const _VideoCardFav({required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  State<_VideoCardFav> createState() => _VideoCardFavState();
}

class _VideoCardFavState extends State<_VideoCardFav> {
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
                color: Colors.amber,
              ))
        ],
      ),
    );
  }
}

class _ArticleCardFav extends StatefulWidget {
  const _ArticleCardFav({required this.articleEntity});
  final ArticleEntity articleEntity;

  @override
  State<_ArticleCardFav> createState() => _ArticleCardFavState();
}

class _ArticleCardFavState extends State<_ArticleCardFav> {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        widget.articleEntity.articelTitle,
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
                      Text(
                        widget.articleEntity.article,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(color: MyColours.onPrimary),
                      )
                    ],
                  ),
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
              child: Image.network(
                widget.articleEntity.articleCoverPhoto,
                width: SizeConfig.screenWidth * 0.4,
                height: initialHight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: Icon(
                Icons.star_rate_rounded,
                color: Colors.amber,
              ))
        ],
      ),
    );
  }
}
