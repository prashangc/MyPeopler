import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/repository/repository.dart';

class NoticeController extends GetxController {
  final NoticeRepository _noticeRepo = getIt<NoticeRepository>();

  final Rx<List<Notice>> _notices = Rx<List<Notice>>([]);
  List<Notice> get notices => _notices.value;

  var isRefreshing = false.obs;

  refreshNotices() async {
    isRefreshing(true);
    update();
    await getNotices();
    isRefreshing(false);
    update();
  }

  getNotices() async {
    var res = await _noticeRepo.getNotices();
    if(!res.hasError){
      _notices.value.clear();
      _notices.value = res.data as List<Notice>;
      log(notices.toString(), name: "NoticeController");
      update();
    }
  }

  
 
}
