import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/utils.dart';

import '../helpers/helpers.dart';
import '../routes/routes.dart';

class InAppDisClosure extends StatefulWidget {
  const InAppDisClosure({Key? key}) : super(key: key);

  @override
  State<InAppDisClosure> createState() => _InAppDisClosureState();
}

class _InAppDisClosureState extends State<InAppDisClosure> {
 // SharedPreferences sharedPreferences = sl<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: SizedBox(
                    width: 200,
                    height: 100,
                    child: Image.asset('assets/images/logo.png')),
              ),
              Spacer(),
              Text(
                'MyPeopler collects location data of the device to enable tracking feature even when the app is closed or not in use.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              Spacer(),
              Text(
                'MyPeopler collects latitude and longitude of current location of the device in every five minutes on location changed. In every five minutes the current location of the user is collected and stored locally. (Applied only for sfa module.)',
                textAlign: TextAlign.justify,
              ),
                Spacer(),
                Text(
                'On ACCEPT location tracking feature is enabled. On DENY location tracking is disabled. ',
                textAlign: TextAlign.justify,
              ),
               Spacer(),
              Center(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                    
                    decoration: BoxDecoration(
                        //border: Border.all(),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Image.asset(
                      'assets/images/location_track_image.png',
                   width: 150,
                    height: 150,
                    fit: BoxFit.fill,
                    )),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                     Get.offAllNamed(
                            Routes.SECOND_IN_APP_DISCLOSURES,
                        );
                        StorageHelper.setLocationAccept(false);
                    // sharedPreferences.setString('track_background_location', 'DENY');
                    //  Navigator.pushReplacementNamed(context, kLoginScreenPath);
                  }, child: Text('DENY')),
                  TextButton(
                    onPressed: () async {
                      await Utils().initializeLocation();
                        Get.offAllNamed(
                            Routes.INITIAL,
                        );
                      // sharedPreferences.setString('track_background_location', 'ACCEPT');
                      //  Navigator.pushReplacementNamed(context, kLoginScreenPath);
                    }, 
                    child: Text('ACCEPT')),
                ],
              ),
                Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
