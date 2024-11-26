import 'package:get/get.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/repository/sfa/sfaLocationTrackRepository.dart';

class LocationTrackController extends GetxController {
  final SfaLocationTrackRepository _sfaLocationTrackRepository =
      getIt<SfaLocationTrackRepository>();
  bool isLoading = false;
  String? response;

  getSfaLocationTrack(String date, int? subOrdinateId,
      [Function? setState]) async {
    isLoading = true;
    update();
    var res = await _sfaLocationTrackRepository.getSfaLocationTrack(
        date, subOrdinateId);
    if (setState != null) {
      setState();
    }
    response = res;
    isLoading = false;
    update();
  }
}
