import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_all_orders.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_group_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_order_report.dart';
import 'package:my_peopler/src/models/sfa/subordinates_model.dart';
import 'package:my_peopler/src/services/sfaHttpService.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/marketing_scheme/api_model/market_scheme_view_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:path_provider/path_provider.dart';

@Injectable(env: [Env.prod])
@Singleton()
class SfaProductListRepository {
  final SfaHttpService client;

  SfaProductListRepository(this.client);

  // Projects
  Future<SfaProductModel> getSfaProductList(
      int? customerId, String searchData, String groupId) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_PRODUCTS,
        queryParameters: {
          'code': StorageHelper.userCode,
          'customer_id': customerId,
          'search': searchData,
          'group_id': groupId
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
        return sfaProductModelFromJson(json.encode(responseData));
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return SfaProductModel(data: []);
    }
  }

  Future<dynamic> postSfaProductList(int customerId,
      List<SfaProduct> addedProducts, String assignedfor,String? action,{int? orderId}) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      Position position = await Geolocator.getCurrentPosition();

      var response = await client.post(
        endPoint: Endpoints.SFA_ORDERS,
        queryParameters: {
          'code': StorageHelper.userCode,
        },
        data: {
          'customer_id': customerId,
          'order_id':orderId,
          'items': List<dynamic>.from(addedProducts.map((x) => x.toJson())),
          'lat': position.latitude,
          'long': position.longitude,
          'assignedfor': assignedfor,
          'action':action
        },
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
      } else {
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return 'Error';
    }
  }

   Future<dynamic> postSfaMarketSchemePrice(String title, NepaliDateTime startDate, NepaliDateTime endDate, List<ProductItem> product, List<SfaCustomerListModel> customers) async {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }

      var response = await client.post(
        endPoint: Endpoints.SFA_MARKETING_SCHEME,
        queryParameters: {
          'code': StorageHelper.userCode,
        },
        data: {
          'title': title,
          'from_date': MyDateUtils.getNepaliDateOnly(startDate),
          'to_date': MyDateUtils.getNepaliDateOnly(endDate),
           'items': List<dynamic>.from(product.map((x) => x.toJson())),
           'customer_id': List<int>.from(customers.map((e) => e.id)).toList()
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
        return responseData['message'];
      }

      if (response.statusCode == 422) {
        Fluttertoast.showToast(msg: responseData['message'], backgroundColor: Colors.red);
      }

      if (response.statusCode == 401) {

        await Get.find<AuthController>().logout();
        throw CustomException("Session Expired.");
      }
      throw (ApiException("Something went wrong"));
  }

  Future<MarketSchemeModel> getSfaMarketScheme(int customerID) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_MARKETING_SCHEME,
        queryParameters: {
        'code': StorageHelper.userCode,
        'customer_id': customerID,

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
        return marketSchemeModelFromJson(json.encode(responseData));
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
      return MarketSchemeModel(data: []);
    }
  }

  Future<dynamic> editProductOrderReport(ProductOrderReport editedItems) async {
    try {

      var token = StorageHelper.token;
      
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      
      var response = await client.put(
        endPoint: '${Endpoints.SFA_ORDERS}/${editedItems.id}',
        queryParameters: {
          'code': StorageHelper.userCode,
        },
        data: {
          'customer_id': editedItems.customerId,
          'items':
              List<dynamic>.from(editedItems.items!.map((x) => x.toJson())),
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
        return responseData["message"];
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

  Future<SfaAllOrders> getSfaOrders(int? customerId) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_ORDERS,
        queryParameters: {
          'code': StorageHelper.userCode,
          'customer_id': customerId,
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
        return sfaAllOrdersFromJson(json.encode(responseData));
      }

      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      } else {
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return SfaAllOrders(data: []);
    }
  }

  Future<dynamic> getSfaOrdersReport(
      int dispatchable, 
      String type,
      {NepaliDateTime? start, 
     NepaliDateTime? end,
      int? subOrdinateId,
      String? statusType,
      int? customerId,
      int? productId,
      int? beatId,
       String? status,
      int? exported
      }) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_ORDERS,
        queryParameters: {
          'code': StorageHelper.userCode,
          'dispatchable': dispatchable,
          'type': type,
          'from_date': MyDateUtils.getNepaliDateOnly(start),
          'to_date': MyDateUtils.getNepaliDateOnly(end),
          'employee_id':subOrdinateId,
          'status_type':statusType,
          'customer_id':customerId,
          'product_id':productId,
          'beat_id':beatId,
          'status':status,
          'export':exported
        },
        options: Options(
          responseType: exported==1? ResponseType.bytes:ResponseType.json,
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if(exported==1){
         //return responseData;
        // Get the directory for saving the PDF
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String appDocPath = appDocDir.path;
    
        // Save the PDF file
        final File file = File('$appDocPath/allApproved.pdf');
        await file.writeAsBytes(response.data);
        return file;
      }else{
        if (response.statusCode == 200) {
          return sfaProductOrderReportFromJson(json.encode(responseData));
        }
      }
      

      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      } else {
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return SfaProductOrderReport(data: []);
    }
  }

  // Sfa Product Group List
  Future<SfaProductGroupListModel> getSfaProductGroupList(
      int customerId, String searchData) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SFA_PRODUCTS_GROUPS,
        queryParameters: {
          'code': StorageHelper.userCode,
          'customer_id': customerId,
          'search': searchData
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

  // Sfa Product Order Report Change Status
  Future<dynamic> changeOrderStatus(OrderStatus data) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.SFA_ORDERS_CHANGE_STATUS,
        queryParameters: {
          'code': StorageHelper.userCode,
        },
        data: {
          'status': data.status,
          'order_id': data.orderId,
          'note': data.note,
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

  // Get the name of sub ordinates
  Future<SubordinatesModel> getSubOrdinates() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.SUBORDINATES,
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
        return subordinatesModelFromJson(json.encode(responseData));
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      } else {
        return responseData["message"];
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return SubordinatesModel(data: []);
    }
  }

  // Sfa dispatch order
  Future<dynamic> dispatchOrder(List<OrderDispatch> data) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
        endPoint: Endpoints.SFA_ORDERS_DISPATCH,
        queryParameters: {
          'code': StorageHelper.userCode,
        },
        data: {
          'customer_id': data[0].customerId,
          'order_id': data[0].orderId,
          'status': data[0].status,
          'items':List<dynamic>.from(data.map((x) => x.toJson())),
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

  //print order slip
  Future<dynamic> printOrderSlip(String orderId) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }

      var response = await client.get(
        endPoint: Endpoints.SFA_ORDER_SLIP,
        queryParameters: {
          'code': StorageHelper.userCode,
          'order_id':orderId
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
        final File file = File('$appDocPath/$orderId.pdf');
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
