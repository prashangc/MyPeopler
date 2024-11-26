import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/repository/repository.dart';

class HolidayController extends GetxController {
  final HolidayRepository _holidayRepo = getIt<HolidayRepository>();

  final Rx<HolidayResponse?> _holidayResponse = Rx<HolidayResponse?>(null);
  List<Holiday> get holidays => _holidayResponse.value?.data ?? [];

  var isRefreshing = false.obs;

  

  getHolidays() async {
    var res = await _holidayRepo.getHolidays();
    if (!res.hasError) {
      _holidayResponse.value = res.data as HolidayResponse;
      log(holidays.toString(), name: "AwardController");
      update();
    }
  }

  refreshHolidays() async {
    isRefreshing(true);
    update();
    await getHolidays();
    isRefreshing(false);
    update();
  }
}
