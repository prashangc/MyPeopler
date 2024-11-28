import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfalocationLogsController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/baseResponse.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class SyncLocationLogsView extends StatefulWidget {
  const SyncLocationLogsView({super.key});

  @override
  State<SyncLocationLogsView> createState() => _SyncLocationLogsViewState();
}

class _SyncLocationLogsViewState extends State<SyncLocationLogsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Image.asset('assets/images/logo.png')),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Please sync your location logs. You have not synced your location logs.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.cloud_sync_outlined,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            GetBuilder<SfaLocationLogsController>(builder: (controller) {
              return SubmitButton(
                onPressed: () async {
                  BaseResponse data = await controller
                      .convertListStringToSfaLocationModel(isCheckIn: null);
                  if (data.status == 'success') {
                    MessageHelper.showSuccessAlert(
                        context: context,
                        title: 'Data Synced',
                        desc: data.data,
                        okBtnText: 'Ok',
                        btnOkOnPress: () async {
                          Get.offAllNamed(Routes.INITIAL);
                        });
                  } else if (data.status == 'error') {
                    Fluttertoast.showToast(msg: data.data);
                    MessageHelper.errorDialog(
                      context: context,
                      errorMessage: data.data,
                      btnOkText: 'Ok',
                      btnOkOnPress: () {},
                    );
                  }
                },
                label: 'Sync Location Logs',
                isLoading: controller.isLoading,
              );
            })
          ],
        ),
      ),
    );
  }
}
