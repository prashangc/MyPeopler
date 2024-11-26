import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/expenses/expense_model.dart';
import 'package:my_peopler/src/models/expenses/expenses_categories.dart';
import 'package:my_peopler/src/models/expenses/get_expenses_model.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/services/services.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class Expenses {
  String categoryId;
  String amount;
  String description;
  String date;
  int? updateId;
  File? attachment;

  Expenses(this.categoryId, this.amount, this.description, this.date,
      this.attachment,
      [this.updateId]);
}

@Injectable(env: [Env.dev, Env.prod])
@Singleton()
class ExpenseRepository {
  final IHttpService client;

  ExpenseRepository(this.client);

  // expenses
  Future<BaseResponse> getExpenseCategories() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
          endPoint: Endpoints.EXPENSE_CATEGORIES,
          queryParameters: {'code': StorageHelper.userCode},
          options: dio.Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<ExpensesCategoriesModel>(
          status: "success",
          data: ExpensesCategoriesModel.fromJson(responseData),
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
        error: ExceptionHelper.getExceptionMessage(e, name: "getAwards"),
      );
    }
  }

  Future<BaseResponse> postExpenses(Expenses expenses) async {
    String fileName = '';
    if (expenses.attachment != null) {
      fileName = expenses.attachment!.path.split('/').last;
    }

    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
          endPoint: Endpoints.EXPENSES,
          data: dio.FormData.fromMap({
            'expense_category_id': expenses.categoryId,
            'amount': expenses.amount,
            'description': expenses.description,
            'date': expenses.date.split(' ')[0],
            'attachment': expenses.attachment == null
                ? null
                : await dio.MultipartFile.fromFile(expenses.attachment!.path,
                    filename: fileName),
          }),
          queryParameters: {'code': StorageHelper.userCode},
          options: dio.Options(
            headers: {
              'Authorization': "Bearer $token",
              'Accept': "applications/json"
            },
          ));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<dynamic>(
          status: "success",
          data: responseData,
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
        error: ExceptionHelper.getExceptionMessage(e, name: "getAwards"),
      );
    }
  }

  Future<BaseResponse> editExpenses(Expenses expenses) async {
    String fileName = '';
    if (expenses.attachment != null) {
      fileName = expenses.attachment!.path.split('/').last;
    }

    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
          endPoint: '${Endpoints.EXPENSES}/${expenses.updateId}',
          data: dio.FormData.fromMap({
            'expense_category_id': expenses.categoryId,
            'amount': expenses.amount,
            'description': expenses.description,
            'date': expenses.date.split(' ')[0],
            'attachment': expenses.attachment == null
                ? null
                : await dio.MultipartFile.fromFile(expenses.attachment!.path,
                    filename: fileName),
            '_method': 'PUT'
          }),
          queryParameters: {'code': StorageHelper.userCode},
          options: dio.Options(
            headers: {
              'Authorization': "Bearer $token",
              'Accept': "applications/json"
            },
          ));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<dynamic>(
          status: "success",
          data: responseData,
        );
      }

      if (response.statusCode == 401) {
        var message = responseData['message'];
        MessageHelper.error(message);
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e, name: "Error"),
      );
    }
  }

  Future<ExpenseData?> getExpenses({
    String? type,
    int? employeeId,
    NepaliDateTime? start,
    NepaliDateTime? end,
  }) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
          endPoint: Endpoints.EXPENSES,
          queryParameters: {
            'code': StorageHelper.userCode,
            'type': type,
            'from_date': MyDateUtils.getNepaliDateOnly(start),
            'to_date': MyDateUtils.getNepaliDateOnly(end),
            'employee_id': employeeId
          },
          options: dio.Options(
            headers: {
              'Authorization': "Bearer $token",
              'Accept': "applications/json"
            },
          ));
      var responseData = response.data;
      if (response.statusCode == 200) {
        return expenseDataFromJson(json.encode(responseData));
      }
     
     if (response.statusCode == 404) {
        MessageHelper.error(responseData['message']);
      }
     
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      }
      return null;
    } catch (e) {
      throw (ApiException("Something went wrong"));
    }
  }

  Future<dynamic> changeStatus(
      {required int expenseId, required String status, required int approvedAmount ,String? note}) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
          endPoint: Endpoints.EXPENSES_STATUS_CHANGE,
          data: dio.FormData.fromMap({
            'expense_id': expenseId,
            'status': status,
            'note': note,
            'approved_amount': approvedAmount
          }),
          queryParameters: {'code': StorageHelper.userCode},
          options: dio.Options(
            headers: {
              'Authorization': "Bearer $token",
              'Accept': "applications/json"
            },
          ));
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

  Future<dynamic> changeBulkStatus(
      {required List<Expense>? expense, required String? status}) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
          endPoint: Endpoints.EXPENSES_BULK_STATUS_CHANGE,
          data: {
            'expense_id': List<int>.from(expense!.map((e) => e.id)).toList(),
            'status': status,
          },
          queryParameters: {'code': StorageHelper.userCode},
          options: dio.Options(
            headers: {
              'Authorization': "Bearer $token",
              'Accept': "applications/json"
            },
          ));
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
}
