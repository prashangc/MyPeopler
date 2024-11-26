import 'dart:developer';
import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:my_peopler/src/models/sfa/sfa_payment_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_payment_methods_model.dart';
import 'package:my_peopler/src/repository/sfa/sfaPaymentListRepository.dart';

import '../core/di/injection.dart';

class PaymentData {
  String? amount;
  String? method;
  String? refNo;
  String? customerId;
  String? notes;

  PaymentData({
    this.amount,
    this.method,
    this.refNo,
    this.customerId,
    this.notes,
  });
}

class PaymentDataStatus {
  String? status;
  int? paymentId;
  String? note;
  PaymentDataStatus({this.status, this.paymentId, this.note});
}

class SfaPaymentCollectionController extends GetxController {
  final SfaPaymentListRepository _sfaPaymentListRepository =
      getIt<SfaPaymentListRepository>();

  bool isLoading = false;
  int? customerId;
  int? get getcustomerId => customerId;

  List<SfaPaymentList> sfaPaymentList = [];
  List<SfaPaymentMethods> sfaPaymentMethods = [];

  @override
  void onInit() async {
    if (getcustomerId != null) {
      await getSfaPaymentList();
      await getSfaPaymentMethod();
    }
    super.onInit();
  }

  getSfaPaymentList({String? start, String? end}) async {
    isLoading = true;
    var res = await _sfaPaymentListRepository.getSfaPaymentList(
      customerId: getcustomerId,
      start: start,
      end: end,
    );
    if (res.isNotEmpty) {
      sfaPaymentList = res;
      log(sfaPaymentList.toString(), name: "sfaProductByGroupFilterModel");
      isLoading = false;
      update();
    } else if (res.isEmpty) {
      sfaPaymentList = [];
      isLoading = false;
      update();
    }
  }

  getSfaPaymentListAll(
    String type, {
    String? start,
    String? end,
    int? employeeId,
  }) async {
    isLoading = true;
    update();
    var res = await _sfaPaymentListRepository.getSfaPaymentList(
      type: type,
      start: start,
      end: end,
      employeeId: employeeId,
      customerId: customerId,
    );
    if (res.isNotEmpty) {
      sfaPaymentList = res;
      log(sfaPaymentList.toString(), name: "sfaProductByGroupFilterModel");
      isLoading = false;
      update();
    } else if (res.isEmpty) {
      sfaPaymentList = [];
      isLoading = false;
      update();
    }
    return res;
  }

  getSfaPaymentMethod() async {
    isLoading = true;
    var res = await _sfaPaymentListRepository.getSfaPaymentMethods();
    if (res.isNotEmpty) {
      sfaPaymentMethods = res;
      log(sfaPaymentMethods.toString(), name: "sfaPaymentMethods");
      isLoading = false;
      update();
    } else if (res.isEmpty) {
      sfaPaymentMethods = [];
      isLoading = false;
      update();
    }
  }

  approvePayment(PaymentDataStatus data) async {
    var res = await _sfaPaymentListRepository.approvePayment(data);
    return res;
  }

  postSfaPaymentList(PaymentData paymentData) async {
    isLoading = true;
    update();
    var res = await _sfaPaymentListRepository.postSfaPayment(paymentData);
    getSfaPaymentList();
    isLoading = false;
    update();
  }

  searchPaymentReports(List<SfaPaymentList> data) {
    sfaPaymentList = data;
    update();
  }

  Future<File> printPaymentSlip(String paymentId) async {
    isLoading = true;
    update();
    File file = await _sfaPaymentListRepository.printPaymentSlip(paymentId);
    isLoading = false;
    update();
    return file;
  }
}
