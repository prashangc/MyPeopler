import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_beat_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_class_type_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_client_type_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_dashboard_model.dart';
import 'package:my_peopler/src/models/sfa_task/sfa_task.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/services/sfaHttpService.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

@Injectable(env: [Env.prod])
@Singleton()
class SfaCustomerListRepository {
  final SfaHttpService client;
  SfaCustomerListRepository(this.client);


  //Sfa Dashboard Data
  Future<SfaDashBoardModel> getSfaDashboardData(
    {
    String? type,
    NepaliDateTime? start,
    NepaliDateTime? end,
    int? employeeId,
    int? customerId,
    int? productId,
    int? beatId,
    int? clientId
   }
  ) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_DASHBOARD,
        queryParameters: {
          'code': StorageHelper.userCode,
          'type':type,
          'from_date': start != null? MyDateUtils.getNepaliDateOnly(start) : start,
          'to_date': start != null? MyDateUtils.getNepaliDateOnly(end) : end,
          'employee_id':employeeId,
          'product_id':productId,
          'customer_id':customerId,
          'beat_id':beatId,
          'client_type_id': clientId
          },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      log(response.realUri.toString());
      var responseData = response.data;
      if (response.statusCode == 200) {
        return sfaDashBoardModelFromJson(json.encode(responseData));
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return SfaDashBoardModel();
    }
  }

  // Projects
  Future<SfaCustomerList> getSfaCustomerList(String? assignedfor,bool skipAssignment, {int? customer_id, bool marketScheme = false}) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_CUSTOMER_LIST,
        queryParameters: marketScheme? 
        {
          'code': StorageHelper.userCode,
          'assignedfor':assignedfor,
          'new':true,
         'skip_assignment':skipAssignment?1:0,
          'customer_id': customer_id
          }:
        {
          'code': StorageHelper.userCode,
          'assignedfor':assignedfor,
          'new':true,
         'skip_assignment':skipAssignment?1:0
          },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      log(response.realUri.toString());
      var responseData = response.data;
      if (response.statusCode == 200) {
        return sfaCustomerListModelFromJson(json.encode(responseData.isEmpty?{}:responseData));
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return SfaCustomerList(clientLists: {});
    }
  }

  Future<dynamic> postSfaCustomer(CustomerData? customerData) async {
    var responseData;
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.SFA_CUSTOMER_LIST,
        queryParameters: {'code': StorageHelper.userCode},
        data: {
          'name': customerData?.name ?? '',
          'contact': customerData?.contactNumber ?? '',
          'client_type_id': customerData?.clientId ?? '',
          'class_id': customerData?.classId ?? '',
          'beat_id':customerData?.beatId ?? '',
          'parent_id':customerData?.parentId ?? '',
          'address': customerData?.address ?? '',
          'email':customerData?.email ?? '',
          'establish_year':customerData?.establishedYear ?? '',
          'pan_vat':customerData?.panNumber??'',
          'lat':customerData?.latitude ?? '',
          'long':customerData?.longitude ?? '',
          'contact_name':customerData?.contactPersonName ?? '',
          'contact_position':customerData?.contactPersonPosition ?? '',
          'contact_phone':customerData?.contactPersonNumber ?? '',
          'contact_gender':customerData?.contactPersonGender ?? '',
          'contact_email':customerData?.contactPersonEmail ?? ''
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      responseData = response.data;
      if (response.statusCode == 200) {
        return responseData["message"];
      }

      //  if (response.statusCode == 422) {
      //   return 'Please try again';
      // }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return responseData["message"];
    }
  }

  Future<List<ClientTypeOptions>> getClientTypeOptions() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_CLIENT_TYPE_OPTIONS,
        queryParameters: {
          'code': StorageHelper.userCode,
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
        return clientTypeOptionsFromJson(json.encode(responseData));
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

    Future<List<BeatOptionsModel>> getBeatOptions() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_BEAT_OPTIONS,
        queryParameters: {
          'code': StorageHelper.userCode,
          'no_limit':1
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
        return beatOptionsModelFromJson(json.encode(responseData));
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

  Future<List<ClassTypeOptions>> getCustomerClassOptions() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_CUSTOMER_CLASS_OPTIONS,
        queryParameters: {
          'code': StorageHelper.userCode,
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
        return classTypeOptionsFromJson(json.encode(responseData));
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

  Future<List<SfaTaskResponse>> getTaskList() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_TASKS,
        queryParameters: {'code': StorageHelper.userCode, 'date': ''},
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return sfaTaskResponseFromJson(json.encode(responseData));
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

  Future<dynamic> toggleTaskItems(int taskId, int taskItemId) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.SFA_TASKS_ITEM_TOGGLER,
        queryParameters: {
          'code': StorageHelper.userCode,
          'task_id': taskId,
          'task_item_id': taskItemId
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
        return json.encode(responseData);
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
