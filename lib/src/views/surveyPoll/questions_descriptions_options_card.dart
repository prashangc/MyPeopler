import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/survey_poll_controller.dart';
import 'package:my_peopler/src/models/survey_poll/survey_poll_model.dart';
import 'package:my_peopler/src/resources/values_manager.dart';

class QuestionDescriptionsOptionsCard extends StatelessWidget {
  final Question question;
  final String surveyId;
  const QuestionDescriptionsOptionsCard({super.key, required this.question, required this.surveyId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.question ?? "",style: Theme.of(context).textTheme.titleLarge,),
          SizedBox(height: AppSize.s4,),
          Text(question.description ?? "",style: Theme.of(context).textTheme.titleSmall,),
          SizedBox(height: AppSize.s4,),
          _textOrRadio(),
          SizedBox(height: AppSize.s4,),
          
        ],
      ),
    );
  }

  Widget _textOrRadio() {
    if (question.answerType == 'text') {
      return TextField(
        controller: TextEditingController(text: getTextValue(question)),
        onChanged: (d){
          Get.find<SurveyPollController>().setAnswer(Answer(questionId: question.id, answer: d));
      },);
    } else {
      return GetBuilder<SurveyPollController>(
        builder: (surveyPollController) {
          return Column(
            children: [
              ...question.options!.map(
                (text) {
                 
                  return RadioListTile<String>(
                    contentPadding: EdgeInsets.all(0.0),
                    groupValue: getGroupValue(surveyPollController,text),
                    value: text,
                    onChanged: (selectedValue) {
                      surveyPollController.setRadioButton(Answer(questionId: question.id,answer: selectedValue));
                    },
                    title: Text(text),
                  );
                },
              )
            ],
          );
        }
      );
    }
  }

  String getGroupValue(SurveyPollController surveyPollController, String text){
   List<Answer> ans = surveyPollController.answerList;
    if(ans.isNotEmpty){
      for (var i = 0; i < ans.length; i++) {
        if(ans[i].answer == text){
          return text;
        }
      }
    }
    return "";
  }
  
  String? getTextValue(Question question) {
     List<Answer> ans = Get.find<SurveyPollController>().answerList;
    if(ans.isNotEmpty){
      for (var i = 0; i < ans.length; i++) {
        if(ans[i].questionId == question.id){
          return ans[i].answer;
        }
      }
    }
    return "";
  }

}
