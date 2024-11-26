

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/constants/endpoints.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/core/exception/apiException.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/baseResponse.dart';
import 'package:my_peopler/src/models/leave/leave.dart';
import 'package:my_peopler/src/models/leave/leaveCategory/leaveCategoryResponse.dart';
import 'package:my_peopler/src/models/leave/remaining_leave.dart';
import 'package:my_peopler/src/services/iHttpService.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/utils/numUtils.dart';

@Injectable(env: [Env.dev, Env.prod])
@Singleton()
class LeaveRepository {
  final IHttpService client;

  LeaveRepository(this.client);

  // Leave Applications
  Future<BaseResponse> getLeaveApplications() async {
    try {
      List<Leave> leaves = [];
      var token = StorageHelper.token;
      if(token == null){
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
          endPoint: Endpoints.LEAVE,
          queryParameters: {'code': StorageHelper.userCode},
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        for (var leave in responseData) {
          leaves.add(Leave.fromJson(leave));
        }
        return BaseResponse<List<Leave>>(
          status: "success",
          data: leaves,
        );
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
  // Leave Categories
  Future<BaseResponse> getLeaveCategory() async {
    try {
     
      var token = StorageHelper.token;
      if(token == null){
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
          endPoint: Endpoints.LEAVE_CATEGORIES,
          queryParameters: {'code': StorageHelper.userCode},
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<LeaveCategoryResponse>(
          status: "success",
          data: LeaveCategoryResponse.fromJson(responseData),
        );
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e,
            name: "getLeaveCategory"),
      );
    }
  }

    // Remaining Leave
  Future<BaseResponse> getRemainingLeave() async {
    try {
     
      var token = StorageHelper.token;
      if(token == null){
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
          endPoint: Endpoints.REMAINING_lEAVE,
          queryParameters: {'code': StorageHelper.userCode},
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<RemainingLeaveResponse>(
          status: "success",
          data: RemainingLeaveResponse.fromJson(responseData),
        );
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e,
            name: "getRemainingLeave"),
      );
    }
  }

  // Request Leave Applications
  Future<BaseResponse> requestLeaveApplication(
      Map<String, dynamic> data) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
          endPoint: Endpoints.LEAVE,
          queryParameters: {'code': StorageHelper.userCode},
          data: data,
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<String>(
          status: "success",
          data: MessageHelper.getResponseMsg(responseData) ??
              "Leave Requested Successfully!!!",
        );
      }
      if (NumUtils.getFirstDigit(response.statusCode) == 4) {
        if (response.statusCode == 401) {
          MessageHelper.error("Session Expired");
          await Get.find<AuthController>().logout();
        }
        if (response.statusCode == 422) {
          throw ApiException(MessageHelper.getResponseMsg(response.data) ??
              "Invalid details!!!");
        }
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e,
            name: "requestLeaveApplication"),
      );
    }
  }
}
