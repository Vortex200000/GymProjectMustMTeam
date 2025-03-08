import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/locator/setup_locator.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/domain/entities/article_entity.dart';
import 'package:mgym/features/presentation/controllers/bloc/combonents_bloc.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';

class Articls extends StatefulWidget {
  const Articls({super.key});

  @override
  State<Articls> createState() => _ArticlsState();
}

class _ArticlsState extends State<Articls> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToStart();
    });
  }

  void _scrollToStart() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.3,
      child: BlocProvider(
        create: (context) {
          final bloc = locator<CombonentsBloc>(); // Get the bloc
          bloc.add(GetAllArticlesEvent()); // Dispatch event separately
          return bloc; // Return the bloc instance
        },
        child: BlocBuilder<CombonentsBloc, CombonentsState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: state is GetAllArticlesLoaded
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10.rH,
                                  children: [
                                    Text('Articles & Tips',
                                        style: TextStyle(
                                            color: MyColours.onTerniary,
                                            fontSize: 12.rF)),
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        controller: _scrollController,
                                        shrinkWrap: true,
                                        itemCount: state.articles.length,
                                        itemBuilder: (context, index) =>
                                            ArtCard(
                                          entity: state.articles[index],
                                        ),
                                      ),
                                    )
                                  ]))
                          : state is GetAllVideosFailure
                              ? Text('Error')
                              : SizedBox.shrink()),
                ),
                _ArticListenrFav()
              ],
            );
          },
        ),
      ),
    );
  }
}

class ArtCard extends StatefulWidget {
  const ArtCard({super.key, this.imagePath, this.title, required this.entity});
  final String? imagePath;
  final String? title;
  final ArticleEntity entity;
  @override
  State<ArtCard> createState() => _ArtCardState();
}

class _ArtCardState extends State<ArtCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CombonentsBloc, CombonentsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.rH,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        width: 150.rW,
                        height: 150.rH,
                        imageUrl: widget.entity.articleCoverPhoto,
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            // CombonentsBloc bloc =
                            //     locator<CombonentsBloc>();
                            // bloc.add(UpdateArticleFavEvent(
                            //     widget.entity.id, true));
                            combBloc(context).add(UpdateArticleFavEvent(
                                widget.entity.id, !widget.entity.isFav));

                            // combBloc(context).add(GetAllArticlesEvent());

                            // combBloc(context).add(GetAllArticlesEvent());
                          },
                          icon: Icon(
                            Icons.star_rate_rounded,
                            color: widget.entity.isFav
                                ? Colors.amber
                                : Colors.white,
                          ))

                      //  AnimatedSwitcher(
                      //   duration: Duration(microseconds: 200),
                      //   transitionBuilder: (child, animation) {
                      //     return FadeTransition(
                      //       opacity: animation,
                      //       child: child,
                      //     );
                      //   },
                      //   child: state is UpdateArticleFavLoading
                      //       ? CircularProgressIndicator()
                      //       : state is UpdateArticleFavSuccess
                      //           ? IconButton(
                      //               onPressed: () {
                      //                 // CombonentsBloc bloc =
                      //                 //     locator<CombonentsBloc>();
                      //                 // bloc.add(UpdateArticleFavEvent(
                      //                 //     widget.entity.id, true));
                      //                 combBloc(context).add(UpdateArticleFavEvent(
                      //                     widget.entity.id,
                      //                     !widget.entity.isFav));
                      //                 combBloc(context)
                      //                     .add(GetAllArticlesEvent());
                      //                 log(state.favSt.toString());
                      //               },
                      //               icon: Icon(
                      //                 Icons.star_rate_rounded,
                      //                 color: state.favSt
                      //                     ? Colors.amber
                      //                     : Colors.white,
                      //               ))
                      //           : state is UpdateArticleFavFailure
                      //               ? Text('Error')
                      //               : IconButton(
                      //                   onPressed: () {
                      //                     combBloc(context).add(
                      //                         UpdateArticleFavEvent(
                      //                             widget.entity.id,
                      //                             !widget.entity.isFav));
                      //                     combBloc(context)
                      //                         .add(GetAllArticlesEvent());
                      //                   },
                      //                   icon: Icon(
                      //                     Icons.star_rate_rounded,
                      //                     color: widget.entity.isFav
                      //                         ? Colors.amber
                      //                         : Colors.white,
                      //                   )),
                      // ),
                      )
                ],
              ),
              Text(
                widget.entity.articelTitle,
                style: TextStyle(color: Colors.white, fontSize: 10.rF),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ArticListenrFav extends StatelessWidget {
  const _ArticListenrFav();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CombonentsBloc, CombonentsState>(
      listener: (context, state) {
        if (state is UpdateArticleFavSuccess) {
          combBloc(context).add(GetAllArticlesEvent());
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
