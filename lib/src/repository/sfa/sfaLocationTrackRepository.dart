import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/services/iHttpService.dart';

@Injectable(env: [Env.prod])
@Singleton()
class SfaLocationTrackRepository {
  final IHttpService client;

  SfaLocationTrackRepository(this.client);

  // Projects
  Future getSfaLocationTrack(String? date, int? subOrdinateId) async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      dio.Response response = await client.get(
        endPoint: Endpoints.LOCATION_TRACK,
        queryParameters: {
          'code': StorageHelper.userCode,
          'date': date,
          'employee_id': subOrdinateId
        },
        options: dio.Options(
          headers: {
            'Authorization': "Bearer $token", //"Bearer $token",
            'Accept': "text/html"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return responseData;
      }

      if (response.statusCode == 500) {
        return responseData["message"];
      }

      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");
        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return null;
    }
  }
}
