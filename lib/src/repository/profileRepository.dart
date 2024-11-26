import 'dart:async';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/services/services.dart';
import 'package:my_peopler/src/utils/numUtils.dart';

@Injectable(env: [Env.dev, Env.prod])
@Singleton()
class ProfileRepository {
  final IHttpService client;

  ProfileRepository(this.client);

  // Profile
  Future<BaseResponse> getProfile() async {
    try {
      var token = StorageHelper.token;
      var response = await client.get(
          endPoint: Endpoints.PROFILE,
          queryParameters: {'code': StorageHelper.userCode},
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        dev.log(responseData.toString(), name: "Profile Repo");
        return BaseResponse<Profile>(
          status: "success",
          data: Profile.fromJson(responseData),
        );
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e, name: "getProfile"),
      );
    }
  }

  // Change Password
  Future<BaseResponse> changePassword(Map<String, dynamic> data) async {
    try {
      var token = StorageHelper.token;
      var response = await client.post(
        endPoint: Endpoints.CHANGE_PASSWORD,
        data: data,
        queryParameters: {'code': StorageHelper.userCode},
        options: Options(headers: {
          'Authorization': "Bearer $token",
          'Accept': "applications/json"
        }),
      );
      if (NumUtils.getFirstDigit(response.statusCode) == 2) {
        return BaseResponse<String>(
          status: "success",
          data: "Password Changed Successfully!!!",
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
        error: ExceptionHelper.getExceptionMessage(e, name: "resetPassword"),
      );
    }
  }

  // Edit Profile
  Future<BaseResponse> editProfile(Map<String, dynamic> data) async {
    try {
      var token = StorageHelper.token;
      FormData formData;
      if (data['avatar'] != null) {
        String fileName = data['avatar'].split('/').last;
        formData = FormData.fromMap({
          'name': data['name'],
          'email': data['email'],
          'present_address': data['present_address'],
          'contact_no_one': data['contact_no_one'],
          'date_of_birth': data['date_of_birth'],
          'avatar':
              await MultipartFile.fromFile(data['avatar'], filename: fileName),
        });
      } else {
        formData = FormData.fromMap({
          'name': data['name'],
          'email': data['email'],
          'present_address': data['present_address'],
          'contact_no_one': data['contact_no_one'],
          'date_of_birth': data['date_of_birth'],
        });
      }
      var response = await client.post(
        endPoint: Endpoints.PROFILE_UPDATE,
        data: formData,
        queryParameters: {'code': StorageHelper.userCode},
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
          contentType: "form-data",
        ),
      );
      if (NumUtils.getFirstDigit(response.statusCode) == 2) {
        // log(response.data.toString(), name: "Profile Repo");
        return BaseResponse<String>(
          status: "success",
          data: MessageHelper.getResponseMsg(response.data) ??
              "Profile Updated Successfully!!!",
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
        error: ExceptionHelper.getExceptionMessage(e, name: "editProfile"),
      );
    }
  }

  Future<BaseResponse> sfaLocationLog() async {
    Timer? timer;
    double? lat;
    double? long;
    try {
      Response? response;
      timer = Timer.periodic(Duration(minutes: 5), (Timer t) async {
        Position position = await Geolocator.getCurrentPosition();
        // log('foreground latitude${position.latitude}');
        // log('foreground longitude${position.longitude}');
        if (position.longitude != long && position.latitude != lat) {
          lat = position.latitude;
          long = position.longitude;
          var token = StorageHelper.token;
          response = await client.post(
            endPoint: Endpoints.SFA_LOCATION_LOG,
            data: {'lat': position.latitude, 'long': position.longitude},
            queryParameters: {'code': StorageHelper.userCode},
            options: Options(headers: {
              'Authorization': "Bearer $token",
              'Accept': "applications/json"
            }),
          );
        }
        if (NumUtils.getFirstDigit(response!.statusCode) == 2) {
          // log('SFA_LOCATION_LOG Successfull');
          return Future.value();
        }

        if (NumUtils.getFirstDigit(response!.statusCode) == 4) {
          if (response!.statusCode == 401) {
            MessageHelper.error("Session Expired");
            timer?.cancel();
            await Get.find<AuthController>().logout();
          }
          if (response!.statusCode == 422) {
            timer?.cancel();

            throw ApiException(MessageHelper.getResponseMsg(response!.data) ??
                "SFA_LOCATION_LOG not success");
          }
        }
      });
      return BaseResponse(status: 'waiting');
      // throw (ApiException("Something went wrong"));
    } catch (e) {
      // _timer?.cancel();
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e, name: "SFA_LOCATION_LOG"),
      );
    }
  }

  Future<BaseResponse> sfaLocationLogs(List<Map<String, dynamic>> logs) async {
    try {
      var token = StorageHelper.token;

      var response = await client.post(
        endPoint: Endpoints.SFA_LOCATION_LOGS,
        data: {"logs": logs},
        queryParameters: {'code': StorageHelper.userCode},
        options: Options(headers: {
          'Authorization': "Bearer $token",
          'Accept': "applications/json"
        }),
      );
      // }

      if (NumUtils.getFirstDigit(response.statusCode) == 2) {
        return BaseResponse<String>(
          status: "success",
          data: MessageHelper.getResponseMsg(response.data),
        );
      }
      if (NumUtils.getFirstDigit(response.statusCode) == 4) {
        if (response.statusCode == 401) {
          MessageHelper.error("Session Expired");

          await Get.find<AuthController>().logout();
        }
        if (response.statusCode == 422) {
          return BaseResponse<String>(
            status: "error",
            data: MessageHelper.getResponseMsg(response.data),
          );
        }
      }

      if (NumUtils.getFirstDigit(response.statusCode) == 5) {
        return BaseResponse<String>(
          status: "error",
          data: MessageHelper.getResponseMsg(response.data),
        );
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      // _timer?.cancel();
      return BaseResponse(
        status: "error",
        data: null,
        error:
            ExceptionHelper.getExceptionMessage(e, name: "SFA_LOCATION_LOGS"),
      );
    }
  }
}
