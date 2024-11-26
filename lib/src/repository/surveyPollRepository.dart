import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/exception/customException.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/models/response_message/response_message.dart';
import 'package:my_peopler/src/models/survey_poll/survey_poll_model.dart';
import 'package:my_peopler/src/services/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(env: [Env.dev, Env.prod])
@Singleton()
class SurveyPollRespository {
  final IHttpService client;

  SurveyPollRespository(this.client);

  // Get Survey and Poll
  Future<BaseResponse> getSurveyAndPoll() async {
    try {

      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.get(
          endPoint: Endpoints.SUREVYANDPOLL,
          queryParameters: {'code': StorageHelper.userCode},
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          }));
      
      
      if (response.statusCode == 200) {
        
        return BaseResponse<List<SurveyPollModel>>(
          status: "success",
          data: surveyPollModelFromJson(json.encode(response.data)),
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
        error: ExceptionHelper.getExceptionMessage(e, name: "surevypollerror"),
      );
    }
  }

  Future<BaseResponse> postSurveyAndPoll({required SurveyPollPostModel surveyPollPostModel}) async {
    try {

      var token = StorageHelper.token;
      if (token == null) {
        throw CustomException("Something went wrong!!!");
      }
      var response = await client.post(
          endPoint: '${Endpoints.POSTSUREVYANDPOLL}/${surveyPollPostModel.id}',
          queryParameters: {'code': StorageHelper.userCode},
          options: Options(headers: {
            'Authorization': "Bearer $token",
            'Accept': "applications/json"
          },),
          data: surveyPollPostModelToJson(surveyPollPostModel)
          );
      
      
      if (response.statusCode == 200) {
        
        return BaseResponse<ResponseMessage>(
          status: "success",
          data: responseMessageFromJson(json.encode(response.data)),
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
        error: ExceptionHelper.getExceptionMessage(e, name: "surevypollerror"),
      );
    }
  }
}
