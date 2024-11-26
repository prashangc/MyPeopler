import 'package:dio/dio.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/services/services.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

@Injectable(env: [Env.dev, Env.prod])
@Singleton()
class AttendanceRepository {
  final IHttpService client;

  AttendanceRepository(this.client);

  // Attendance
  Future<BaseResponse> getAttendance(NepaliDateTime? fromDate, NepaliDateTime? toDate, int? employeeID) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
          endPoint: Endpoints.ATTENDANCES,
          queryParameters: {
            'code': StorageHelper.userCode,
            'from_date': fromDate != null ? MyDateUtils.getNepaliDateOnly(fromDate) : null,
            'to_date': toDate != null? MyDateUtils.getNepaliDateOnly(toDate) : null,
            'employee_id': employeeID
          },
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<AttendancesResponse>(
          status: "success",
          data: AttendancesResponse.fromJson(responseData),
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
        error: ExceptionHelper.getExceptionMessage(e, name: "getAttendance"),
      );
    }
  }

  //punch
  Future<BaseResponse> punch({List<String?>? details}) async {
    try {
      var token = StorageHelper.token;

      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      Position position = await Geolocator.getCurrentPosition();
      var response = await client.post(
          endPoint: Endpoints.PUNCH,
          queryParameters: {
            'code': StorageHelper.userCode,
            'lat': position.latitude,
            'long': position.longitude,
            //position.
          },
          data:  {
            'explanation': details?[0] ?? '',
            'title': details?[1] ?? ''
          },
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }));

      if (response.statusCode == 200) {
        return BaseResponse(status: 'success', data: response.data);
      }

      if (response.statusCode == 401) {
        MessageHelper.error('Session Expired');
        await Get.find<AuthController>().logout();
      }
      throw (ApiException('Something went wrong'));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e, name: "Not punched"),
      );
    }
  }
}
