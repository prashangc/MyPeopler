import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_beat_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_class_type_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_client_type_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_dashboard_model.dart';
import 'package:my_peopler/src/models/sfa_task/sfa_task.dart';
import 'package:my_peopler/src/repository/sfa/sfaCustomerListRepository.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/sfaMenu.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
class CustomerData{
  //organization detail
  String? name;
  String? contactNumber;
  String? address;
  int? clientId;
  int? classId;
  int? parentId;
  int? beatId;
  String? email;
  String? establishedYear;
  String? panNumber;
  String? latitude;
  String? longitude;
  
  //contact person detail
  String? contactPersonName;
  String? contactPersonGender;
  String? contactPersonEmail;
  String? contactPersonNumber;
  String? contactPersonPosition;
  CustomerData({
    //organization detail
    this.name,
    this.contactNumber,
    this.address,
    this.classId,
    this.clientId,
    this.parentId,
    this.beatId,
    this.email,
    this.establishedYear,
    this.panNumber,
    this.latitude,
    this.longitude,

    //contact person detail
    this.contactPersonName,
    this.contactPersonGender,
    this.contactPersonEmail,
    this.contactPersonNumber,
    this.contactPersonPosition
    });
}
class SfaCustomerListController extends GetxController {
  final SfaCustomerListRepository _sfaCustomerListRepository = getIt<SfaCustomerListRepository>();

   SfaCustomerList _sfaCustomerList = SfaCustomerList(clientLists: {});
   SfaCustomerList get sfaCustomerList => _sfaCustomerList;


   SfaCustomerList _sfaCustomerListAll = SfaCustomerList(clientLists: {});
   SfaCustomerList get sfaCustomerListAll => _sfaCustomerListAll;

    SfaCustomerList _parentCustomerList = SfaCustomerList(clientLists: {});
   SfaCustomerList get parentCustomerList => _parentCustomerList;

  List<SfaTaskResponse?> _sfaTask = [];
  List<SfaTaskResponse?> get sfaTask => _sfaTask;
  
  bool isLoading = false;

  List<ClientTypeOptions> _clientTypeOptions = [];
  List<ClientTypeOptions> get clientTypeOptions => _clientTypeOptions;

    List<ClassTypeOptions> _classTypeOptions = [];
  List<ClassTypeOptions> get classTypeOptions => _classTypeOptions;

  List<BeatOptionsModel> _beatOptions = [];
  List<BeatOptionsModel> get beatOptions => _beatOptions;


  SfaDashBoardModel? sfaDashBoardModel;
  SfaDashBoardModel? salesSummary;

  CustomerData? customerData;
  String? assignedfor = 'daily';
  bool backgroundTracking = StorageHelper.enableBackgroundlocation ?? false;
  List<Options> dashBoardData = [
    Options(
      name: 'Total Dispatch Quantity',
      color: ColorManager.strawBerryColor,
      count: '0',
    ),
    Options(
      name: 'Total Ask Quantity',
      color: ColorManager.lightGreen,
      count: '0',
    ),
    Options(
      name: 'Total Dispatch Amount',
      color: ColorManager.orangeColor,
     count: '0',
    ),
    Options(
      name: 'Total Ask Amount',
      color: Colors.green,
     count: '0',
    ),
    Options(
      name: 'Number Of Assigned Party',
      color: ColorManager.creamColor2,
      count: '0',
    ),
    Options(
      name: 'Number Of Beat',
      color: ColorManager.purpleColor,
       count: '0',
    ),
      Options(
      name: 'Tour Plan Today',
      color: ColorManager.lightPurple2,
      count: '0',
    )
  ];

  List<Options> salesSummaryList = [
    Options(
      name: 'Total Dispatch Quantity',
      color: ColorManager.strawBerryColor,
      count: '0',
    ),
    Options(
      name: 'Total Ask Quantity',
      color: ColorManager.lightGreen,
      count: '0',
    ),
    Options(
      name: 'Total Dispatch Amount',
      color: ColorManager.orangeColor,
     count: '0',
    ),
    Options(
      name: 'Total Ask Amount',
      color: Colors.green,
     count: '0',
    ),
  ];
  @override
  void onInit() {
    getSfaCustomerList(assignedfor);
    super.onInit();
  }


  getSfaDashBoardData() async{
      var res = await _sfaCustomerListRepository.getSfaDashboardData();
      sfaDashBoardModel = res;
      dashBoardData[0].count = sfaDashBoardModel?.orderSummery?.totalDispatchQty.toString();
      dashBoardData[1].count = sfaDashBoardModel?.orderSummery?.totalAskQty.toString();
      dashBoardData[2].count = 'Rs. ${sfaDashBoardModel?.orderSummery?.totalDispatchAmount.toString()}';
      dashBoardData[3].count = 'Rs. ${sfaDashBoardModel?.orderSummery?.totalAskAmount.toString()}';
      dashBoardData[4].count = sfaDashBoardModel?.noOfAssignParty.toString();
      dashBoardData[5].count = sfaDashBoardModel?.noOfBeat.toString();
      dashBoardData[6].count = sfaDashBoardModel?.tourPlanToday.toString();
  }

   getSalesSummary({
    String? type,
    NepaliDateTime? start,
    NepaliDateTime? end,
    int? employeeId,
    int? customerId,
    int? productId,
    int? beatId,
    int? clientId
   }) async{
    // isLoading = true;
    // update();
      var res = await _sfaCustomerListRepository.getSfaDashboardData(
        type: type,
        start: start,
        end: end,
        employeeId: employeeId,
        customerId: customerId,
        productId: productId,
        beatId: beatId,
        clientId: clientId
      );
      salesSummary = res;
      salesSummaryList[0].count = salesSummary?.orderSummery?.totalDispatchQty.toString();
      salesSummaryList[1].count = salesSummary?.orderSummery?.totalAskQty.toString();
      salesSummaryList[2].count = 'Rs. ${salesSummary?.orderSummery?.totalDispatchAmount.toString()}';
      salesSummaryList[3].count = 'Rs. ${salesSummary?.orderSummery?.totalAskAmount.toString()}';
  //  isLoading = false;
     update();
  }

  getSfaCustomerList(String? assignedfor, {int? customer_id, bool marketScheme = false}) async {
    isLoading = true;
    this.assignedfor = assignedfor;
     //update();
    var res = marketScheme? await _sfaCustomerListRepository.getSfaCustomerList(assignedfor,true,customer_id: customer_id,marketScheme: marketScheme): 
    await _sfaCustomerListRepository.getSfaCustomerList(assignedfor,false);
    if (res.clientLists.isNotEmpty) {
      if(assignedfor == 'daily'){
         _sfaCustomerList = res;
      log(_sfaCustomerList.toString(), name: "sfaCustomerList");
      }else{
        _sfaCustomerListAll = res;
      }
      isLoading = false;
      update();
    }else if(res.clientLists.isEmpty){
      if(assignedfor == 'daily'){
        _sfaCustomerList = SfaCustomerList(clientLists: {});
      }else{
        _sfaCustomerListAll = SfaCustomerList(clientLists: {});
        
      }

      
       isLoading = false;
      update();
    }
    return res;
  }

  getClientTypeOptions() async{
    isLoading = true;
     //update();
    var res = await _sfaCustomerListRepository.getClientTypeOptions();
    if (res.isNotEmpty) {
      _clientTypeOptions = res;
      log(_clientTypeOptions.toString(), name: "getClientTypeOptions");
       isLoading = false;
      update();
    }else if(res.isEmpty){
        _clientTypeOptions = [];
       isLoading = false;
      update();
    }
  }

  getClassTypeOptions() async{
     isLoading = true;
     //update();
    var res = await _sfaCustomerListRepository.getCustomerClassOptions();
    if (res.isNotEmpty) {
      _classTypeOptions = res;
      log(_classTypeOptions.toString(), name: "getCustomerClassOptions");
       isLoading = false;
      update();
    }else if(res.isEmpty){
        _classTypeOptions = [];
       isLoading = false;
      update();
    }
  }

  getParentCustomer({bool marketScheme = false}) async{
    isLoading = true;
     update();
    var res = marketScheme? await _sfaCustomerListRepository.getSfaCustomerList('all',false) : 
    await _sfaCustomerListRepository.getSfaCustomerList('all',true);
    if (res.clientLists.isNotEmpty) {
     _parentCustomerList = res;
       isLoading = false;
      update();
    }else if(res.clientLists.isEmpty){
        _parentCustomerList = SfaCustomerList(clientLists: {});
       isLoading = false;
      update();
    }
    return res;
  }

getBeatOptions() async{
  isLoading = true;
  update();
  var res = await _sfaCustomerListRepository.getBeatOptions();
  if (res.isNotEmpty) {
    _beatOptions = res;
    isLoading = false;
    update();
  }else if(res.isEmpty){
    _beatOptions = [];
    isLoading = false;
    update();
  }
  return res;
}

  getTaskList() async{
    isLoading = true;
     //update();
    var res = await _sfaCustomerListRepository.getTaskList();
    if (res.isNotEmpty) {
      _sfaTask = res;
      log(_sfaTask.toString(), name: "getTaskList");
       isLoading = false;
      update();
    }else if(res.isEmpty){
      _sfaTask = [];
       isLoading = false;
      update();
    }
  }

  toggleTaskItems(int taskId, int taskItemId) async{
    isLoading = true;
  //   update();
    var res = await _sfaCustomerListRepository.toggleTaskItems(taskId,taskItemId);
    if (res.isNotEmpty) {
      getTaskList();
    }else if(res.isEmpty){
      //_sfaTask = [];
       isLoading = false;
      update();
    }
  }

  postSfaCustomer(CustomerData? customerData) async{
    isLoading = true;
     update();
    var res = await _sfaCustomerListRepository.postSfaCustomer(customerData);
    isLoading = false;
    update();
    return res;
  }

  setBackgroundTracking(){
    StorageHelper.enableBackgroundLocation(backgroundTracking);
  }

  searchData(SfaCustomerList? data){
   if(assignedfor == 'daily'){
         _sfaCustomerList = data!;
      }else{
        _sfaCustomerListAll = data!;
      }
    update();
  }

  searchParentCustomer(SfaCustomerList? data){
    if(data != null) {
      _parentCustomerList = data;
    }
    update();
  }

  searchBeat(List<BeatOptionsModel>? data){
    _beatOptions = data!;
    update();
  }
}
