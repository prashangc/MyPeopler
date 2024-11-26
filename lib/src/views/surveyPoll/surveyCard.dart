import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/models/survey_poll/survey_poll_model.dart';
import 'package:my_peopler/src/resources/app_strings_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/my_peopler_outline_button.dart';

class SurveyCard extends StatelessWidget {
  const SurveyCard({super.key, required this.surveyPollModel,this.onPressed});
  final SurveyPollModel surveyPollModel;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p8),
      width: MediaQuery.of(context).size.width,
      height: AppSize.s3 * kToolbarHeight,
      decoration: BoxDecoration(
        color: Pallete.primaryCol,
        borderRadius: BorderRadius.circular(AppSize.s12),
       
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${MyDateUtils.getDateOnly(surveyPollModel.createdAt)}'),
          Text(surveyPollModel.title ?? "",style: Theme.of(context).textTheme.titleMedium,),
          Text(surveyPollModel.description ?? "",maxLines: 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyPeoplerOutlineButton(
                onPressed: onPressed,
                text: AppStringsManager.participate,),
            ],
          )
        ],
      ),
    );
  }
}