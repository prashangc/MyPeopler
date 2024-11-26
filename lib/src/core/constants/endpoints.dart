class Endpoints {
  //A
  static const String ATTENDANCES = "attendances";
  static const String AWARDS = "awards";

  //C
  static const String CHANGE_PASSWORD = "change-password";

  //P
  static const String PROFILE = "profile";
  static const String PROFILE_UPDATE = "profile/update";
  static const String POSTSUREVYANDPOLL = 'survey/participate';
  static const String PUNCH = "$ATTENDANCES/punch";
  static const String PAYROLL = "payroll";
  static const String MY_PAYSLIPS = "my_payslips";
  static const String PROJECTS = "projects";
  static const String NOTICES = "notices";

  //Sfa
  static const String SFA_CUSTOMER_LIST = "/sfa/customers";
  static const String SFA_PRODUCTS = "/sfa/products";

  static const String SFA_ORDERS = "/sfa/orders";
  static const String SFA_MARKETING_SCHEME = 'sfa/marketing-schemes';
  static const String SFA_ORDERS_CHANGE_STATUS = '/sfa/orders/change-status';
  static const String SFA_ORDERS_DISPATCH = '/sfa/orders/dispatch';

  static const String SFA_TASKS = "/sfa/tasks";
  static const String SFA_TASKS_ITEM_TOGGLER = 'sfa/tasks/itemtoggle';
  static const String SFA_CLIENT_TYPE_OPTIONS = 'clientTypeOptions';
  static const String SFA_CUSTOMER_CLASS_OPTIONS = 'customerClassOptions';
  static const String SFA_LOCATION_LOG = 'sfa/location-log/store';
  static const String SFA_LOCATION_LOGS = 'sfa/location-logs/store';
  static const String SFA_PRODUCTS_GROUPS = 'sfa/products/groups';
  static const String SFA_PAYMENTS = 'sfa/payments';
  static const String SFA_ESTIMATED_CUSTOMER_REPORT = 'sfa/reports/estimatedCustomerReport';
  static const String SFA_PAYMENT_METHODS = '/sfa/payment_methods';
  static const String SFA_PAYMENT_METHODS_APPROVE =
      '/sfa/payments/change-status';
  static const String SUBORDINATES = '/subordinateOptions';
  static const String SFA_DASHBOARD = '/sfa/dashboard';

  static const String SFA_TOUR_PLAN = 'sfa/tour-plan';
  static const String PAYMENT_SCHEDULE = 'sfa/payment-schedules';
  static const String LOCATION_TRACK = 'sfa/location_tracking';
  static const String SFA_TOUR_PLAN_APPROVE = '/sfa/tour-plan/change-status';
  static const String SFA_TOUR_PLAN_NOTE = '/sfa/tour-plan/save';

  static const String SFA_MY_TOUR_PLAN = 'sfa/my-tour-plan';
  static const String SFA_BEAT_OPTIONS = '/beatOptions';
  static const String SFA_ORDER_SLIP = '/sfa/order-slip';
  static const String SFA_PAY_SLIP = '/sfa/pay-slip';

  //expenses
  static const String EXPENSE_CATEGORIES = "/expense-categories";
  static const String EXPENSES = '/expenses';
  static const String EXPENSES_STATUS_CHANGE = '/expenses/change-status';
  static const String EXPENSES_BULK_STATUS_CHANGE = '/expenses/change-status-bulk';

  //L
  static const String LOGIN = "login";
  static const String LEAVE_CATEGORIES = "leave-categories";
  static const String LEAVE = "leave-applications";
  static const String LOGOUT = "logout";
  static const String REMAINING_lEAVE = "leave-applications/remaining_leave";
  static const String HOLIDAYS = "holidays";
  static const String FORGOT_PASSWORD = "forgot-password";
  static const String FILES = "files";
  static const String SUREVYANDPOLL = 'survey/participatiable';

  //u
  static const String FCM_TOKEN = 'update_member_notification_token';

  //customer
  static const String SFA_CUSTOMER_LOGIN = 'sfa/customer/login';
  static const String SFA_CUSTOMER_ORDER = 'sfa/customer/orders';
}
