// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/models/sfa/sfa_all_orders.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_group_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_order_report.dart';
import 'package:my_peopler/src/models/sfa/subordinates_model.dart';
import 'package:my_peopler/src/repository/sfa/sfaProductListRepository.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/marketing_scheme/api_model/market_scheme_view_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class OrderStatus {
  String? status;
  int? orderId;
  String? note;

  OrderStatus({
    this.status,
    this.orderId,
    this.note,
  });
}

class OrderDispatch {
  String? status;
  int? orderId;
  int? customerId;
  int? id;
  String? dispatchQuantity;

  OrderDispatch({
    this.status,
    this.orderId,
    this.customerId,
    this.id,
    this.dispatchQuantity,
  });

  Map<String, dynamic> toJson() => {"id": id, "dispatch_qty": dispatchQuantity};
}

class ProductItem {
  int? productCategoryID;
  int? productID;
  int? amount;
  String? type;
  int? saleQty;
  int? bonusQty;


  ProductItem({
    this.productCategoryID,
    this.productID,
    this.amount,
    this.type,
    this.saleQty,
    this.bonusQty
  });

  Map<String, dynamic> toJson() => {
  "product_category_id": productCategoryID, 
  "product_id": productID,
  "amount": amount,
  "type": type,
  "sale_qty": saleQty,
  "bonus_qty": bonusQty
  };
}

class SfaProductListController extends GetxController {
  final SfaProductListRepository _sfaProductListRepository =
      getIt<SfaProductListRepository>();

  SfaProductModel? _sfaProductModel;
  SfaProductModel? get sfaProductModel => _sfaProductModel;

  SfaProductModel? _sfaProductByGroupFilterModel;
  SfaProductModel? get sfaProductByGroupFilterModel =>
      _sfaProductByGroupFilterModel;

  SfaProductGroupListModel _sfaProductGroupListModel =
      SfaProductGroupListModel();
  SfaProductGroupListModel get sfaProductGroupListModel =>
      _sfaProductGroupListModel;

  bool isLoading = false;
  int? customerId;
  int? get getcustomerId => customerId;

  List<SfaProduct> addedProducts = [];
  List<SfaProduct> sfaProductByGroupFilterModelConstant = [];
  List<SfaProductGroupList> sfaProductGroupList = [];

  List<SfaOrders>? sfaOrders = [];
  List<ProductOrderReport>? productOrderReport = [];
  num totalAmount = 0;
  num totalAvailableQuantity = 0;
  num totalAskQuantity = 0;
  num totalMrp = 0;
  num totalSellingPrice = 0;

  List<ProductOrderReport>? unchangableOrderReport;
  ProductOrderReport? reportDetails;
  List<Datum> newPriceView = [];

  NepaliDateTime? startDate;
  NepaliDateTime? endDate;

  List<Subordinates>? subOrdinates = [];
  List<OrderDispatch>? orderDispatch = [];

  TextEditingController? employeeFilterName;
  @override
  void onInit() async {
    if (getcustomerId != null) {
      await getSfaProductList('');
    }
    super.onInit();
  }

  getSfaProductList(String searchData, {String? groupId}) async {
    //if (addedProducts.isEmpty) {
    isLoading = true;
    //update();
    var res = await _sfaProductListRepository.getSfaProductList(
        getcustomerId, searchData, groupId ?? '');
    if (res.data!.isNotEmpty) {
      if (groupId != null) {
        _sfaProductByGroupFilterModel = res;
        sfaProductByGroupFilterModelConstant =
            _sfaProductByGroupFilterModel?.data ?? [];
        checkMarkGroupByFilter();
        log(_sfaProductByGroupFilterModel.toString(),
            name: "sfaProductByGroupFilterModel");
      } else {
        _sfaProductModel = res;
        log(_sfaProductModel.toString(), name: "sfaProductModel");
      }
      isLoading = false;
      update();
    } else if (res.data!.isEmpty) {
      if (groupId != null) {
        _sfaProductByGroupFilterModel?.data = [];
        sfaProductByGroupFilterModelConstant = [];
      } else {
        _sfaProductModel?.data = [];
      }

      isLoading = false;
      update();
    }
    // }
  }

  postSfaProductList(String? assignedfor, String? action, int? orderId) async {
    isLoading = true;
    update();
    var res = await _sfaProductListRepository.postSfaProductList(
        getcustomerId!, addedProducts, assignedfor!, action,
        orderId: orderId);
    isLoading = false;
    addedProducts = [];
    return res;
  }

   postSfaMarketScheme( String title, NepaliDateTime startDate, NepaliDateTime endDate, List<ProductItem> product, List<SfaCustomerListModel> customers) async {
    isLoading = true;
    update();
    var res = await _sfaProductListRepository.postSfaMarketSchemePrice(title, startDate, endDate, product, customers);
    isLoading = false;
    update();
    return res;
  }

  getSfaMarketScheme(int customerID) async {
    isLoading = true;
    update();
    var res = await _sfaProductListRepository.getSfaMarketScheme(customerID);
    isLoading = false;
    newPriceView = res.data;
    update();
  }

  getSfaOrders() async {
    isLoading = true;
    update();
    var res = await _sfaProductListRepository.getSfaOrders(getcustomerId);
    isLoading = false;
    sfaOrders = res.data;
    update();
  }

  getSfaOrdersReport(
      {required int dispatchable,
      required String type,
      NepaliDateTime? start,
      NepaliDateTime? end,
      int? subOrdinateId,
      int? customerId,
      int? productId,
      int? beatId,
      String? statusType,
      String? status,
      int? exported
      
      }) async {
    isLoading = true;
    update();
    //dispatchable->0 //false
    //dispatchable->1 //true
    var res = await _sfaProductListRepository.getSfaOrdersReport(
        dispatchable, type,
        start: start,
        end: end,
        subOrdinateId: subOrdinateId,
        statusType: statusType,
        customerId: customerId,
        productId: productId,
        beatId: beatId,
        status:status,
        exported:exported
        );
    isLoading = false;
    if(exported == 1){
       update();
      return res;
    }else{
       productOrderReport = res.data;
      unchangableOrderReport = res.data;
      update();
      return res.data;
    }
   
  }

  addProducts(SfaProduct product) {
    bool isDuplicateData = false;
    for (var i = 0; i < addedProducts.length; i++) {
      if (addedProducts[i].id == product.id) {
        addedProducts[i].askQuantity = product.askQuantity!;
        addedProducts[i].availableQuantity = product.availableQuantity;
        addedProducts[i].sellingPrice = product.sellingPrice;
        isDuplicateData = true;
        break;
      }
    }

    if (isDuplicateData == false) {
      addedProducts.add(product);
    }

    for (var i = 0; i < _sfaProductModel!.data!.length; i++) {
      for (var element in addedProducts) {
        if (element.id == _sfaProductModel!.data![i].id) {
          _sfaProductModel!.data![i].isSelected = element.isSelected;
        }
      }
    }

    checkMarkGroupByFilter();
    total();
    update();
  }

  removeAllProducts() {
    addedProducts.clear();
  }

  void checkMarkGroupByFilter() {
    if (_sfaProductByGroupFilterModel != null) {
      if (_sfaProductByGroupFilterModel!.data!.isNotEmpty) {
        for (var i = 0; i < _sfaProductByGroupFilterModel!.data!.length; i++) {
          for (var element in addedProducts) {
            if (element.id == _sfaProductByGroupFilterModel!.data![i].id) {
              _sfaProductByGroupFilterModel!.data![i].isSelected =
                  element.isSelected;
            }
          }
        }
      }
    }
    update();
  }

  removeProducts(int index) {
    addedProducts[index].isSelected = false;
    for (var i = 0; i < _sfaProductModel!.data!.length; i++) {
      for (var element in addedProducts) {
        if (element.id == _sfaProductModel!.data![i].id) {
          _sfaProductModel!.data![i].isSelected = element.isSelected;
        }
      }
    }
    addedProducts.removeAt(index);
    total();
  }

  editProduct(int index, SfaProduct editedProduct) {
    addedProducts[index].code = editedProduct.code;
    addedProducts[index].name = editedProduct.name;
    addedProducts[index].price = editedProduct.price;
    addedProducts[index].sellingPrice = editedProduct.sellingPrice;
    addedProducts[index].availableQuantity = editedProduct.availableQuantity;
    addedProducts[index].askQuantity = editedProduct.askQuantity;
    update();
    total();
  }

  searchProducts(List<SfaProduct>? initialProducts) {
    _sfaProductModel?.data = initialProducts;
    update();
  }

  searchProductsFilterByGroup(List<SfaProduct>? initialProducts) {
    _sfaProductByGroupFilterModel?.data = initialProducts;
    checkMarkGroupByFilter();
    update();
  }

  searchGroup(List<SfaProductGroupList>? initialGroup) {
    _sfaProductGroupListModel.data = initialGroup;
    update();
  }

  getSfaProductGroupList(String searchData) async {
    if (addedProducts.isEmpty) {
      isLoading = true;
      //update();
      var res = await _sfaProductListRepository.getSfaProductGroupList(
          getcustomerId!, searchData);
      if (res.data!.isNotEmpty) {
        _sfaProductGroupListModel = res;
        log(_sfaProductGroupListModel.toString(), name: "sfaProductGroupModel");
        isLoading = false;
        update();
      } else if (res.data!.isEmpty) {
        _sfaProductGroupListModel.data = [];
        isLoading = false;
        update();
      }
    }
  }

  total() {
    num total = 0;
    num tSellingPrice = 0;
    num tMrp = 0;
    num tAvailableQuantity = 0;
    num tAskQuantity = 0;

    for (var element in addedProducts) {
      total = total + element.sellingPrice! * element.askQuantity!;
      tSellingPrice = tSellingPrice + element.sellingPrice!;
      tMrp = tMrp + element.price!;
      tAvailableQuantity = tAvailableQuantity + element.availableQuantity!;
      tAskQuantity = tAskQuantity + element.askQuantity!;
    }

    totalAmount = total;
    totalSellingPrice = tSellingPrice;
    totalMrp = tMrp;
    totalAvailableQuantity = tAvailableQuantity;
    totalAskQuantity = tAskQuantity;
    update();
  }

  searchProductOrderReport(List<ProductOrderReport>? data) {
    productOrderReport = data!;
    update();
  }

  changeOrderStatus(OrderStatus data) async {
    var res = await _sfaProductListRepository.changeOrderStatus(data);
    return res;
  }

  getSubOrdinates() async {
    var res = await _sfaProductListRepository.getSubOrdinates();
    subOrdinates = res.data;
  }

  //Methods for editing product order report--Start

  //1
  deleteOrderReport(int index) {
    reportDetails!.items!.removeAt(index);
    update();
  }

  //2
  changeProductNameInProductOrderReport(
      int index, int productId, String productName, String productCode) {
    reportDetails!.items![index].productId = productId;
    reportDetails!.items![index].productName = productName;
    reportDetails!.items![index].productCode = productCode;
    update();
  }

  //3
  changeSellingPriceInProductOrderReport(int index, double price) {
    reportDetails!.items![index].price = price;
    //update();
  }

  //4
  changeAvailableQtyInProductOrderReport(int index, int qty) {
    reportDetails!.items![index].availableQty = qty;
  }

  //5
  changeAskQtyInProductOrderReport(int index, int qty) {
    reportDetails!.items![index].askQty = qty;
  }

  //6 save button function
  editProductOrderReport() async {
    var message =
        await _sfaProductListRepository.editProductOrderReport(reportDetails!);
    return message;
  }

  //7 Add order items
  addOrderItem(ProductOrderReportItem value) {
    reportDetails!.items!.add(value);
    update();
  }

  //Methods for editing product order report--End

  changeDispatchQtyInProductOrderReport(int index, double qty) {
    reportDetails!.items![index].dispatchQty = qty;
  }
  
  updateDate(NepaliDateTime? start, NepaliDateTime? end) {
    startDate = start;
    endDate = end;
    update();
  }

  Future<File> printOrderSlip(String orderId) async {
    isLoading = true;
    update();
    File file = await _sfaProductListRepository.printOrderSlip(orderId);
    isLoading = false;
    update();
    return file;
  }

  dispatch(List<OrderDispatch> data) async {
   var message =  await _sfaProductListRepository.dispatchOrder(data);
   return message;
  }
}
