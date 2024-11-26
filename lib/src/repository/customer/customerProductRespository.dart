import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/customer/order_history/customer_order_history_model.dart';
import 'package:my_peopler/src/models/customer/product/customer_product_model.dart';

import 'package:my_peopler/src/models/sfa/sfa_product_group_list_model.dart';

import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/services/iHttpService.dart';

@Injectable(env: [Env.prod])
@Singleton()
class CustomerProductListRepository {
  final IHttpService client;

  CustomerProductListRepository(this.client);

  // Projects
  Future<CustomerProductModel> getCustomerProductList() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_PRODUCTS,
        queryParameters: {'code': StorageHelper.userCode},
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return customerProductModelFromJson(json.encode(responseData));
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return CustomerProductModel(data: []);
    }
  }

  Future<dynamic> postCustomerProductList(List<ProductModel> addedProducts) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
     
      var response = await client.post(
        endPoint: Endpoints.SFA_CUSTOMER_ORDER,
        queryParameters: {'code': StorageHelper.userCode,},
        data: {
          'items':List<dynamic>.from(addedProducts.map((x) => x.toJson())),
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );

      var responseData = response.data;
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


  Future<CustomerOrderHistoryModel> getCustomerOrderHistory() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_CUSTOMER_ORDER,
        queryParameters: {'code': StorageHelper.userCode,},
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;

      if (response.statusCode == 200) {
        return customerOrderHistoryModelFromJson(json.encode(responseData));
      }

      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      }else{
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return CustomerOrderHistoryModel(data: []);
    }
  }

   // Sfa Product Group List
  Future<SfaProductGroupListModel> getSfaProductGroupList(int customerId,String searchData) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_PRODUCTS_GROUPS,
        queryParameters: {'code': StorageHelper.userCode,'customer_id':customerId,'search':searchData},
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return sfaProductGroupListModelFromJson(json.encode(responseData));
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return SfaProductGroupListModel(data: []);
    }
  }
}
