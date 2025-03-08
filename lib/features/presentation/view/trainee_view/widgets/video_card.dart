import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/domain/entities/video_entity.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';
import 'package:mgym/features/presentation/view/trainee_view/controller/home_provide.dart';
import 'package:mgym/features/presentation/view/trainee_view/widgets/my_video_player.dart';
import 'package:video_player/video_player.dart';

class Videoss extends StatefulWidget {
  const Videoss({super.key});

  @override
  State<Videoss> createState() => _VideossState();
}

class _VideossState extends State<Videoss> {
  @override
  void initState() {
    super.initState();
    userBloc(context).add(GetAllVideosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.3,
      child: Column(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: state is GetAllVideosLoaded
                      ? _VidoesList(entityList: state.videos)
                      : state is GetAllVideosFailure
                          ? Text('Error')
                          : const SizedBox(),
                ),
              );
            },
          ),
          AddVidFavListener()
        ],
      ),
    );
  }
}

class _VidoesList extends StatefulWidget {
  const _VidoesList({required this.entityList});
  final List<VideoEntity> entityList;

  @override
  State<_VidoesList> createState() => _VidoesListState();
}

class _VidoesListState extends State<_VidoesList> {
  // final GlobalKey _keyy = GlobalKey();

  // double childHeight = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final RenderBox renderBox =
  //         _keyy.currentContext!.findRenderObject() as RenderBox;
  //     setState(() {
  //       childHeight = renderBox.size.height;
  //     });
  //   });
  // }
  double childHeight = 0;

  void updateChildHeight(double newHeight) {
    if (newHeight > childHeight) {
      // Update only if it's larger
      setState(() {
        childHeight = newHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // shrinkWrap: true,
          itemCount: widget.entityList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => VideoCard(
            // keyy: _keyy,
            // key: _key,
            id: widget.entityList[index].vidId,
            // isLast: entityList.length == index + 1,
            duration: Duration(minutes: 12),
            kal: widget.entityList[index].kal,
            coverPath: widget.entityList[index].videoImageCoverUrl,
            vidPath: widget.entityList[index].videoUrl,
            lapel: widget.entityList[index].videoTitle,
            isFav: widget.entityList[index].isFav,
            onSizeUpdated: (p0) {
              log(p0.toString());
              return updateChildHeight(p0);
            },
          ),
        )

        //  Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     VideoCard(
        //       duration: Duration(minutes: 12),
        //       kal: 120,
        //     ),
        //     VideoCard(
        //       vidPath:
        //           'https://res.cloudinary.com/dpoqqpqjv/video/upload/v1741033495/15_Min._Full_Body_Stretch___Daily_Routine_for_Flexibility_Mobility_Relaxation___DAY_7_gzjojo.mp4',
        //       coverPath: 'assets/images/coverVid2.jpg',
        //       duration: Duration(minutes: 16),
        //       kal: 120,
        //     ),
        //   ],
        // ),
        );
  }
}

class VideoCard extends StatefulWidget {
  const VideoCard(
      {super.key,
      this.coverPath,
      this.lapel,
      this.duration,
      this.kal,
      this.vidPath,
      this.isLast = false,
      this.isFav = false,
      required this.id,
      this.keyy,
      this.onSizeUpdated});
  final String? coverPath;
  final String? lapel;
  final Duration? duration;
  final String? kal;
  final String? vidPath;
  final bool isLast;
  final bool isFav;
  final String id;
  final GlobalKey? keyy;
  final Function(double)? onSizeUpdated;
  @override
  State<VideoCard> createState() => VideoCardState();
}

class VideoCardState extends State<VideoCard> {
  double initialWidth = 0;
  // int durat = 0;
  double initHightIcon = 0;
  Duration? videoDuration;
  // late CachedVideoPlayerPlusController controller;

  final GlobalKey _key = GlobalKey();
  final GlobalKey _key2 = GlobalKey();

  late VideoPlayerController tempController;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = BetterPlayerController(
  //       BetterPlayerConfiguration(autoPlay: false),
  //       betterPlayerDataSource:
  //           BetterPlayerDataSource.network(widget.vidPath ?? ''));

  //   _controller.videoPlayerController.value.duration;
  // }
  // late VideoPlayerController tempController;

  Future<void> _fetchVideoDuration() async {
    // ignore: unnecessary_null_comparison
    if (widget.vidPath == null || widget.vidPath!.isEmpty) {
      log("Invalid video URL");
      return;
    }

    try {
      // ignore: deprecated_member_use
      tempController = VideoPlayerController.network(widget.vidPath!,
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
      // ignore: deprecated_member_use
      // BetterPlayerController(BetterPlayerConfiguration(autoPlay: false),
      //     betterPlayerDataSource:
      //         BetterPlayerDataSource.network(widget.vidPath ?? ''));

      await tempController.initialize().catchError((error) {
        log("Video initialization failed: $error");
      });

      if (tempController.value.isInitialized) {
        // setState(() {
        //   videoDuration = tempController.value.duration;
        // });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            initialWidth = _key.currentContext!.size!.width;
            // initHightIcon = _key.currentContext!.size!.height;

            // videoDuration = tempController.value.duration;

            widget.onSizeUpdated!(
                _key2.currentContext!.size!.height); // Call the callback
          });
        });
        setState(() {
          videoDuration = tempController.value.duration;
        });
        log('Video Duration: ${videoDuration?.inSeconds} seconds');
        // await tempController.dispose();
      } else {
        log("Video not initialized properly");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            initialWidth = _key.currentContext!.size!.width;
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
  // Duration? videoDuration;
  // // late CachedVideoPlayerPlusController controller;
  // late VideoPlayerController tempController;
  // final GlobalKey _key = GlobalKey();

  // Future<void> _fetchVideoDuration() async {
  //   if (widget.vidPath == null || widget.vidPath!.isEmpty) {
  //     log("Invalid video URL");
  //     return;
  //   }

  //   try {
  //     // ignore: deprecated_member_use
  //     tempController = VideoPlayerController.network(widget.vidPath!);

  //     await tempController.initialize().catchError((error) {
  //       log("Video initialization failed: $error");
  //     });

  //     if (tempController.value.isInitialized) {
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         setState(() {
  //           initialWidth = _key.currentContext!.size!.width;
  //           // videoDuration = tempController.value.duration;
  //         });
  //       });
  //       setState(() {
  //         videoDuration = tempController.value.duration;
  //       });
  //       log('Video Duration: ${videoDuration?.inSeconds} seconds');
  //     } else {
  //       log("Video not initialized properly");
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         setState(() {
  //           initialWidth = _key.currentContext!.size!.width;
  //         });
  //       });
  //     }

  //     // await tempController.dispose(); // Free memory
  //   } catch (e) {
  //     log("Error fetching video duration: $e");
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchVideoDuration();
  // }

  // controller = CachedVideoPlayerPlusController.networkUrl(
  //   Uri.parse(
  //     widget.vidPath ??
  //         'https://res.cloudinary.com/dpoqqpqjv/video/upload/v1741033538/Exercise_Tutorial_-_Squat_ujl1sa.mp4',
  //   ),
  //   httpHeaders: {
  //     'Connection': 'keep-alive',
  //   },
  //   invalidateCacheIfOlderThan: const Duration(minutes: 10),
  // )..initialize().then(
  //     (value) async {
  //       setState(() {
  //         controller.value.duration.inSeconds;
  //         log(controller.value.duration.inSeconds.toString());
  //       });
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         setState(() {
  //           initialWidth = _key.currentContext!.size!.width;
  //         });
  //       });
  //     },
  //   );

  // controller.addListener(
  //   () {
  //     isPlaying.value = controller.value.isPlaying;
  //   },
  // );
  // @override
  // void initState() {
  //   super.initState();

  //   controller = CachedVideoPlayerPlusController.networkUrl(
  //     Uri.parse(widget.vidPath ??
  //         'https://res.cloudinary.com/dpoqqpqjv/video/upload/v1741033538/Exercise_Tutorial_-_Squat_ujl1sa.mp4'),
  //     httpHeaders: {'Connection': 'keep-alive'},
  //     invalidateCacheIfOlderThan: const Duration(minutes: 10),
  //   );

  //   controller.initialize().then((_) {
  //     if (mounted) {
  //       setState(() {}); // Ensure UI rebuilds after initialization
  //     }
  //   });

  //   controller.addListener(() {
  //     if (mounted && controller.value.isInitialized) {
  //       setState(() {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           if (mounted) {
  //             setState(() {
  //               initialWidth = _key.currentContext!.size!.width;
  //             });
  //           }
  //         });
  //       }); // Listen for updates
  //     }
  //   });
  // }
  // @override
  // void dispose() {
  //   tempController.dispose();
  //   log('disposed cont');

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: SizedBox.shrink(),
        secondChild: Padding(
            padding: EdgeInsets.only(right: widget.isLast ? 0 : 20),
            child: Stack(
              key: _key2,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          // clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            widget.coverPath ?? 'assets/images/vidCover1.jpg',
                            width: initialWidth,
                            height: SizeConfig.screenHeight * 0.18,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      key: _key,
                      // width: 150.rW,
                      // height: 50.rH,
                      padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                      decoration: BoxDecoration(
                          color: MyColours.onPrimary,
                          border: Border(
                            left: BorderSide(color: Colors.white, width: 1),
                            right: BorderSide(color: Colors.white, width: 1),
                            bottom: BorderSide(color: Colors.white, width: 1),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.rH,
                        children: [
                          Text(
                            widget.lapel ?? 'Squat Exercise',
                            style: TextStyle(
                                color: MyColours.onTerniary, fontSize: 12),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 10,
                            children: [
                              Row(
                                spacing: 2,
                                children: [
                                  Icon(
                                    Icons.watch,
                                    color: MyColours.onSecondary,
                                    size: 20,
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
                                            '${videoDuration?.inMinutes ?? 00} minutes',
                                            style: TextStyle(
                                                color: MyColours.white),
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 2,
                                children: [
                                  Icon(
                                    Icons.fireplace,
                                    color: MyColours.onSecondary,
                                    size: 20,
                                  ),
                                  Text(
                                    "${widget.kal.toString()} kal",
                                    maxLines: 2,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: MyColours.white,
                                        fontSize: 10.rF,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: SizeConfig.screenHeight * 0.18 - 20.rH * 0.5,
                  right: 10,
                  child: Container(
                      width: 20.rH,
                      height: 20.rH,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 154, 129, 253)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyVideoPlayer(
                                    // vidController: controller,
                                    videoUrl: widget.vidPath ??
                                        'https://res.cloudinary.com/dpoqqpqjv/video/upload/v1741033538/Exercise_Tutorial_-_Squat_ujl1sa.mp4'),
                              ));
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 15,
                        ),
                      )),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.star_rate_rounded,
                        color: widget.isFav ? Colors.amber : Colors.white,
                      ),
                      onPressed: () {
                        userBloc(context)
                            .add(UpdateVideoFavEvent(widget.id, !widget.isFav));
                      },
                    ))
              ],
            )),
        crossFadeState: videoDuration != null
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 200));

    // AnimatedSwitcher(
    //   duration: Duration(milliseconds: 200),
    //   transitionBuilder: (child, animation) {
    //     return ScaleTransition(
    //       scale: animation,
    //       child: child,
    //     );
    //   },
    //   child: videoDuration != null
    //       ? Padding(
    //           padding: EdgeInsets.only(right: widget.isLast ? 0 : 20),
    //           child: Stack(
    //             key: _key2,
    //             children: [
    //               Column(
    //                 children: [
    //                   Stack(
    //                     children: [
    //                       ClipRRect(
    //                         borderRadius: BorderRadius.only(
    //                             topLeft: Radius.circular(20),
    //                             topRight: Radius.circular(20)),
    //                         // clipBehavior: Clip.antiAlias,
    //                         child: Image.network(
    //                           widget.coverPath ?? 'assets/images/vidCover1.jpg',
    //                           width: initialWidth,
    //                           height: SizeConfig.screenHeight * 0.18,
    //                           fit: BoxFit.cover,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   Container(
    //                     key: _key,
    //                     // width: 150.rW,
    //                     // height: 50.rH,
    //                     padding:
    //                         EdgeInsets.only(left: 10, bottom: 10, right: 10),
    //                     decoration: BoxDecoration(
    //                         color: MyColours.onPrimary,
    //                         border: Border(
    //                           left: BorderSide(color: Colors.white, width: 1),
    //                           right: BorderSide(color: Colors.white, width: 1),
    //                           bottom: BorderSide(color: Colors.white, width: 1),
    //                         ),
    //                         borderRadius: BorderRadius.only(
    //                             bottomRight: Radius.circular(20),
    //                             bottomLeft: Radius.circular(20))),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       spacing: 5.rH,
    //                       children: [
    //                         Text(
    //                           widget.lapel ?? 'Squat Exercise',
    //                           style: TextStyle(
    //                               color: MyColours.onTerniary, fontSize: 12),
    //                         ),
    //                         Row(
    //                           mainAxisSize: MainAxisSize.min,
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           spacing: 10,
    //                           children: [
    //                             Row(
    //                               spacing: 2,
    //                               children: [
    //                                 Icon(
    //                                   Icons.watch,
    //                                   color: MyColours.onSecondary,
    //                                   size: 20,
    //                                 ),
    //                                 AnimatedSwitcher(
    //                                   duration: Duration(milliseconds: 200),
    //                                   transitionBuilder: (child, animation) {
    //                                     return ScaleTransition(
    //                                       scale: animation,
    //                                       child: child,
    //                                     );
    //                                   },
    //                                   child: videoDuration != null
    //                                       ? Text(
    //                                           '${videoDuration?.inMinutes ?? 00} minutes',
    //                                           style: TextStyle(
    //                                               color: MyColours.white),
    //                                         )
    //                                       : SizedBox.shrink(),
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               spacing: 2,
    //                               children: [
    //                                 Icon(
    //                                   Icons.fireplace,
    //                                   color: MyColours.onSecondary,
    //                                   size: 20,
    //                                 ),
    //                                 Text(
    //                                   "${widget.kal.toString()} kal",
    //                                   maxLines: 2,
    //                                   style: TextStyle(
    //                                       overflow: TextOverflow.ellipsis,
    //                                       color: MyColours.white,
    //                                       fontSize: 10.rF,
    //                                       fontWeight: FontWeight.w400),
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               ),
    //               Positioned(
    //                 top: SizeConfig.screenHeight * 0.18 - 20.rH * 0.5,
    //                 right: 10,
    //                 child: Container(
    //                     width: 20.rH,
    //                     height: 20.rH,
    //                     padding: const EdgeInsets.all(1),
    //                     decoration: BoxDecoration(
    //                         shape: BoxShape.circle,
    //                         color: const Color.fromARGB(255, 154, 129, 253)),
    //                     child: InkWell(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                               builder: (context) => MyVideoPlayer(
    //                                   // vidController: controller,
    //                                   videoUrl: widget.vidPath ??
    //                                       'https://res.cloudinary.com/dpoqqpqjv/video/upload/v1741033538/Exercise_Tutorial_-_Squat_ujl1sa.mp4'),
    //                             ));
    //                       },
    //                       child: Icon(
    //                         Icons.play_arrow,
    //                         color: Colors.white,
    //                         size: 15,
    //                       ),
    //                     )),
    //               ),
    //               Positioned(
    //                   top: 0,
    //                   right: 0,
    //                   child: IconButton(
    //                     icon: Icon(
    //                       Icons.star_rate_rounded,
    //                       color: widget.isFav ? Colors.amber : Colors.white,
    //                     ),
    //                     onPressed: () {
    //                       userBloc(context).add(
    //                           UpdateVideoFavEvent(widget.id, !widget.isFav));
    //                     },
    //                   ))
    //             ],
    //           ))
    //       : SizedBox.shrink(),
    // );
  }
}
