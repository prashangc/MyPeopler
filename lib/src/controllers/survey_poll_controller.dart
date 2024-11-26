import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/models/response_message/response_message.dart';
import 'package:my_peopler/src/models/survey_poll/survey_poll_model.dart';
import 'package:my_peopler/src/repository/surveyPollRepository.dart';

class SurveyPollController extends GetxController{
  SurveyPollController(this._attendanceRepo);

  final SurveyPollRespository _attendanceRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SurveyPollModel> _surveyPollData = [];
  List<SurveyPollModel> get surveyPollData => _surveyPollData;

  BaseResponse? _baseResponse;
  BaseResponse? get baseResponse => _baseResponse;

  ResponseMessage _responseMessage = ResponseMessage(message: "");
  ResponseMessage get responseMessage => _responseMessage;

  SurveyPollPostModel? _surveyPollPostModel;
  SurveyPollPostModel? get surveyPollPostModel => _surveyPollPostModel;

  final List<Answer> _answerList = [];
  List<Answer> get answerList => _answerList;

  final List<Question> _options = [];
  List<Question> get options => _options;

   List<Question> _questions = [];
  List<Question> get questions => _questions;

  String? _option;
  String? get option => _option;

  Question? _question;
  Question? get question => _question;



  Future getSurveyAndPoll() async{
    _isLoading = true;
    _baseResponse = await _attendanceRepo.getSurveyAndPoll();
    _isLoading = false;
    if(_baseResponse is BaseResponse<List<SurveyPollModel>>){
      _surveyPollData = _baseResponse!.data;
      _answerList.clear();
    }else{
      log(_baseResponse!.error.toString());
    }
    update();
  }

  Future<bool> postSurveyAndPoll({required String id}) async{
    _isLoading = true;
    SurveyPollPostModel surveyPollPostModel = SurveyPollPostModel(answers: answerList,id: id);
    _baseResponse = await _attendanceRepo.postSurveyAndPoll(surveyPollPostModel:surveyPollPostModel);
    _isLoading = false;
    
    if(_baseResponse is BaseResponse<ResponseMessage>){
      _responseMessage = _baseResponse!.data;
      _answerList.clear();
      update();
      return true;
    }else{
      
      _responseMessage.message = _baseResponse!.error;
      log(_baseResponse!.error.toString());
      update();
      return false;
    }
    
  }


  setAnswer(Answer answer){
    if(answerList.isNotEmpty){
      for (var i = 0; i < answerList.length; i++) {
      if(answer.questionId == answerList[i].questionId){
        _answerList.removeAt(i);
      }
    }
    }
     _answerList.add(answer);
     log(_answerList.toString());
     update();
  }


  setRadioButton(Answer answer){
    
    if(answerList.isNotEmpty){
    for (var i = 0; i < _answerList.length; i++) {
        if(_answerList[i].questionId == answer.questionId){
            _answerList.removeAt(i);
        }
      }
    }
    _answerList.add(answer);
    update();
  }

  setIndividualQuestions(List<Question> questions){
    _questions = questions;
  }
}