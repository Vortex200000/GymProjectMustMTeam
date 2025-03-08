import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';



abstract class ApiServices {
  Future<Response> getData(FetchDataParam param);
  Future<Response> sendData(SendDataParam param);
}

class DioServcies extends ApiServices {
  Dio initDio(String url) {
    return Dio(BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true));
  }

  @override
  Future<Response> getData(FetchDataParam param) async {
    Dio dio = initDio(param.url);
    return await dio.get(param.url, queryParameters: param.header);
  }

  @override
  Future<Response> sendData(SendDataParam param) async {
    Dio dio = initDio(param.url);
    return await dio.post(param.url,
        data: param.data, queryParameters: param.header);
  }
}

class FetchDataParam extends Equatable {
  final String url;
  final Map<String, dynamic> header;

  const FetchDataParam({required this.url, required this.header});

  @override
  List<Object?> get props => [url, header];
}

class SendDataParam extends Equatable {
  final String url;
  final Map<String, dynamic>? header;
  final FormData data;

  const SendDataParam({required this.url, this.header, required this.data});

  @override
  List<Object?> get props => [url, header, data];
}
