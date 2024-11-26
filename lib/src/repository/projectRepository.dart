import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/services/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(env: [Env.dev, Env.prod])
@Singleton()
class ProjectRepository {
  final IHttpService client;

  ProjectRepository(this.client);

  // Projects
  Future<BaseResponse> getProject() async {
    try {
      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
        endPoint: Endpoints.PROJECTS,
        queryParameters: {'code': StorageHelper.userCode},
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },
        ),
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        return BaseResponse<ProjectResponse>(
          status: "success",
          data: ProjectResponse.fromJson(responseData),
        );
      }
      if (response.statusCode == 401) {
        MessageHelper.error("Session Expired.");

        await Get.find<AuthController>().logout();
      }
      throw (ApiException("Something went wrong"));
    } catch (e) {
      return BaseResponse(
        status: "error",
        data: null,
        error: ExceptionHelper.getExceptionMessage(e, name: "getProjects"),
      );
    }
  }
}
