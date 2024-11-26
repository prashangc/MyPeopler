import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';

class SfaGoogleMapView extends StatefulWidget {
  const SfaGoogleMapView({super.key});

  @override
  State<SfaGoogleMapView> createState() => _SfaGoogleMapViewState();
}

class _SfaGoogleMapViewState extends State<SfaGoogleMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  SfaCustomerList customerList = SfaCustomerList(clientLists: {});
  CameraPosition? _kGooglePlex;
  MapType mapType = MapType.normal;
  List<Marker> _marker = [];
  final List<Marker> _list = [];
  @override
  void initState() {
    getCurrentLocation();
    _marker.addAll(_list);
    customerList = Get.find<SfaCustomerListController>().sfaCustomerList;
    try{
      for (var list in customerList.clientLists.values) {
      _marker.addAll(list.map(
        (e) => Marker(
            markerId: MarkerId(e.id.toString()),
            position:
                LatLng(double.parse(e.lat ?? '0'), double.parse(e.long ?? '0')),
            infoWindow: InfoWindow(
              title: e.name,
            )),
      ));
    }
    }catch(e){
      log('lat and long not found');
    }
    

    super.initState();
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    _kGooglePlex = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: _kGooglePlex == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    GoogleMap(
                        rotateGesturesEnabled: true,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        mapType: mapType,
                        zoomControlsEnabled: false,
                        initialCameraPosition: _kGooglePlex!,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        markers: _marker.toSet()),
                    Positioned(
                        child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Get.back();
                      },
                    )),
                    Positioned(
                      bottom: 4,
                      left: 3,
                      child: FloatingActionButton.extended(
                          elevation: 2,
                          tooltip: mapType == MapType.hybrid
                              ? 'Normal View'
                              : 'Satellite View',
                          backgroundColor: mapType == MapType.hybrid
                              ? ColorManager.lightGreen
                              : ColorManager.orangeColor2,
                          onPressed: () {
                            setState(() {
                              if (mapType == MapType.normal) {
                                mapType = MapType.hybrid;
                              } else {
                                mapType = MapType.normal;
                              }
                            });
                          },
                          label: mapType == MapType.hybrid
                              ? Icon(Icons.map_sharp)
                              : Icon(Icons.satellite_alt_outlined)),
                    ),
                  ],
                )),
    );
  }
}
