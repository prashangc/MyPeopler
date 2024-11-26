import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/models/baseResponse.dart';
import 'package:my_peopler/src/models/sfa/sfa_payment_schedule_model.dart';
import 'package:my_peopler/src/services/sfaHttpService.dart';

@Injectable(env: [Env.prod])
@Singleton()
class SfaPaymentScheduleRepository {
  final SfaHttpService client;

  SfaPaymentScheduleRepository(this.client);

  // Projects
  Future<SfaPaymentScheduleModel> getSfaPaymentSchedule() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.PAYMENT_SCHEDULE,
        queryParameters: {
          'code': StorageHelper.userCode,
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return sfaPaymentScheduleModelFromJson(json.encode(responseData));
      }

      if (response.statusCode == 500) {
        return responseData["message"];
      }

      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return SfaPaymentScheduleModel(data: []);
    }
  }

   Future  updatePaymentSchedule({required int itemId, required String planningAmount, required String planning_date}) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.PAYMENT_SCHEDULE,
        queryParameters: {
          'code': StorageHelper.userCode,
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
        data: {
          'planning_amount': planningAmount,
          'planning_date': planning_date,
          'payment_schedule_item_id': itemId
        }
      );
     
       var responseData = response.data;
      if (response.statusCode == 200) {
         return responseData["message"];
      }

      if (response.statusCode == 500) {
        return responseData["message"];
      }

      if (response.statusCode == 422) {
        return responseData["error"];
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
        error: ExceptionHelper.getExceptionMessage(e, name: "update error"),
      );
    }
  }
}
