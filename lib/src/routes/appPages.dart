import 'package:get/get.dart';
import 'package:my_peopler/src/binding/customerBinding.dart';
import 'package:my_peopler/src/binding/customerReportBinding.dart';
import 'package:my_peopler/src/binding/homeBinding.dart';
import 'package:my_peopler/src/middleware/authMiddleWare.dart';
import 'package:my_peopler/src/views/auth/forgotPasswordView.dart';
import 'package:my_peopler/src/views/customer_views/customerNavView.dart';
import 'package:my_peopler/src/views/expenses/add_expenses.dart';
import 'package:my_peopler/src/views/expenses/approve_expenses.dart';
import 'package:my_peopler/src/views/expenses/edit_expenses.dart';
import 'package:my_peopler/src/views/expenses/expenses_dateview.dart';
import 'package:my_peopler/src/views/expenses/expenses_view.dart';
import 'package:my_peopler/src/views/in_app_disclourse.dart';
import 'package:my_peopler/src/views/ios_in_app_disclourse.dart';
import 'package:my_peopler/src/views/leaveRequest/remaining_leave_view.dart';
import 'package:my_peopler/src/views/navView.dart';
import 'package:my_peopler/src/views/others/pdfScreen.dart';
import 'package:my_peopler/src/views/others/syncLocationLogsView.dart';
import 'package:my_peopler/src/views/second_in_app_disclourse.dart';
import 'package:my_peopler/src/views/srf/askOrderView/askOrderView.dart';
import 'package:my_peopler/src/views/srf/askOrderView/editAskOrderView.dart';
import 'package:my_peopler/src/views/srf/createCustomerView.dart';
import 'package:my_peopler/src/views/srf/office_view/officeView.dart';
import 'package:my_peopler/src/views/srf/office_view/paymentCollectionView.dart';
import 'package:my_peopler/src/views/srf/sfaGoogleMapView.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/marketing_scheme/presentation/client_name.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/marketing_scheme/presentation/client_type.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/location_tracking/location_tracking.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/marketing_scheme/presentation/create_product_price.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/marketing_scheme/presentation/price_detail.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/payment_schedule/payment_schedule_list.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/payment_schedule/payment_schedule_main.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/payment_schedule/payment_schedule_plans.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/estimated_customer_report_view.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/expenditure_view.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/payment_collection_report.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/product_order_report/product_order_report_add_item_view.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/product_order_report/product_order_report_dispatch_view.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/product_order_report/product_order_report_edit_view.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/product_order_report/product_order_report.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/sales_report_view.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/sales_summary/sales_report_summary_view.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/sales_summary/sales_summary_view.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/tour_plan_report.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/sfaMenu.dart';
import 'package:my_peopler/src/views/srf/sfaOrderView/itemView.dart';
import 'package:my_peopler/src/views/srf/srfView.dart';
import 'package:my_peopler/src/views/srf/taskView.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/tourPlan/create_tour_plan.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/tourPlan/tour_plan.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/tourPlan/tour_plan_detail_view.dart';

import '../views/srf/sfaOrderView/orderView.dart';

part 'appRoutes.dart';

class AppPages {
  static const INITIAL = "/";

  static final routes = [
    GetPage(
        name: Routes.INITIAL,
        middlewares: [AuthMiddleware()],
        page: () => NavView(),
        transition: Transition.cupertino,
        bindings: [HomeBinding()]),

    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SRF_PAGE,
      page: () => SrfView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SFA_MENU,
      page: () => SfaMenu(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.OFFICE_VIEW,
      page: () => OfficeView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.REMAINING_LEAVE,
      page: () => RemaingLeaveView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.ASK_ORDER,
      page: () => AskOrderView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.ORDER_VIEW,
      page: () => OrderView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.ITEM_VIEW,
      page: () => ItemView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.TASKS,
      page: () => TaskView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.TOUR_PLAN,
      page: () => TourPlan(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.PAYMENT_SCHEDULE,
      page: () => PaymentSchedule(),
      transition: Transition.cupertino,
    ),

     GetPage(
      name: Routes.PAYMENT_SCHEDULE_LIST,
      page: () => PaymentScheduleList(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.PAYMENT_SCHEDULE_PLANS,
      page: () => PaymentPlans(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.TOUR_PLAN_DETAIL_VIEW,
      page: () => TourPlanDetailView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.TOUR_PLAN_REPORT_VIEW,
      page: () => TourPlanReport(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SALES_REPORT_VIEW,
      page: () => SalesReportView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SALES_SUMMARY_VIEW,
      page: () => SalesSummaryView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SALES_REPORT_SUMMARY_VIEW,
      page: () => SalesReportSummaryView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.EXPENDITURE_VIEW,
      page: () => ExpenditureView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.PRODUCT_ORDER_REPORT_EDIT_VIEW,
      page: () => ProductOrderEditView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.PRODUCT_ORDER_REPORT_DISPATCH_VIEW,
      page: () => ProductOrderReportDispatchView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.PDF_SCREEN,
      page: () => PdfScreen(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.CREATE_TOUR_PLAN,
      page: () => CreateTourPlan(),
      transition: Transition.cupertino,
    ),

     GetPage(
      name: Routes.CREATE_PRODUCT_PRICE,
      page: () => CreateProductPrice(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.CREATE_CUSTOMER,
      page: () => CreateCustomerView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.CREATE_CUSTOMER,
      page: () => CreateCustomerView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.PAYMENT_COLLECTION_VIEW,
      page: () => PaymentCollectionView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PAYMENT_COLLECTION_REPORT_VIEW,
      page: () => PaymentCollectionReportView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.ESTIMATED_CUSTOMER_REPORT,
      page: () => EstimatedCustomerReportView(),
      transition: Transition.cupertino,
      binding: CustomerReportBinding()
    ),
    GetPage(
      name: Routes.PRODUCT_ORDER_REPORT_VIEW,
      page: () => ProductOrderReportView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PRODUCT_ORDER_REPORT_ADD_ITEM_VIEW,
      page: () => ProductOrderReportAddItemView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.EXPENSES_VIEW,
      page: () => ExpensesView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.ADD_EXPENSES_VIEW,
      page: () => AddExpenses(),
      transition: Transition.cupertino,
    ),

     GetPage(
      name: Routes.EDIT_EXPENSES_VIEW,
      page: () => EditExpenses(),
      transition: Transition.cupertino,
    ),

     GetPage(
      name: Routes.EXPENSES_DATE_VIEW,
      page: () => ExpensesDate(),
      transition: Transition.cupertino,
    ),

     GetPage(
      name: Routes.APPROVE_EXPENSES_VIEW,
      page: () => ApproveExpenses(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SFA_GOOGLE_MAP_VIEW,
      page: () => SfaGoogleMapView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.EDIT_ASK_ORDER_VIEW,
      page: () => EditAskOrderView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.IN_APP_DISCLOSURES,
      page: () => InAppDisClosure(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SECOND_IN_APP_DISCLOSURES,
      page: () => SecondInAppDisclourse(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.IOS_IN_APP_DISCLOSURES,
      page: () => IosInAppDisclourse(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SYNC_LOCATION_LOGS_VIEW,
      page: () => SyncLocationLogsView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.LOCATION_LOG,
      page: () => LocationTrack(),
      transition: Transition.cupertino,
    ),

     GetPage(
      name: Routes.Client_Detail,
      page: () => ClientType(),
      transition: Transition.cupertino,
    ),

     GetPage(
      name: Routes.Client_Name,
      page: () => ClientName(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.New_Product_Price,
      page: () => NewPriceDetail(),
      transition: Transition.cupertino,
    ),
    //customers
    GetPage(
        name: Routes.CUSTOMER_NAV_VIEW,
        middlewares: [AuthMiddleware()],
        page: () => CustomerNavView(),
        transition: Transition.cupertino,
        bindings: [CustomerBinding()]),

    // GetPage(
    //   name: Routes.CUSTOMER_HOME_SCREEN,
    //   page: () => CustomerHomeScreen(),
    //   transition: Transition.cupertino,
    // ),
  ];
}
