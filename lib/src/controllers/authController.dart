import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_peopler/main.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/controllers/customer/customerProductListController.dart';
import 'package:my_peopler/src/controllers/expenseController.dart';
import 'package:my_peopler/src/controllers/location_tracking_controller.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/controllers/sfaPaymentCollectionController.dart';
import 'package:my_peopler/src/controllers/sfaPaymentScheduleController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/controllers/sfalocationLogsController.dart';
import 'package:my_peopler/src/controllers/survey_poll_controller.dart';
import 'package:my_peopler/src/core/constants/secureStorageConstants.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/login/customer_login/customerLogin.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/repository/repository.dart';
import 'package:my_peopler/src/repository/surveyPollRepository.dart';
import 'package:my_peopler/src/routes/routes.dart';

import '../core/constants/userState.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = getIt<AuthRepository>();
  final Rx<UserState> _status = Rx<UserState>(UserState.UNINITIALIZED);

  final Rx<bool> _isCheckedIn = Rx<bool>(false);

  final isLoading = false.obs;
  final isRessettingPassword = false.obs;

  UserState get status => _status.value;
  bool get isCheckedIn => _isCheckedIn.value;

  checkUserStatus() {
    var isLoggedIn = StorageHelper.isLoggedIn;

    if (isLoggedIn) {
      _status(UserState.AUTHENTICATED);
      log("Logged In");
      update();
    } else {
      _status(UserState.UNAUTHENTICATED);
      log("Not LoggedIn");
      update();
    }
  }

  _checkCheckedInStatus() {
    var checkedIn = StorageHelper.isCheckedIn;
    _isCheckedIn(checkedIn);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    checkUserStatus();
    _checkCheckedInStatus();
  }

  Future<String> login(String email, String password, String userCode,
      String macAddress, bool rememberMe) async {
    String returnValue = '';
    try {
      isLoading(true);
      update();
      // method to login
      var response = await _authRepo.login(
        {
          'email': email,
          'password': password,
          'code': userCode,
          'mac_address': macAddress
        },
      );

      if (response.hasError) {
        throw CustomException(response.error!);
      }

      var loginResponse = response.data as Login;
      var shifts = loginResponse.user?.shifts ?? [];
      if (loginResponse.token == null) {
        throw CustomException("Could not authenticate");
      }
      StorageHelper.setUserCode(userCode);
      StorageHelper.setPassword(password);
      StorageHelper.setToken(loginResponse.token);
      await StorageHelper.saveEmployeeProfile(loginResponse.user);
      if (shifts.isNotEmpty) {
        Shift currentShift = shifts.last;
        writeValue(graceTime, currentShift.graceStart.toString());
        writeValue(graceEnd, currentShift.graceEnd.toString());
        writeValue(lunchOutTime, currentShift.lunchOut.toString());
        writeValue(lunchInTime, currentShift.lunchIn.toString());

        bool isCheckedIn = shifts.length.isOdd;
        StorageHelper.setCheckedIn(isCheckedIn: isCheckedIn);
      }
      StorageHelper.setRememberMe(rememberMe);
      _status(UserState.AUTHENTICATED);
      isLoading(false);
      update();
      Get.put<NoticeController>(NoticeController(), permanent: true);
      Get.put<ProfileController>(ProfileController(), permanent: true);
      Get.put<LeaveController>(LeaveController(), permanent: true);
      Get.put<AwardController>(AwardController(), permanent: true);
      Get.put<HolidayController>(HolidayController(), permanent: true);
      Get.put<PayrollController>(PayrollController(getIt<PayrollRepository>()),
          permanent: true);
      Get.put<SfaPaymentScheduleController>(SfaPaymentScheduleController(),
          permanent: true);
      Get.put<LocationTrackController>(LocationTrackController(),
          permanent: true);
      Get.put<AttendanceController>(
          AttendanceController(getIt<AttendanceRepository>()),
          permanent: true);
      Get.put<DocumentController>(
          DocumentController(getIt<DocumentRepository>()),
          permanent: true);
      Get.put<ProjectController>(ProjectController(getIt<ProjectRepository>()),
          permanent: true);
      Get.put<SurveyPollController>(
          SurveyPollController(getIt<SurveyPollRespository>()),
          permanent: true);
      Get.put<SfaCustomerListController>(SfaCustomerListController(),
          permanent: true);
      Get.put<SfaProductListController>(SfaProductListController(),
          permanent: true);
      Get.put<SfaTourPlanController>(SfaTourPlanController(), permanent: true);
      Get.put<SfaPaymentCollectionController>(SfaPaymentCollectionController(),
          permanent: true);
      Get.put<ExpenseController>(ExpenseController(), permanent: true);
      Get.put<SfaLocationLogsController>(SfaLocationLogsController(),
          permanent: true);
      MessageHelper.success("Logged In");
      Get.offAllNamed(
        Routes.INITIAL,
      );
    } on CustomException catch (e) {
      MessageHelper.error(e.message);
      returnValue = e.message;
    } catch (e) {
      MessageHelper.error("Something went wrong!!!");
    } finally {
      _status(UserState.UNAUTHENTICATED);
      isLoading(false);
      update();
    }
    return returnValue;
  }

  Future<String> customerLogin(String email, String password, String userCode,
      String macAddress, bool rememberMe) async {
    String returnValue = '';
    try {
      isLoading(true);
      update();
      // method to login
      var response = await _authRepo.customerLogin(
        {
          'email': email,
          'password': password,
          'code': userCode,
          'mac_address': macAddress
        },
      );
      if (response.hasError) {
        throw CustomException(response.error!);
      }
      var loginResponse = response.data as CustomerLoginModel;

      if (loginResponse.token == null) {
        throw CustomException("Could not authenticate");
      }
      StorageHelper.setUserCode(userCode);
      StorageHelper.setPassword(password);
      StorageHelper.setToken(loginResponse.token);
      StorageHelper.saveProfileCustomer(loginResponse.customer);
      StorageHelper.setRememberMe(rememberMe);
      _status(UserState.AUTHENTICATED);
      isLoading(false);
      update();
      Get.put<CustomerProductListController>(CustomerProductListController(),
          permanent: true);
      MessageHelper.success("Logged In");
      Get.offAllNamed(
        Routes.CUSTOMER_NAV_VIEW,
      );
    } on CustomException catch (e) {
      MessageHelper.error(e.message);
      returnValue = e.message;
    } catch (e) {
      MessageHelper.error("Something went wrong!!!");
    } finally {
      _status(UserState.UNAUTHENTICATED);
      isLoading(false);
      update();
    }
    return returnValue;
  }

  Future<void> forgotPassword(String email, String userCode) async {
    try {
      isRessettingPassword(true);
      update();
      var response = await _authRepo.forgotPassword(
        {
          'email': email,
          'code': userCode,
        },
      );
      if (!response.hasError) {
        var resMessage = response.data as String;
        log(resMessage.toString(), name: "Forgot Password");
        MessageHelper.success(resMessage);
        Get.offAllNamed(
          Routes.INITIAL,
        );
      } else {
        MessageHelper.error(response.error ?? "Something went wrong");
      }
      return;
    } catch (e) {
      log(e.toString(), name: "Login");
    } finally {
      isRessettingPassword(false);
      update();
    }
  }

  Future<void> logout() async {
    isLoading(true);
    update();
    await StorageHelper.logout();
    Get.find<NavController>().changeView(2, isCustomerView: false);
    Get.find<SfaCustomerListController>().backgroundTracking = false;
    forceDeleteDependencies();
    _status(UserState.UNAUTHENTICATED);
    isLoading(false);
    update();
    Get.offAllNamed(
      Routes.INITIAL,
    );
  }

  Future<void> customerLogout() async {
    isLoading(true);
    update();
    await StorageHelper.logout();
    Get.find<NavController>().changeView(1, isCustomerView: true);
    forceDeleteDependencies();
    _status(UserState.UNAUTHENTICATED);
    isLoading(false);
    update();
    Get.offAllNamed(
      Routes.INITIAL,
    );
  }

  Future saveFcmToken(Map<String, dynamic> data) async {
    try {
      update();
      var response = await _authRepo.saveFcmToken(data);
      if (!response.hasError) {
        var resMessage = response.data as String;
        log(resMessage.toString(), name: "saveFcmToken");
      } else {
        MessageHelper.error(response.error ?? "Something went wrong");
      }
      return;
    } catch (e) {
      log(e.toString(), name: "saveFcmToken");
    } finally {
      update();
    }
  }

  forceDeleteDependencies() {
    Get.delete<NoticeController>(force: true);
    Get.delete<AttendanceController>(force: true);
    Get.delete<LeaveController>(force: true);
    Get.delete<PayrollController>(force: true);
    Get.delete<ProjectController>(force: true);
    Get.delete<ProfileController>(force: true);
    Get.delete<AwardController>(force: true);
    Get.delete<DocumentController>(force: true);
    Get.delete<HolidayController>(force: true);
  }
}
