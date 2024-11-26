import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/controllers/sfaPaymentCollectionController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_payment_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_payment_methods_model.dart';
import 'package:my_peopler/src/services/sfaHttpService.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:path_provider/path_provider.dart';

@Injectable(env: [Env.prod])
@Singleton()
class SfaPaymentListRepository {
  final SfaHttpService client;

  SfaPaymentListRepository(this.client);

  // Projects
  Future<List<SfaPaymentList>> getSfaPaymentList(
      {int? customerId,
      String? type,
      String? start,
      String? end,
      int? employeeId}) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      // print(start);
      // print(end);
      DateTime startDate = DateTime.parse(start.toString());
      DateTime endDate = DateTime.parse(end.toString());
      NepaliDateTime nepStartDate = startDate.toNepaliDateTime();
      NepaliDateTime nepEndDate = endDate.toNepaliDateTime();
      print(nepStartDate);
      print(nepEndDate);
      String endpoint = customerId == null
          ? Endpoints.SFA_PAYMENTS
          : '${Endpoints.SFA_PAYMENTS}/$customerId';
      var response = await client.get(
        endPoint: endpoint,
        queryParameters: customerId != null
            ? {
                'code': StorageHelper.userCode,
                'type': type,
                'from_date': start,
                'to_date': end,
                'customer_id': customerId
              }
            : {
                'code': StorageHelper.userCode,
                'type': type,
                'from_date': start,
                'to_date': end,
                'customer_id': customerId
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
        return Future.value(
            sfaPaymentListModelFromJson(json.encode(responseData)).data);
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

  Future<List<SfaPaymentMethods>> getSfaPaymentMethods() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_PAYMENT_METHODS,
        queryParameters: {'code': StorageHelper.userCode},
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
        return Future.value(
            sfaPaymentMethodsModelFromJson(json.encode(responseData)).data);
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

  Future<dynamic> approvePayment(PaymentDataStatus data) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.SFA_PAYMENT_METHODS_APPROVE,
        queryParameters: {'code': StorageHelper.userCode},
        data: {
          'status': data.status,
          'payment_id': data.paymentId,
          'note': data.note
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
        return responseData["message"];
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      } else {
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return 'Not able to perform operation';
    }
  }

  Future<dynamic> postSfaPayment(PaymentData? customerData) async {
    var responseData;
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.SFA_PAYMENTS,
        queryParameters: {'code': StorageHelper.userCode},
        data: {
          'amount': customerData?.amount ?? '',
          'customer_id': customerData?.customerId ?? '',
          'method': customerData?.method ?? '',
          'ref_no': customerData?.refNo ?? '',
          'payment_note': customerData?.notes ?? '',
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
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return responseData["message"];
    }
  }

  //print payment slip
  Future<dynamic> printPaymentSlip(String paymentId) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }

      var response = await client.get(
        endPoint: Endpoints.SFA_PAY_SLIP,
        queryParameters: {
          'code': StorageHelper.userCode,
          'payment_id': paymentId
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;

      if (response.statusCode == 200) {
        //return responseData;
        // Get the directory for saving the PDF
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String appDocPath = appDocDir.path;

        // Save the PDF file
        final File file = File('$appDocPath/$paymentId.pdf');
        await file.writeAsBytes(response.data);
        return file;
      }

      if (response.statusCode == 500) {
        return responseData["message"];
      }

      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      } else {
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return 'Error';
    }
  }
}
