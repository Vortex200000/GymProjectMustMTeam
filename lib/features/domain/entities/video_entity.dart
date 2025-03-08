import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String videoTitle;
  final String videoUrl;
  final String videoImageCoverUrl;
  final String vidId;

  final String kal;
  final bool isFav;
  const VideoEntity(this.videoTitle, this.videoUrl, this.kal, this.isFav,
      this.videoImageCoverUrl, this.vidId);

  @override
  List<Object?> get props => [
        videoTitle,
        videoUrl,
        kal,
      ];
}
