import 'package:mgym/features/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  const VideoModel(super.videoTitle, super.videoUrl, super.kal, super.isFav,
      super.videoImageCoverUrl, super.vidId);

  Map<String, dynamic> toMap() {
    return {
      VideoKeys.videoTitle: videoTitle,
      VideoKeys.videoUrl: videoUrl,
      VideoKeys.kal: kal,
      VideoKeys.isFav: isFav,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      map[VideoKeys.videoTitle],
      map[VideoKeys.videoUrl],
      map[VideoKeys.kal],
      map[VideoKeys.isFav] ?? false,
      map[VideoKeys.videoImageCoverUrl],
      map[VideoKeys.vidId],
    );
  }
}

class VideoKeys {
  static const String videoTitle = 'videoTitle';
  static const String videoUrl = 'videoUrl';
  static const String kal = 'kal';
  static const String isFav = 'isFav';
  static const String videoImageCoverUrl = 'videoImageCoverUrl';
  static const String vidId = 'vidId';
}
