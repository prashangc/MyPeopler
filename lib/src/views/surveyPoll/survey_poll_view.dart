import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/controllers/survey_poll_controller.dart';
import 'package:my_peopler/src/resources/values_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/views/surveyPoll/surveyCard.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class SurveyPollView extends StatefulWidget {
  const SurveyPollView({super.key});

  @override
  State<SurveyPollView> createState() => _SurveyPollViewState();
}

class _SurveyPollViewState extends State<SurveyPollView> {

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Get.find<SurveyPollController>().getSurveyAndPoll();
     });
    

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          }
        ),
        automaticallyImplyLeading: false,
        title: Text('Survey & Poll'),
      ),
      body: GetBuilder<SurveyPollController>(
        builder: (surveyPollController) {
          if(surveyPollController.isLoading){
            return Center(child: CircularProgressIndicator());
          }else if(surveyPollController.surveyPollData.isEmpty){
            return NoDataWidget();
          }
          return ListView.builder(
            itemCount: surveyPollController.surveyPollData.length,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: SurveyCard(
                surveyPollModel: surveyPollController.surveyPollData[index],
                onPressed: (() {
                  surveyPollController.setIndividualQuestions(surveyPollController.surveyPollData[index].questions!);
                  Get.find<NavController>().toNamed(Routes.SURVEY_QUESTIONS_OPTIONS_PAGE,
                  arguments: [
                  surveyPollController.surveyPollData[index].questions, 
                  surveyPollController.surveyPollData[index].title,
                  surveyPollController.surveyPollData[index].id.toString(),
                  
                  ]);
                }),
              ),
            );
          }));
        }
      )
    );
  }
}
