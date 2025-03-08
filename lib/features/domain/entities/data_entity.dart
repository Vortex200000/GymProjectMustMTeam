import 'package:equatable/equatable.dart';
import 'package:mgym/features/data/models/data_model.dart';

class DataIntity extends Equatable {
  final String message;
  final String fileUrl;
  const DataIntity({required this.message, required this.fileUrl});

  DataIntity copyWith({String? message, String? fileUrl}) {
    return DataIntity(
        message: message ?? this.message, fileUrl: fileUrl ?? this.fileUrl);
  }

  DataModel get toModel => DataModel(message: message, fileUrl: fileUrl);

  @override
  List<Object?> get props => [];
}
