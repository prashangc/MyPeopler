import 'package:get_storage/get_storage.dart';
import 'package:my_peopler/src/core/config/config.dart';
import 'package:my_peopler/src/models/login/customer_login/customerLogin.dart';
import 'package:my_peopler/src/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';

final box = GetStorage(LOCAL_STORAGE);

String USER_ID = "userId";
String CHECKED_IN = 'isCheckedIn';

class StorageHelper {
  // Token of the user
  static setToken(String? token) => box.write("token", token);
  static String? get token => box.read('token');
  // id of the user
  static setUserId(int? id) async {
    await box.write(USER_ID, id);
    var prefs = await SharedPreferences.getInstance();
    if (id != null) {
      await prefs.setInt(USER_ID, id);
    } else {
      await prefs.remove(USER_ID);
    }
  }

  static int? get userId => box.read(USER_ID);
  // Name of the user
  static setName(String? name) => box.write("name", name);
  static String? get userName => box.read('name') ?? "";
  // Email of the user
  static setEmail(String email) => box.write("email", email);
  static String get userEmail => box.read('email') ?? "";
  // Role
  static setUserRole(String role) => box.write("role", role);
  static String get userRole => box.read('role') ?? "";

  //Attendance boundary
  static setAttendanceBoundary(List<AttendanceBoundary> attendanceBoundary) =>
      box.write("attendanceBoundary", attendanceBoundary);
  static List<dynamic> get attendanceBoundary =>
      box.read('attendanceBoundary') ?? [];

  // Profile Avatar
  static setUserAvatar(String avatar) => box.write("avatar", avatar);
  static String get userAvatar => box.read('avatar') ?? "";
  // Phone
  static setPhone(String phone) => box.write("phone", phone);
  static String get phoneNumber => box.read('phone') ?? "";
  // Gender
  static setGender(String gender) => box.write("gender", gender);
  static String get userGender => box.read('gender') ?? "";

  // Checked In
  static setCheckedIn({required bool isCheckedIn}) async {
    await box.write(CHECKED_IN, isCheckedIn);
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(CHECKED_IN, isCheckedIn);
  }

  static bool get isCheckedIn => box.read(CHECKED_IN) ?? false;

  // Attendance id
  static setAttendanceId({required int attendanceId}) =>
      box.write("attendanceId", attendanceId);

  static removeAttendanceId() => box.remove("attendanceId");

  static int? get attendanceId => box.read("attendanceId");

  //User Type
  static setUserType({required bool isEmployee}) =>
      box.write("isEmployee", isEmployee);
  static bool? get isEmployee => box.read('isEmployee');

  // User Code
  static setUserCode(String code) => box.write("code", code);
  static String get userCode => box.read('code') ?? "";

  // User Code
  static setPassword(String password) => box.write("password", password);
  static String get userPassword => box.read('password') ?? "";

  // User Code
  static setRememberMe(bool val) => box.write("rememberMe", val);
  static bool? get rememberMe => box.read('rememberMe');

  //locationAccept
  static setLocationAccept(bool? val) => box.write("locationAccept", val);
  static bool? get locationAccept => box.read('locationAccept');

  // if token is saved then the user is logged in
  static bool get isLoggedIn => box.hasData('token');

  //askorderhit
  static setAskOrderHit(List<String> val) => box.write("askOrderHit", val);
  static List<dynamic>? get askOrderHit => box.read('askOrderHit');

  //taskhit
  static settaskhit(List<String> val) => box.write("taskhit", val);
  static List<dynamic>? get taskhit => box.read('taskhit');

  //enable background location
  static enableBackgroundLocation(bool? val) =>
      box.write("enableBackgroundLocation", val);
  static bool? get enableBackgroundlocation =>
      box.read('enableBackgroundLocation');

  //shift start time
  static setShiftStartTime(String startTime) =>
      box.write("startTime", startTime);
  static String get startTime => box.read('startTime') ?? "";

  //shift end time
  static setShiftEndTime(String endTime) => box.write("endTime", endTime);
  static String get endTime => box.read('endTime') ?? "";

  //shift live tracking enabled or not
  static setEnableLiveTracking(String liveTracking) =>
      box.write("liveTracking", liveTracking);
  static String get liveTracking => box.read('liveTracking') ?? "";

  static saveProfile(User? user) {
    if (user == null) {
      return;
    }
    setUserId(user.id);
    setName(user.name);
    setEmail(user.email ?? "");
    setGender(user.gender ?? "");
    setPhone(user.phone ?? user.contact_no_one ?? user.contact_no_two ?? "");
    setUserRole(user.role.toString());
    if (user.id == null) {
      setAttendanceBoundary(user.attendance_boundary ?? []);
    }
  }

  static saveEmployeeProfile(User? user) async {
    var shifts = user?.shifts ?? [];
    if (user == null) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    setUserId(user.id);
    setName(user.name);
    setEmail(user.email ?? "");
    setGender(user.gender ?? "");
    setPhone(user.phone ?? user.contact_no_one ?? user.contact_no_two ?? "");
    setUserRole(user.role.toString());
    if (shifts.isNotEmpty) {
      setShiftStartTime(user.shifts![0].startTime.toString());
      setShiftEndTime(user.shifts![0].endTime.toString());
      await prefs.setString(
        'start_time',
        user.shifts![0].startTime.toString(),
      );
      await prefs.setString('end_time', user.shifts![0].endTime.toString());
    }
    setEnableLiveTracking(user.enable_live_tracking.toString());
    if (user.id == null) {
      setAttendanceBoundary(user.attendance_boundary ?? []);
    }
  }

  static saveProfileCustomer(Customer? user) {
    if (user == null) {
      return;
    }
    setUserId(user.id);
    setName(user.name);
    setEmail(user.email ?? "");
    // setGender(user.gender ?? "");
    // setPhone(user.phone ?? user.contact_no_one ?? user.contact_no_two ?? "");
    // setUserRole(user.role.toString());
    // if(user.id == null){
    //   setAttendanceBoundary(user.attendance_boundary ?? []);
    // }
  }

  static logout() async {
    var email = userEmail;
    var code = userCode;
    var password = userPassword;
    var remember = rememberMe;
    var locationAR = locationAccept;
    if (enableBackgroundlocation == true) {
      enableBackgroundLocation(false);
      // Workmanager().cancelAll();
    }
    // stopBackgroundLocator();

    await box.erase();
    if (remember ?? false) {
      await setEmail(email);
      await setUserCode(code);
      await setPassword(password);
      await setRememberMe(remember ?? false);
    }
    await setLocationAccept(locationAR);
  }
}
