import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String message;
  final String sender;
  final DateTime timeSent;
  final String userPhoto;
  const MessageModel({
    required this.message,
    required this.sender,
    required this.timeSent,
    required this.userPhoto,
  });
  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
        message: map[MessageKeys.message]!,
        sender: map[MessageKeys.sender]!,
        timeSent: (map[MessageKeys.duration] as int).toDate,
        userPhoto: map[MessageKeys.userphoto]!,
      );
  Map<String, dynamic> toMap() => {
        MessageKeys.message: message,
        MessageKeys.sender: sender,
        MessageKeys.duration: timeSent.millisecondsSinceEpoch,
        MessageKeys.userphoto: userPhoto,
      };
  @override
  List<Object?> get props => throw UnimplementedError();
}

class MessageKeys {
  static const String message = 'message';
  static const String sender = 'sender_name';
  static const String duration = 'duration';
  static const String userphoto = 'user_photo';
}

extension IntToDatetimeParse on int {
  DateTime get toDate => DateTime.fromMillisecondsSinceEpoch(this);
}
