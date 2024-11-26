import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_tour_plan_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class TourPlanDetailView extends StatefulWidget {
  TourPlanDetailView({super.key, this.tourPlan});
  SfaTourPlan? tourPlan;

  @override
  State<TourPlanDetailView> createState() => _TourPlanDetailViewState();
}

class _TourPlanDetailViewState extends State<TourPlanDetailView> {
  bool isEdit = false;
  final isTourPlanReport = Get.arguments[2];
  TextEditingController noteController = TextEditingController();
  @override
  void initState() {
    widget.tourPlan = Get.arguments[0];
    isEdit = Get.arguments[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController submitNoteController =
        TextEditingController(text: widget.tourPlan?.note ?? '');
    var startDate = widget.tourPlan?.startFrom;
    var status = widget.tourPlan?.status ?? 'pending';
    var endDate = widget.tourPlan?.endTo;
    return Scaffold(
        appBar: AppBar(
          title: Text('Tour Plan Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tour Day: ${widget.tourPlan?.tourDays}',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
                isEdit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Created By: ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            widget.tourPlan!.createdByName.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "From: $startDate\nTo: $endDate",
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "From: $startDate\nTo: $endDate",
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.end,
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.tourPlan?.title ?? "",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1.3,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.tourPlan?.description ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1.3,
                ),
                SizedBox(
                  height: 5,
                ),
                widget.tourPlan!.beats!.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Beats',
                            style: TextStyle(fontSize: 20),
                          ),
                          ...List.generate(
                            widget.tourPlan!.beats!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ListTile(
                                tileColor: ColorManager.creamColor2,
                                title: Text(
                                    widget.tourPlan?.beats?[index].name ?? ''),
                              ),
                            ),
                          )
                        ],
                      )
                    : Text('No Beats Added', style: TextStyle(fontSize: 20)),
                !isTourPlanReport?
                status == 'approved'
                    ? Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 5,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                hintText: 'Notes',
                                hintStyle: TextStyle(fontSize: 16)),
                            controller: submitNoteController.text != ''
                                ? noteController = submitNoteController
                                : noteController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GetBuilder<SfaTourPlanController>(
                              builder: (controller) {
                            return Row(
                              children: [
                                Expanded(
                                  child: SubmitButton(
                                      color: Colors.blue.shade400,
                                      onPressed: () async {
                                        var data =
                                            await controller.createTourPlanNote(
                                                widget.tourPlan?.id,
                                                'save',
                                                noteController.text);
                                        MessageHelper.showInfoAlert(
                                            context: context,
                                            title: data,
                                            btnOkOnPress: () {
                                              controller.getSfaTourPlan();
                                              Get.back();
                                            },
                                            okBtnText: 'Ok');
                                      },
                                      label: 'Save'),
                                ),
                                Expanded(
                                  child: SubmitButton(
                                      color: Colors.green,
                                      onPressed: () async {
                                        var data =
                                            await controller.createTourPlanNote(
                                                widget.tourPlan?.id,
                                                'complete',
                                                noteController.text);
                                        MessageHelper.showInfoAlert(
                                            context: context,
                                            title: data,
                                            btnOkOnPress: () {
                                              controller.getSfaTourPlan();
                                              Get.back();
                                            },
                                            okBtnText: 'Ok');
                                      },
                                      label: 'Complete'),
                                ),
                              ],
                            );
                          }),
                        ],
                      )
                    : status == 'completed'
                        ? noteField(submitNoteController)
                        : SizedBox.shrink()
                        : noteField(submitNoteController)
              ],
            ),
          ),
        ));
  }

  Widget noteField(TextEditingController note) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextField(
          readOnly: true,
          maxLines: 5,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintText: 'Notes',
              hintStyle: TextStyle(fontSize: 16)),
          controller: note,
        ),
      ],
    );
  }
}
