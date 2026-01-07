import 'package:dio/dio.dart';

class DioErrorMapper {
  static String handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      return "Email or password is incorrect";
    }

    if (e.type == DioExceptionType.connectionTimeout) {
      return "Connection timeout, try again";
    }

    if (e.type == DioExceptionType.connectionError) {
      return "No internet connection";
    }

    return "Something went wrong";
  }
}
