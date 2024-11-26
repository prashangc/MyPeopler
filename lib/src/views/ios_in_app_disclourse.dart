import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/routes/appPages.dart';

class IosInAppDisclourse extends StatefulWidget {
  const IosInAppDisclourse({
    super.key,
  });
  @override
  State<IosInAppDisclourse> createState() => _SecondInAppDisclourseState();
}

class _SecondInAppDisclourseState extends State<IosInAppDisclourse> {
  bool? notificationLocation;
  
  @override
  void initState() {
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
              Text(
                'Enable location to use app in proper way.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        //border: Border.all(),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Image.asset(
                      'assets/images/location_track_image.png',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                  
                       _checkLocationPermission();
                    },
                    child: Text(
                      'Get Started',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

_checkLocationPermission() async {
  LocationPermission locationPermission = await Geolocator.checkPermission();
  if (locationPermission == LocationPermission.denied) {
    locationPermission = await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      StorageHelper.setLocationAccept(false);
      Geolocator.openLocationSettings();
    } else if (locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
      StorageHelper.setLocationAccept(false);
      Geolocator.openLocationSettings();
    } else if (locationPermission == LocationPermission.unableToDetermine) {
      StorageHelper.setLocationAccept(false);
      Geolocator.openLocationSettings();
    } else if (locationPermission == LocationPermission.always) {
      StorageHelper.setLocationAccept(true);
      if (StorageHelper.isEmployee == null) {
        Get.offAllNamed(Routes.INITIAL);
      } else if (StorageHelper.isEmployee!) {
        Get.offAllNamed(Routes.INITIAL);
      } else {
        Get.offAllNamed(Routes.CUSTOMER_NAV_VIEW);
      }
    } else if (locationPermission == LocationPermission.whileInUse) {
      StorageHelper.setLocationAccept(true);
      if (StorageHelper.isEmployee == null) {
        Get.offAllNamed(Routes.INITIAL);
      } else if (StorageHelper.isEmployee!) {
        Get.offAllNamed(Routes.INITIAL);
      } else {
        Get.offAllNamed(Routes.CUSTOMER_NAV_VIEW);
      }
    }
  } else if (locationPermission == LocationPermission.whileInUse) {
    StorageHelper.setLocationAccept(true);
    if (StorageHelper.isEmployee == null) {
      Get.offAllNamed(Routes.INITIAL);
    } else if (StorageHelper.isEmployee!) {
      Get.offAllNamed(Routes.INITIAL);
    } else {
      Get.offAllNamed(Routes.CUSTOMER_NAV_VIEW);
    }
  }

  if (locationPermission == LocationPermission.deniedForever) {
    locationPermission = await Geolocator.requestPermission();
    StorageHelper.setLocationAccept(false);
    Geolocator.openLocationSettings();
  }
}