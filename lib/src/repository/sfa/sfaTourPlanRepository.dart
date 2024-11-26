import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/models/sfa/sfa_tour_plan_model.dart';
import 'package:my_peopler/src/services/sfaHttpService.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';


@Injectable(env: [Env.prod])
@Singleton()
class SfaTourPlanRepository {
  final SfaHttpService client;

  SfaTourPlanRepository(this.client);

  // Projects
  Future<SfaTourPlanModel> getSfaTourPlan({NepaliDateTime? start, NepaliDateTime? end}) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_MY_TOUR_PLAN,
        queryParameters: {
        'code': StorageHelper.userCode,
        'from_date': start != null? MyDateUtils.getNepaliDateOnly(start) : start,
        'to_date': end != null? MyDateUtils.getNepaliDateOnly(end) : end
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return sfaTourPlanModelFromJson(json.encode(responseData));
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
      return SfaTourPlanModel(data: []);
    }
  }

  Future<SfaTourPlanModel> getSfaAllTourPlan(
  { String? type,
  String? start,
  String? end,
  int? employeeId
  }) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");

      }
      var response = await client.get(
        endPoint: Endpoints.SFA_TOUR_PLAN,
        queryParameters: {
        'code': StorageHelper.userCode,
        'type':type,
        'from_date': start,
        'to_date': end,
        'employee_id':employeeId
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return sfaTourPlanModelFromJson(json.encode(responseData));
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
      return SfaTourPlanModel(data: []);
    }
  }

   Future<dynamic> approveTourPlan(TourPlanData data) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.SFA_TOUR_PLAN_APPROVE,
        data: {
          'status':data.status,
          'tourplan_id':data.tourPlanId,
          'note':data.note,
        },
        queryParameters: {
        'code': StorageHelper.userCode,},
        options: Options(
          
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return responseData["message"];
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
      return 'Tour plan not approved';
    }
  }

  Future<dynamic> postSfaTourPlan(SfaTourPlan tourPlan) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
     
      var response = await client.post(
        endPoint: Endpoints.SFA_TOUR_PLAN,
        queryParameters: {'code': StorageHelper.userCode,},
        data: tourPlan.toJson(),
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;

      if (response.statusCode == 201) {
        return responseData["order_number"];
      }

      if (response.statusCode == 500) {
        return responseData["message"];
      }

      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      }else{
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return 'Error';
    }
  }

 Future<dynamic> createTourPlanNote(int? id, String action, String note) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.SFA_TOUR_PLAN_NOTE,
        data: {
          'tourplan_id':id,
          'action':action,
          'note':note,
        },
        queryParameters: {
        'code': StorageHelper.userCode,},
        options: Options(
          
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return 'Tour plan not saved/completed';
    }
  }
}
