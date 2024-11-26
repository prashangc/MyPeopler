import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/controllers/survey_poll_controller.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/survey_poll/survey_poll_model.dart';
import 'package:my_peopler/src/resources/app_strings_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/views/surveyPoll/questions_descriptions_options_card.dart';
import 'package:my_peopler/src/widgets/my_peopler_outline_button.dart';
import 'package:my_peopler/src/widgets/my_peopler_scaffold_widget.dart';

class SurveyQuestionsOptionsPage extends StatelessWidget {
  final List<Question> questions;
  final String appTitle;
  final String surveyId;
   SurveyQuestionsOptionsPage({super.key, required this.questions, required this.appTitle, required this.surveyId});

  final PageController? controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MyPeoplerScaffoldWidget(
      appTitle: appTitle,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: questions.length,
          controller: controller,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
                
                child: Column(
                  children: [
                    QuestionDescriptionsOptionsCard(question: questions[index],surveyId:surveyId ),
                       SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyPeoplerOutlineButton(
                          onPressed:(){
                            controller!.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: AppStringsManager.previous
                          ),
                          MyPeoplerOutlineButton(
                          onPressed: index == questions.length-1?() async{
                           await callApi(context);
                          }:(){
                            controller!.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: index == questions.length-1? AppStringsManager.send:AppStringsManager.next
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
        }),
      ),
    );
  }

  Future<void> callApi(BuildContext context) async {
    bool data = await Get.find<SurveyPollController>().postSurveyAndPoll(id: surveyId);
    Get.find<NavController>().offNamed(Routes.SURVEY_POLL);
    if(data == true){
     if (context.mounted) MessageHelper.success(Get.find<SurveyPollController>().responseMessage.message!);
      
    }else{
     if (context.mounted) MessageHelper.error(Get.find<SurveyPollController>().responseMessage.message!);

    }
  }
}