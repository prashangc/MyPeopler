// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_peopler/src/core/core.dart';

class ExceptionHelper {
  static ErrorCode getExceptionCode(exception, {String name = ''}) {
    if (exception is DioError) {
      if (exception.error is SocketException) {
        return ErrorCode.SOCKET_ERROR;
      }
      switch (exception.type) {
        // ignore: deprecated_member_use
        case DioErrorType.connectionTimeout:
          return ErrorCode.CONNECT_TIME_OUT_ERROR;
  
        case DioErrorType.cancel:
          return ErrorCode.REQUEST_CANCEL_ERROR;
        case DioErrorType.sendTimeout:
          return ErrorCode.SEND_TIME_OUT_ERROR;
        case DioErrorType.receiveTimeout:
          return ErrorCode.RECEIVE_TIME_OUT_ERROR;
        default:
      }
      if (exception.response != null) {
        return ErrorCode.RESPONSE_MESSAGE;
      }
    }
    if (exception.runtimeType.toString() == "_CastError") {
      return ErrorCode.CAST_ERROR;
    }
    if (exception is ApiException) {
      return ErrorCode.API_EXCEPTION;
    }
    if (exception is Exception) {
      return ErrorCode.EXCEPTION;
    }

    return ErrorCode.DEFAULT;
  }

  static String getExceptionMessage(exception, {String name = ''}) {
    try {
      log("*************  ${exception.runtimeType.toString()}  *************");
      log(exception.toString(), name: name);
      log("*****************************************************************");
      ErrorCode errorCode = getExceptionCode(exception);
      switch (errorCode) {
        case ErrorCode.CAST_ERROR:
          return "Somthing went wrong";
        case ErrorCode.SOCKET_ERROR:
          return ErrorCode.SOCKET_ERROR.value;
        case ErrorCode.CONNECT_TIME_OUT_ERROR:
          return ErrorCode.CONNECT_TIME_OUT_ERROR.value;
        case ErrorCode.RECEIVE_TIME_OUT_ERROR:
          return ErrorCode.RECEIVE_TIME_OUT_ERROR.value;
        case ErrorCode.SEND_TIME_OUT_ERROR:
          return ErrorCode.SEND_TIME_OUT_ERROR.value;
        case ErrorCode.REQUEST_CANCEL_ERROR:
          return ErrorCode.REQUEST_CANCEL_ERROR.value;
        case ErrorCode.API_EXCEPTION:
          return exception.message;
        case ErrorCode.EXCEPTION:
          return exception.toString().split('Exception: ')[1];
        case ErrorCode.RESPONSE_MESSAGE:
          return exception.response!.data['data']['message'];
        default:
          return ErrorCode.DEFAULT.value;
      }
    } catch (e) {
      return ErrorCode.DEFAULT.value;
    }
  }

}
