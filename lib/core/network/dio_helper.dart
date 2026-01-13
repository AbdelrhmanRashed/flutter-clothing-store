import 'package:dio/dio.dart';
import 'package:Store/core/network/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  //Instance of Dio
  static late final Dio dio;

  //Initialize dio
  static void initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio.interceptors.add(PrettyDioLogger());
  }

  //GET
  static Future<Response> getRequest({required String endPoint}) async {
    Response response = await dio.get(endPoint);
    return response;
  }

  //POST
  static Future<Response> postRequest({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    Response response = await dio.post(endPoint, data: data);
    return response;
  }
}
