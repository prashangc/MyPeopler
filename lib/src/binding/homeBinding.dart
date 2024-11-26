import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/controllers/estimatedCustomerReportController.dart';
import 'package:my_peopler/src/controllers/expenseController.dart';
import 'package:my_peopler/src/controllers/location_tracking_controller.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/controllers/sfaPaymentCollectionController.dart';
import 'package:my_peopler/src/controllers/sfaPaymentScheduleController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/controllers/sfalocationLogsController.dart';
import 'package:my_peopler/src/controllers/survey_poll_controller.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/repository/repository.dart';
import 'package:my_peopler/src/repository/surveyPollRepository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NoticeController>(NoticeController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
    Get.put<LeaveController>(LeaveController(), permanent: true);
    Get.put<AwardController>(AwardController(), permanent: true);
    Get.put<HolidayController>(HolidayController(), permanent: true);
    Get.put<PayrollController>(PayrollController(getIt<PayrollRepository>()),
        permanent: true);
    Get.put<AttendanceController>(
        AttendanceController(getIt<AttendanceRepository>()),
        permanent: true);
    Get.put<DocumentController>(DocumentController(getIt<DocumentRepository>()),
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
    Get.put(SfaPaymentScheduleController(), permanent: true);
    Get.put(LocationTrackController(), permanent: true);
  }
}
