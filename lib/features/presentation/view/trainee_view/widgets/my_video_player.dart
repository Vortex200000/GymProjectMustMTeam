import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer(
      {super.key, required this.videoUrl, this.isLooping, this.vidController});
  final String videoUrl;
  final bool? isLooping;
  final VideoPlayerController? vidController;
  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColours.black,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: AdaptivLayoutWidget(
            mobileScreem: _VidPl(
              videoUrl: widget.videoUrl,
              isLooping: false,
            ),
            tabletScreen: _VidPl(
              videoUrl: widget.videoUrl,
              isLooping: false,
            ),
            desktopScreen: _VidPl(
              videoUrl: widget.videoUrl,
              isLooping: false,
            )));
  }
}

class _VidPl extends StatefulWidget {
  const _VidPl({required this.videoUrl, this.isLooping});
  final String videoUrl;
  final bool? isLooping;
  @override
  State<_VidPl> createState() => __VidPlState();
}

class __VidPlState extends State<_VidPl> {
  late VideoPlayerController controller;

  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(true);
  final ValueNotifier<Duration> dur = ValueNotifier<Duration>(Duration());

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.videoUrl,
      ),
      httpHeaders: {
        'Connection': 'keep-alive',
      },
      // invalidateCacheIfOlderThan: const Duration(minutes: 10),
    )..initialize().then((value) async {
        await controller.setLooping(widget.isLooping ?? true);

        controller.play();

        setState(() {});
      });

    controller.addListener(
      () {
        isPlaying.value = controller.value.isPlaying;
        dur.value = controller.value.duration;
        // controller.value.position;
      },
    );
  }
  // @override
  // void initState() {
  //   // TODO: implement _
  //   controller = BetterPlayerController(
  //       BetterPlayerConfiguration(autoPlay: true),
  //       betterPlayerDataSource:
  //           BetterPlayerDataSource.network(widget.videoUrl));
  //   super.initState();
  // }

  @override
  void dispose() {
    controller.dispose();
    isPlaying.dispose();
    log('disposed');
    super.dispose();
  }

  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    visible = !visible;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      child: controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: VideoPlayer(controller),
                            )
                          : Center(
                              child: const CircularProgressIndicator(
                              color: MyColours.white,
                            )),
                    ),
                    // BetterPlayer(controller: controller),
                    // BetterPlayer.network(widget.videoUrl),
                    ValueListenableBuilder(
                      valueListenable: dur,
                      builder: (context, value, child) => Text(
                        value.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: visible && controller.value.isInitialized
                  ? Align(
                      key: ValueKey(1),
                      alignment: Alignment.center,
                      child: ValueListenableBuilder(
                        valueListenable: isPlaying,
                        builder: (context, value, child) => InkWell(
                            onTap: () {
                              value = !value;
                              if (value) {
                                controller.pause();
                              } else {
                                controller.play();
                              }
                              // setState(() {});
                            },
                            child: value
                                ? Icon(
                                    Icons.pause,
                                    size: 50,
                                    color: MyColours.white,
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: MyColours.white,
                                  )),
                      ))
                  : const SizedBox.shrink(
                      key: ValueKey(2),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
