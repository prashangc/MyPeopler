import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/utils.dart';

class SecondInAppDisclourse extends StatefulWidget {
  SecondInAppDisclourse({super.key, this.hasButton});
  bool? hasButton = true;
  @override
  State<SecondInAppDisclourse> createState() => _SecondInAppDisclourseState();
}

class _SecondInAppDisclourseState extends State<SecondInAppDisclourse> {
  @override
  void initState() {
    widget.hasButton ??= Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: SizedBox(
                    width: 150,
                    height: 70,
                    child: Image.asset('assets/images/logo.png')),
              ),
              SizedBox(
                height: 40,
              ),
              widget.hasButton == false
                  ? Text(
                      'Enable location from notification bar. Also, check your storage permission and enable it.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    )
                  : Text(
                      'Enable location to use app in proper way. Also, enable your storage permission.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Center(
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          //border: Border.all(),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Image.asset(
                        'assets/images/location_track_image.png',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              widget.hasButton == null || widget.hasButton == true
                  ? SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            await Utils().initializeLocation();
                            if (StorageHelper.locationAccept == true) {
                              Get.offAllNamed(
                                Routes.INITIAL,
                              );
                            }
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                    )
                  : SizedBox.shrink(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
