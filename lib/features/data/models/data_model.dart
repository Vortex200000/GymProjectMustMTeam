import 'package:mgym/features/domain/entities/data_entity.dart';

class DataModel extends DataIntity {
  const DataModel({required super.message, required super.fileUrl});

  factory DataModel.fromMap(Map<String, dynamic> map) =>
      DataModel(message: map[DataKeys.message], fileUrl: map[DataKeys.fileUrl]);
}

class DataKeys {
  static const String message = 'message';
  static const String fileUrl = 'file_url';
}
