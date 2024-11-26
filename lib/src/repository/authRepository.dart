import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:my_peopler/src/core/constants/endpoints.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/core/exception/apiException.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/login/customer_login/customerLogin.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/services/iHttpService.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/utils/numUtils.dart';

@Injectable(env: [Env.dev, Env.prod])
@Singleton()
class AuthRepository {
  final IHttpService client;

  AuthRepository(this.client);

  /// Login
  /// Take data as {"email":"","password":"","code":""}
  Future<BaseResponse> login(Map<String, dynamic> data) async {
    try {
      var response = await client.post(
          endPoint: Endpoints.LOGIN, data: data, isDebug: true);
      // log(response.data.toString(), name: "login");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return BaseResponse<Login>(
          status: "success",
          data: Login.fromJson(response.data),
        );
      }
      if (response.statusCode! >= 400 && response.statusCode! <= 499) {
        if(response.statusCode == 422){
          log(response.data['errors']['error'][0]);
          return BaseResponse<Login>(
            status: "error",
            data: null,
            error: response.data['errors']['error'][0] ??
                "Invalid Credentials!!!");
        }else{
          return BaseResponse<Login>(
            status: "error",
            data: null,
            error: MessageHelper.getResponseMsg(response.data) ??
                "Invalid Credentials!!!");
        }
        
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e,
            name: "getLeaveApplications"),
      );
    }
  }

  // Forgot Password
  Future<BaseResponse> forgotPassword(Map<String, dynamic> data) async {
    try {
      var response = await client.post(
        endPoint: Endpoints.FORGOT_PASSWORD,
        data: data,
        queryParameters: {'code': data['code']},
        options: Options(headers: {'Accept': "applications/json"}),
      );
      if (NumUtils.getFirstDigit(response.statusCode) == 2) {
        String? succMessage = response.data['status'];
        return BaseResponse<String>(
          status: "success",
          data: succMessage??"Reset Email Sent Successfully!!!",
        );
      }
      if (NumUtils.getFirstDigit(response.statusCode) == 4) {
        return BaseResponse<String>(
          status: "error",
          error: MessageHelper.getResponseMsg(response.data) ??"Please check you email or code and try Again!!!",
        );
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e, name: "forgotPassword"),
      );
    }
  }

  // Forgot Password
  Future<BaseResponse> saveFcmToken(Map<String, dynamic> data) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.FCM_TOKEN,
        data: data,
        queryParameters: {'code': StorageHelper.userCode},
        options: Options(headers: {
          'Accept': "applications/json",
          'Authorization': "Bearer $token",
        }),
      );
      if (NumUtils.getFirstDigit(response.statusCode) == 2) {
        String? succMessage = response.data['status'];
        return BaseResponse<String>(
          status: "success",
          data: succMessage??"Token Saved",
        );
      }
      if (NumUtils.getFirstDigit(response.statusCode) == 4) {
        return BaseResponse<String>(
          status: "error",
          error: MessageHelper.getResponseMsg(response.data) ??"Token Not Saved",
        );
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e, name: "Error - Token Not Saved"),
      );
    }
  }

  Future<BaseResponse> customerLogin(Map<String, dynamic> data) async {
    try {
      var response = await client.post(
          endPoint: Endpoints.SFA_CUSTOMER_LOGIN, data: data, isDebug: true);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return BaseResponse<CustomerLoginModel>(
          status: "success",
          data: CustomerLoginModel.fromJson(response.data),
        );
      }
      if (response.statusCode! >= 400 && response.statusCode! <= 499) {
        if(response.statusCode == 422){
          log(response.data['errors']['error'][0]);
          return BaseResponse<CustomerLoginModel>(
            status: "error",
            data: null,
            error: response.data['errors']['error'][0] ??
                "Invalid Credentials!!!");
        }else{
          return BaseResponse<CustomerLoginModel>(
            status: "error",
            data: null,
            error: MessageHelper.getResponseMsg(response.data) ??
                "Invalid Credentials!!!");
        }
        
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e,
            name: "getLeaveApplications"),
      );
    }
  }
}
