import 'package:equatable/equatable.dart';
import 'package:mgym/features/data/models/data_model.dart';

class DataIntity extends Equatable {
  final String fileUrl;
  const DataIntity({required this.fileUrl});

  DataIntity copyWith({String? fileUrl}) {
    return DataIntity(fileUrl: fileUrl ?? this.fileUrl);
  }

  DataModel get toModel => DataModel(fileUrl: fileUrl);

  @override
  List<Object?> get props => [];
}
