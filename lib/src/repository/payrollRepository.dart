import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/models/payroll/payslip_response.dart';
import 'package:my_peopler/src/services/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(env: [Env.dev, Env.prod])
@Singleton()
class PayrollRepository {
  final IHttpService client;

  PayrollRepository(this.client);

  // Payroll
  Future<BaseResponse> getPayroll() async {
    try {
      var token = StorageHelper.token;
      var response = await client.get(
          endPoint: Endpoints.PAYROLL,
          queryParameters: {'code': StorageHelper.userCode},
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<PayrollResponse>(
          status: "success",
          data: PayrollResponse.fromJson(responseData),
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
        error: ExceptionHelper.getExceptionMessage(e, name: "getPayroll"),
      );
    }
  }

   // PAYSLIPS
  Future<BaseResponse> getPayslips() async {
    try {
      var token = StorageHelper.token;
      var response = await client.get(
          endPoint: Endpoints.MY_PAYSLIPS,
          queryParameters: {'code': StorageHelper.userCode},
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<List<PayslipResponse>>(
          status: "success",
          data:  payslipResponseFromJson(jsonEncode(responseData))
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
        error: ExceptionHelper.getExceptionMessage(e, name: "getPayslips"),
      );
    }
  }
}
