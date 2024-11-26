import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/models/sfa/sfa_estimated_customer_report_model.dart';
import 'package:my_peopler/src/services/iHttpService.dart';

@Injectable(env: [Env.prod])
@Singleton()
class SfaEstimatedCustomerRepository {
  final IHttpService client;

  SfaEstimatedCustomerRepository(this.client);

  Future<List<Datum>> getSfaCustomerReport(String? date, int? subOrdinateId) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_ESTIMATED_CUSTOMER_REPORT,
        queryParameters: {
          'code': StorageHelper.userCode,
          'date': date,
          'employee_id': subOrdinateId
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token", //"Bearer $token",
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return 
            estimatedCustomerReportModelFromJson(json.encode(responseData))
                .data;
      }

      if (response.statusCode == 400) {
        MessageHelper.error(responseData['error']);
      }

      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return [];
    }
  }
}
