import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_peopler/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

class LocationCoOrdinatesView extends StatefulWidget {
  const LocationCoOrdinatesView({super.key});

  @override
  State<LocationCoOrdinatesView> createState() => _LocationCoOrdinatesViewState();
}

class _LocationCoOrdinatesViewState extends State<LocationCoOrdinatesView> {

  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController height = TextEditingController();
  final refreshController = RefreshController();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getCurrentLocationData();
  }

  getCurrentLocationData() async{
    if(Platform.isAndroid){
      await Utils().initializeLocation();
    }
    Position locationData = await Geolocator.getCurrentPosition();
    latitude.text =  locationData.latitude.toString();
     longitude.text =  locationData.longitude.toString();
     height.text =  (locationData.altitude * 3.28084).toString();
     setState(() {
       isLoading = false;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Current Location Co-ordinates'),),
      body: SmartRefresher(
        onRefresh: () async{
          setState(() {
            isLoading = true;
          });
          await getCurrentLocationData();
          
          refreshController.refreshCompleted();
        },
        controller: refreshController,
        child: isLoading?Center(child: CircularProgressIndicator()):
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(label: Text('Latitude',style: TextStyle(fontSize: 18),)),
                  controller: latitude,
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(
                  readOnly: true,
                   decoration: InputDecoration(label: Text('Longitude',style: TextStyle(fontSize: 18),)),
                  controller: longitude,
                           ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(
                  readOnly: true,
                     decoration: InputDecoration(label: Text('Height(Ft)',style: TextStyle(fontSize: 18),)),
                  controller: height,
                           ),
               ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                  onPressed: (){
                    Share.share(
                      'Latitude : ${latitude.text} , Longitude : ${longitude.text} , Height(Ft) : ${height.text}'
                    );
                  },
                  icon: Icon(Icons.share),
                  label: Text('Share',style: TextStyle(fontSize: 16),)),
                ),
              ),
              SizedBox(height: 5,),
              Text('*Note: Please take exact value for correct location tracking.')
          ]),
        ),
      ),
    );
  }
}