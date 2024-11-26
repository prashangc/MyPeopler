import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/repository/repository.dart';

class AwardController extends GetxController {
  final AwardRepository _awardRepo = getIt<AwardRepository>();

  final Rx<AwardResponse?> _award = Rx<AwardResponse?>(null);
  List<Award> get awards => _award.value?.data ?? [];

  var isRefreshing = false.obs;

 

  getAward() async {
    var res = await _awardRepo.getAwards();
    if (!res.hasError) {
      _award.value = res.data as AwardResponse;
      log(awards.toString(), name: "AwardController");
      update();
    }
  }

  refreshAward() async {
    isRefreshing(true);
    update();
    await getAward();
    isRefreshing(false);
    update();
  }
}
