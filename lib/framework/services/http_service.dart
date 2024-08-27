import 'package:dio/dio.dart';
import 'package:f_logs/f_logs.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_system_application/framework/services/http.dart';
import 'package:hms_system_application/providers/auth_provider.dart';

abstract class HttpService {
  String? get token {
    return GetIt.I.get<AuthProvider>().token;
  }

  Http get http {
    return GetIt.I<Http>();
  }

  Dio get dio {
    return http.dio;
  }

  Future<Response> httpGet(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await http.dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioException catch (error) {
      FLog.error(
        text: '$path resulted in  ${error.response?.data['message']}',
        exception: error,
      );
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 500) {
        GetIt.I.get<AuthProvider>().logout();
      }

      throw GenericHttpException(
        error.response?.data['message'] ?? error.message,
        error.response?.statusCode ?? -1,
      );
    }
  }

  Future<Response> httpPost(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await http.dio.post(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        data: data,
      );
      return response;
    } on DioException catch (error) {
      FLog.error(
        text: "$path resulted in  + ${error.response?.statusCode}",
        exception: error,
      );
      throw GenericHttpException(
        error.message,
        error.response?.statusCode ?? -1,
      );
    }
  }

  Future<Response> httpPatch(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await http.dio.patch(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          data: data);
      return response;
    } on DioException catch (error) {
      FLog.error(
          text: '$path resulted in ' + error.response?.data['message'],
          exception: error);
      throw GenericHttpException(
          error.message, error.response?.statusCode ?? -1);
    }
  }

  Future<Response> httpDelete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await http.dio.delete(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);
      return response;
    } on DioException catch (error) {
      FLog.error(
          text: '$path resulted in ' + error.response?.data['message'],
          exception: error);
      throw GenericHttpException(
          error.message, error.response?.statusCode ?? -1);
    }
  }
}
