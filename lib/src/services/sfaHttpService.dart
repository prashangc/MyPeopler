import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/core/config/config.dart';
import 'package:my_peopler/src/core/di/injection.dart';

@Injectable(env: [Env.prod])
class SfaHttpService {
  late Dio _dio;
  bool isPayment = false;
  SfaHttpService() {
    _dio = Dio();
    _dio
      ..options.baseUrl = BASEURL_SFA
      ..options.connectTimeout = CONNECT_TIME_OUT
      ..options.receiveTimeout = RECEIVE_TIME_OUT
      ..options.responseType = ResponseType.json
      ..options.headers = {'Accept': "application/json"};
    initializeInterceptors();
  }

  Future<Response> get(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool isDebug = false}) async {
    try {
      final Response response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }

  Future<Response> post(
      {required String endPoint,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool isDebug = false}) async {
    try {
      //if (isDebug) {
      log(data.toString(), name: "HttpService Request Data: ");
      //}
      final Response response = await _dio.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }

  Future<Response> put(
      {required String endPoint,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool isDebug = false}) async {
    try {
      final Response response = await _dio.put(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }

  Future<Response> delete(
      {required String endPoint,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool isDebug = false}) async {
    try {
      final Response response = await _dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(onError: (error, handler) {
        log(error.message!, name: "HttpService");
        return handler.next(error);
      }, onRequest: (options, handler) {
        log(options.uri.toString(), name: "HttpService Request");
        return handler.next(options);
      }, onResponse: (response, handler) {
        log(response.data.toString(), name: "HttpService Response");
        return handler.next(response);
      }),
    );
    // _dio.interceptors.add(
    //   RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //       dio: _dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    // );
  }
}