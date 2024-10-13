// ignore_for_file: unnecessary_this

import 'package:hive/hive.dart';
import 'package:dio/dio.dart';

typedef AuthFailedAction = Function(Box tokenBox);

class Http {
  late Dio dio;
  Box tokenBox;
  String authTokenBoxKey;
  String endPoint;
  int connectTimeout;
  int receiveTimeout;
  String? authToken;
  AuthFailedAction onAuthFailedResponse;

  Http(
    this.tokenBox, {
    required this.endPoint,
    this.connectTimeout = 50000,
    this.receiveTimeout = 3000,
    this.authTokenBoxKey = 'token',
    required this.onAuthFailedResponse,
  }) {
    _init();
  }

  _init() {
    if (tokenBox.isOpen) {
      this.authToken = this.tokenBox.get(this.authTokenBoxKey);
      print("Started with: $authToken");
      this.tokenBox.watch(key: this.authTokenBoxKey).listen((event) {
        authToken = event.value;
      });
    } else {
      throw Exception("The token box is not open");
    }

    BaseOptions options = BaseOptions(
      baseUrl: endPoint,
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
    );

    dio = Dio(options);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions requestOptions, RequestInterceptorHandler handler) {
          requestOptions = _requestInterceptor(requestOptions);
          print(requestOptions.headers);
          return handler.next(requestOptions);
        },
        onResponse: (Response options, ResponseInterceptorHandler handler) {
          options = _responseSuccessInterceptor(options);
          return handler.next(options);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          error = _responseErrorInterceptor(error);
          return handler.next(error);
        },
      ),
    );
  }

  _requestInterceptor(RequestOptions options) {
    options.headers['Accept'] = 'application/json';
    if (authToken != null && authToken != '') {
      options.headers['Authorization'] = 'Bearer ${authToken ?? ''}';
    }

    return options;
  }

  _responseSuccessInterceptor(Response response) {
    return response;
  }

  _responseErrorInterceptor(DioException e) {
    if (e.response != null) {
      int statusCode = e.response?.statusCode ?? 0;

      if (statusCode == 401 && //Only if not a login response
          e.response?.data != null &&
          e.response?.data['error'] != null &&
          e.response?.data['error'] != 'invalid_credentials' &&
          e.response?.data['error'] != 'could_not_create_token') {
        //The delay gives the store time to finish some current actions
        Future.delayed(const Duration(milliseconds: 300))
            .then((_) => this.onAuthFailedResponse(tokenBox));
      }
    }
    return e;
  }
}

class GenericHttpException implements Exception {
  dynamic message;
  int statusCode;

  GenericHttpException(this.message, this.statusCode);

  String errorMessage() {
    return message;
  }
}
