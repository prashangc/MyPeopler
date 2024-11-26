import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/core/constants/navigatorId.dart';
import 'package:my_peopler/src/models/document/documentModel.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/attendenceReport/attendenceReportView.dart';
import 'package:my_peopler/src/views/customer_views/customerCartView.dart';
import 'package:my_peopler/src/views/customer_views/customerHomeScreen.dart';
import 'package:my_peopler/src/views/customer_views/customerInvoices.dart';
import 'package:my_peopler/src/views/customer_views/customerOrderHistory.dart';
import 'package:my_peopler/src/views/customer_views/customerProductListView.dart';
import 'package:my_peopler/src/views/customer_views/customerProfile.dart';
import 'package:my_peopler/src/views/documents/documentFoldersView.dart';
import 'package:my_peopler/src/views/home/homeView.dart';
import 'package:my_peopler/src/views/leaveRequest/leaveRequestView.dart';
import 'package:my_peopler/src/views/leaveRequest/newLeaveRequestView.dart';
import 'package:my_peopler/src/views/notice/noticeDetailView.dart';
import 'package:my_peopler/src/views/notice/noticeView.dart';
import 'package:my_peopler/src/views/others/awardsView.dart';
import 'package:my_peopler/src/views/others/bonusView.dart';
import 'package:my_peopler/src/views/others/companyProfileView.dart';
import 'package:my_peopler/src/views/documents/documentView.dart';
import 'package:my_peopler/src/views/others/holidayDetailView.dart';
import 'package:my_peopler/src/views/others/holidayView.dart';
import 'package:my_peopler/src/views/others/locationCoOrdinatesView.dart';
import 'package:my_peopler/src/views/payroll/payRollView.dart';
import 'package:my_peopler/src/views/profile/changePasswordView.dart';
import 'package:my_peopler/src/views/profile/editProfileView.dart';
import 'package:my_peopler/src/views/profile/profileView.dart';
import 'package:my_peopler/src/views/project/projectView.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/sfaMenu.dart';
import 'package:my_peopler/src/views/srf/srfView.dart';
import 'package:my_peopler/src/views/surveyPoll/survey_poll_view.dart';
import 'package:my_peopler/src/views/surveyPoll/survey_questions_options_page.dart';

class NavController extends GetxController {
  var selected = 2.obs;

  var customerSelected = 2.obs;

  String currentRouteName = "";

  /// used to change the selected bottom tab
  bool changeView(int index, {required bool isCustomerView}) {
    if (isCustomerView) {
      if (index == customerSelected.value) {
        return false;
      }
      customerSelected(index); // selected.value = index;
      return true;
    } else {
      if (index == selected.value) {
        return false;
      }
      selected(index); // selected.value = index;
      return true;
    }
  }

  List<Map<String, dynamic>> bottomNavs = [
    {
      'index': 0,
      'label': "Attendence",
      'icon': Icons.list_alt_sharp,
    },
    {
      'index': 1,
      'label': "Leave",
      'icon': Icons.content_paste_go_sharp,
    },
    {
      'index': 2,
      'label': "Home",
      'icon': Icons.home,
    },
    {
      'index': 3,
      'label': "Payroll",
      'icon': Icons.message,
    },
    {
      'index': 3,
      'label': "Profile",
      'icon': Icons.person,
    },
  ];

  List<Map<String, dynamic>> bottomNavsCustomer = [
    {
      'index': 0,
      'label': "Invoices",
      'icon': Icons.receipt_long_rounded,
    },
    {
      'index': 1,
      'label': "O. History",
      'icon': Icons.history_outlined,
    },
    {
      'index': 2,
      'label': "",
      'icon': Icons.home,
    },
    {
      'index': 3,
      'label': "Products",
      'icon': Icons.shopping_cart_outlined,
    },
    {
      'index': 4,
      'label': "Profile",
      'icon': Icons.person_2_outlined,
    },
  ];

  back() {
    // currentRouteName = "";
    Get.back(id: NavigatorId.nestedNavigationNavigatorId);
  }

  toNamed(
    String routeName, {
    dynamic arguments,
  }) {
    // if (currentRouteName == routeName) {
    //   return null;
    // }
    Get.toNamed(routeName,
        id: NavigatorId.nestedNavigationNavigatorId, arguments: arguments);
  }

  offNamed(
    String routeName, {
    dynamic arguments,
  }) {
    if (currentRouteName == routeName) {
      return null;
    }
    Get.offAllNamed(routeName,
        id: NavigatorId.nestedNavigationNavigatorId, arguments: arguments);
  }

  onNestedGenerateRoute(RouteSettings routeSettings, BuildContext context) {
    if (routeSettings.name != null) {
      currentRouteName = routeSettings.name!;
    }
    switch (routeSettings.name) {
      case Routes.ATTENDANCE:
        return GetPageRoute(
          routeName: Routes.ATTENDANCE,
          page: () => AttendenceReportView(),
          transition: Transition.cupertino,
        );
      case Routes.LEAVE:
        return GetPageRoute(
          routeName: Routes.LEAVE,
          page: () => LeaveRequetView(),
          transition: Transition.cupertino,
        );
      case Routes.PAYROLL:
        return GetPageRoute(
          routeName: Routes.PAYROLL,
          page: () => PayrollView(),
          transition: Transition.cupertino,
        );
      case Routes.PROFILE:
        return GetPageRoute(
          routeName: Routes.PROFILE,
          page: () => ProfileView(),
          transition: Transition.cupertino,
        );
      case Routes.CHANGE_PASSWORD:
        return GetPageRoute(
            routeName: Routes.CHANGE_PASSWORD,
            page: () => ChangePasswordView(),
            transition: Transition.cupertino,
            popGesture: true);
      case Routes.EDIT_PROFILE:
        return GetPageRoute(
            routeName: Routes.EDIT_PROFILE,
            page: () => EditProfileView(),
            transition: Transition.cupertino,
            popGesture: true);
      case Routes.LEAVE_REQUEST:
        return GetPageRoute(
            routeName: Routes.LEAVE_REQUEST,
            page: () => NewLeaveRequestView(),
            transition: Transition.cupertino,
            popGesture: true);
      case Routes.NOTICE:
        return GetPageRoute(
          routeName: Routes.NOTICE,
          page: () => NoticeView(),
          transition: Transition.cupertino,
          popGesture: true,
        );

      //s
      case Routes.SINGLE_NOTICE:
        return GetPageRoute(
          routeName: Routes.SINGLE_NOTICE,
          page: () => NoticeDetailView(
            notice: routeSettings.arguments as Notice,
          ),
          transition: Transition.cupertino,
          popGesture: true,
        );

      case Routes.SURVEY_POLL:
        return GetPageRoute(
          routeName: Routes.SURVEY_POLL,
          page: () => SurveyPollView(),
          transition: Transition.cupertino,
          popGesture: true,
        );

      case Routes.SURVEY_QUESTIONS_OPTIONS_PAGE:
        return GetPageRoute(
            routeName: Routes.SURVEY_QUESTIONS_OPTIONS_PAGE,
            page: () {
              List args = routeSettings.arguments as List;
              return SurveyQuestionsOptionsPage(
                  questions: args[0], appTitle: args[1], surveyId: args[2]);
            },
            transition: Transition.cupertino,
            popGesture: true);

      case Routes.BONUS:
        return GetPageRoute(
          routeName: Routes.BONUS,
          page: () => BonusView(),
          transition: Transition.cupertino,
        );
      case Routes.AWARD:
        return GetPageRoute(
          routeName: Routes.AWARD,
          page: () => AwardsView(),
          transition: Transition.cupertino,
        );
      case Routes.DOCUMENT_FOLDERS:
        return GetPageRoute(
          routeName: Routes.DOCUMENT_FOLDERS,
          page: () => DocumentFolderView(),
          transition: Transition.cupertino,
        );
      case Routes.DOCUMENT:
        return GetPageRoute(
          routeName: Routes.DOCUMENT,
          page: () => DocumentView(
            files: routeSettings.arguments as List<FileElement>,
          ),
          transition: Transition.cupertino,
          popGesture: true,
        );
      case Routes.SINGLE_HOLIDAY:
        return GetPageRoute(
            routeName: Routes.SINGLE_HOLIDAY,
            page: () => HolidayDetailView(
                  holiday: routeSettings.arguments as Holiday,
                ),
            transition: Transition.cupertino,
            popGesture: true);
      case Routes.COMPANY_PROFILE:
        return GetPageRoute(
          routeName: Routes.COMPANY_PROFILE,
          page: () => CompanyProfileView(),
          transition: Transition.cupertino,
          popGesture: true,
        );
      case Routes.LOCATION_COORDINATES_VIEW:
        return GetPageRoute(
          routeName: Routes.LOCATION_COORDINATES_VIEW,
          page: () => LocationCoOrdinatesView(),
          transition: Transition.cupertino,
          popGesture: true,
        );
      case Routes.HOLIDAY:
        return GetPageRoute(
          routeName: Routes.HOLIDAY,
          page: () => HolidayView(),
          transition: Transition.cupertino,
        );
      case Routes.TODO:
        return GetPageRoute(
          routeName: Routes.TODO,
          page: () => ProjectView(),
          transition: Transition.cupertino,
        );
      case Routes.SRF_PAGE:
        return GetPageRoute(
          routeName: Routes.SRF_PAGE,
          page: () => SrfView(),
          transition: Transition.cupertino,
        );
      case Routes.SFA_MENU:
        return GetPageRoute(
          routeName: Routes.SFA_MENU,
          page: () => SfaMenu(),
          transition: Transition.cupertino,
        );

      //for customer login
      //all customer ui
      // case Routes.CUSTOMER_HOME_SCREEN:
      // return GetPageRoute(
      //   routeName: Routes.CUSTOMER_HOME_SCREEN,
      //   page: () => CustomerHomeScreen(),
      //   transition: Transition.cupertino,
      // );
      case Routes.HOME:
        return GetPageRoute(
          routeName: Routes.HOME,
          page: () => HomeView(),
          transition: Transition.cupertino,
        );
      default:
        return null;
    }
  }

  onNestedGenerateRouteCustomer(
      RouteSettings routeSettings, BuildContext context) {
    if (routeSettings.name != null) {
      currentRouteName = routeSettings.name!;
    }
    switch (routeSettings.name) {
      case Routes.CUSTOMER_PRODUCT_LIST_VIEW:
        return GetPageRoute(
          routeName: Routes.CUSTOMER_PRODUCT_LIST_VIEW,
          page: () => CustomerProductListView(),
          transition: Transition.cupertino,
        );
      case Routes.CUSTOMER_INVOICE:
        return GetPageRoute(
          routeName: Routes.CUSTOMER_INVOICE,
          page: () => CustomerInvoices(),
          transition: Transition.cupertino,
        );
      case Routes.CUSTOMER_ORDER_HISTORY:
        return GetPageRoute(
          routeName: Routes.CUSTOMER_ORDER_HISTORY,
          page: () => CustomerOrderHistory(),
          transition: Transition.cupertino,
        );
      case Routes.CUSTOMER_CART_VIEW:
        return GetPageRoute(
            routeName: Routes.CUSTOMER_CART_VIEW,
            page: () => CustomerCartView(),
            transition: Transition.cupertino,
            popGesture: true,
            maintainState: false,
            showCupertinoParallax: false,
            fullscreenDialog: false);
      case Routes.CUSTOMER_PROFILE:
        return GetPageRoute(
          routeName: Routes.CUSTOMER_PROFILE,
          page: () => CustomerProfile(),
          transition: Transition.cupertino,
        );
      default:
        return GetPageRoute(
          routeName: Routes.CUSTOMER_HOME_SCREEN,
          page: () => CustomerHomeScreen(),
          transition: Transition.cupertino,
        );
    }
  }
}
