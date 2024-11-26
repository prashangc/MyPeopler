import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_beat_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';
import 'package:my_peopler/src/views/srf/srfView.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class CreateCustomerView extends StatefulWidget {
  const CreateCustomerView({super.key});

  @override
  State<CreateCustomerView> createState() => _CreateCustomerViewState();
}

class _CreateCustomerViewState extends State<CreateCustomerView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController clientTypeController = TextEditingController();
  TextEditingController classTypeController = TextEditingController();
  TextEditingController beatController = TextEditingController();
  TextEditingController parentController = TextEditingController();
  TextEditingController establishedYearController = TextEditingController();
  TextEditingController panController = TextEditingController();

  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  TextEditingController contactPersonNameController = TextEditingController();
  TextEditingController contactPersonEmailController = TextEditingController();
  TextEditingController contactPersonPositionController =
      TextEditingController();
  TextEditingController contactPersonContactNumberController =
      TextEditingController();
  TextEditingController contactPersonGenderController = TextEditingController();

  int? clientId;
  int? classId;
  int? parentId;
  int? beatId;
  bool isLoading = true;
  SfaCustomerList? _unchangableParentCustomerList;
  List<BeatOptionsModel>? _unchangableBeatOptionList;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<SfaCustomerListController>().getClientTypeOptions();
      await Get.find<SfaCustomerListController>().getClassTypeOptions();
      _unchangableParentCustomerList =
          await Get.find<SfaCustomerListController>().getParentCustomer();
      _unchangableBeatOptionList = await Get.find<SfaCustomerListController>().getBeatOptions();
      await getCurrentLocationData();
    });

    super.initState();
  }

  getCurrentLocationData() async {
    Position locationData = await Geolocator.getCurrentPosition();
    latitudeController.text = locationData.latitude.toString();
    longitudeController.text = locationData.longitude.toString();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Customer'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : GetBuilder<SfaCustomerListController>(builder: (controller) {
              if(controller.isLoading){
                return Center(child: CircularProgressIndicator());
              }
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Organization Detail:',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '* Required Fields',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      CustomTFF(
                        controller: nameController,
                        labelText: 'Name * ',
                      ),
                      CustomTFF(
                        controller: emailController,
                        labelText: 'Email',
                      ),
                      CustomTFF(
                        controller: contactNumberController,
                        labelText: 'Contact Number * ',
                      ),
                      CustomTFF(
                        controller: establishedYearController,
                        labelText: 'Established Year',
                      ),
                      CustomTFF(
                        controller: panController,
                        labelText: 'Pan/Vat Number',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                            'Note: By default current location co-ordinates are displayed in Latitude and Longitude.'),
                      ),
                      CustomTFF(
                        controller: latitudeController,
                        labelText: 'Latitude',
                      ),
                      CustomTFF(
                        controller: longitudeController,
                        labelText: 'Longitude',
                      ),
                      CustomTFF(
                        readOnly: true,
                        controller: clientTypeController,
                        onTap: () {
                          showClientTypes(context, controller, onTap);
                        },
                        labelText: 'Client Type * ',
                      ),
                      CustomTFF(
                        readOnly: true,
                        controller: classTypeController,
                        onTap: () {
                          showClassTypes(context, controller);
                        },
                        labelText: 'Class Type',
                      ),
                      CustomTFF(
                        readOnly: true,
                        controller: beatController,
                        onTap: () {
                           Get.find<SfaCustomerListController>().searchBeat(_unchangableBeatOptionList);
                           showBeats(context);
                        },
                        labelText: 'Select Beat *',
                      ),
                      CustomTFF(
                        readOnly: true,
                        controller: parentController,
                        onTap: () {
                          Get.find<SfaCustomerListController>().searchParentCustomer(_unchangableParentCustomerList);
                          showParentCustomer(context,);
                        },
                        labelText: 'Parent Customer',
                      ),
                      CustomTFF(
                        controller: addressController,
                        labelText: 'Address * ',
                      ),
                      SizedBox(
                        height: AppSize.s12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Contact Person:',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomTFF(
                        controller: contactPersonNameController,
                        labelText: 'Name',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomDFF(
                            name: 'Gender',
                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text('Male'),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text('Female'),
                              )
                            ],
                            onChanged: (a) {
                              contactPersonGenderController.text = a ?? '';
                            },
                            value: null),
                      ),
                      CustomTFF(
                        controller: contactPersonEmailController,
                        labelText: 'Email',
                      ),
                      CustomTFF(
                        controller: contactPersonContactNumberController,
                        labelText: 'Contact Number *',
                      ),
                      CustomTFF(
                        controller: contactPersonPositionController,
                        labelText: 'Position',
                      ),
                      SizedBox(
                        height: AppSize.s12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SizedBox(
                            height: AppSize.s50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (nameController.text != '' &&
                                      contactNumberController.text != '' &&
                                      clientTypeController.text != '' &&
                                      addressController.text != '' &&
                                      beatController.text != '' &&
                                      contactPersonContactNumberController.text != ''
                                      ) {
                                    var data =
                                        await Get.find<SfaCustomerListController>()
                                            .postSfaCustomer(CustomerData(
                                                name: nameController.text,
                                                contactNumber:
                                                    contactNumberController
                                                        .text,
                                                address: addressController.text,
                                                clientId: clientId,
                                                classId: classId,
                                                parentId: parentId,
                                                beatId: beatId,
                                                email: emailController.text,
                                                establishedYear:
                                                    establishedYearController
                                                        .text,
                                                panNumber: panController.text,
                                                latitude:
                                                    latitudeController.text,
                                                longitude:
                                                    longitudeController.text,

                                                //contact person detail
                                                contactPersonName:
                                                    contactPersonNameController
                                                        .text,
                                                contactPersonGender:
                                                    contactPersonGenderController
                                                        .text,
                                                contactPersonEmail:
                                                    contactPersonEmailController
                                                        .text,
                                                contactPersonNumber:
                                                    contactNumberController
                                                        .text,
                                                contactPersonPosition:
                                                    contactPersonPositionController
                                                        .text));
                                    if (data ==
                                        'Customer Creation Request Successfully') {
                                      MessageHelper.showSuccessAlert(
                                          context: context,
                                          title: 'Success',
                                          desc: data,
                                          okBtnText: 'Ok',
                                          btnOkOnPress: () {
                                            Get.back();
                                          });
                                    } else {
                                      MessageHelper.errorDialog(
                                          context: context,
                                          errorMessage: data,
                                          btnOkOnPress: () {});
                                    }
                                  } else {
                                    MessageHelper.showWarningAlert(
                                        context: context,
                                        title:
                                            'Required (*) fields not entered',
                                        desc:
                                            'Please enter all the required (*) fields.',
                                        okBtnText: 'Ok',
                                        btnOkOnPress: () {},);
                                  }
                                },
                                child: Text(
                                  'Create',
                                  style: TextStyle(fontSize: 16),
                                ))),
                      )
                    ],
                  ),
                );
              }));
  }


  Future<void> showClassTypes(
      BuildContext context, SfaCustomerListController controller) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2,
                );
              },
              itemCount: controller.classTypeOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text(controller.classTypeOptions[index].name.toString()),
                  onTap: () {
                    classTypeController.text =
                        controller.classTypeOptions[index].name.toString();
                    classId = controller.classTypeOptions[index].id;
                    Get.back();
                  },
                );
              },
            ),
          );
        });
  }

  Future<void> showParentCustomer(
      BuildContext context,) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 40,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Choose Parent Customer',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: ColorManager.red,
                                )),
                          ],
                        ),
                        CustomTFF(
                            hintText: 'Search Parent Customer',
                            onChanged: (data) => filterParentCustomerList(data, _unchangableParentCustomerList)),
                      ])),
                  Expanded(
                    child: GetBuilder<SfaCustomerListController>(
                      builder: (controller) {
                    if (controller.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (controller.parentCustomerList.clientLists.isEmpty){
                      return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 370,
                                width: MediaQuery.of(context).size.width,
                                child: NoDataWidget(),
                              ),
                            ],
                          ));
                    }
                        return ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: controller
                                .parentCustomerList.clientLists.entries
                                .map((e) {
                              e.value.sort(((a, b) => a.name
                                  .toLowerCase()
                                  .compareTo(b.name.toLowerCase())));
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0,
                                        right: 4.0,
                                        top: 4.0,
                                        bottom: 4.0),
                                    child: Container(
                                      color: ColorManager.primaryColorLight,
                                      height: 35,
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8.0, right: 8.0),
                                        child: Text(
                                          e.key,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...e.value.map((e) => SizedBox(
                                        height: 80,
                                        child: Card(
                                          child: ListTile(
                                            isThreeLine: false,
                                            tileColor: forColorChangeMethod(
                                              e,
                                            ),
                                            onTap: () {
                                                  parentController.text = e.name;
                                                  parentId = e.id;
                                              Get.back();
                                            },
                                            title: Text(
                                              e.name ?? '',
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(e.contact ?? ''),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Text(e.address ?? ''),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              );
                            }).toList());
                      }
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> showBeats(
      BuildContext context,) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 40,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Choose Beat',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: ColorManager.red,
                                )),
                          ],
                        ),
                        CustomTFF(
                            hintText: 'Search Beat',
                            onChanged: (data) => filterBeat(data)),
                      ])),
                  Expanded(
                    child: GetBuilder<SfaCustomerListController>(
                      builder: (controller) {
                    if (controller.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (controller.beatOptions.isEmpty) {
                      return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 370,
                                width: MediaQuery.of(context).size.width,
                                child: NoDataWidget(),
                              ),
                            ],
                          ));
                    }
                        return ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: controller.beatOptions
                                .map((e) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    SizedBox(
                                        height: 80,
                                        child: Card(
                                          child: ListTile(
                                            isThreeLine: false,
                                            onTap: () {
                                                  beatController.text = e.name ?? '';
                                                  beatId = e.id;
                                              Get.back();
                                            },
                                            title: Text(
                                              e.name ?? '',
                                            ),
                                          ),
                                        ),
                                      )
                                ],
                              );
                            }).toList());
                      }
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  filterBeat(String searchTerm) {
    List<BeatOptionsModel>? result = _unchangableBeatOptionList!
            .where((products) {
          String name = products.name!.toLowerCase();
          final searchItem = searchTerm.toLowerCase();
          return name.contains(searchItem);
        }).toList();
    Get.find<SfaCustomerListController>().searchBeat(result);
  }

  void onTap(String client, int? clientTypeID) {
    clientTypeController.text = client;
    clientId = clientTypeID;
  }
}

Future<void> showClientTypes(
      BuildContext context, SfaCustomerListController controller, Function(String, int?) onTap) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2,
                );
              },
              itemCount: controller.clientTypeOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text(controller.clientTypeOptions[index].name.toString()),
                  onTap: () {
                    onTap(controller.clientTypeOptions[index].name.toString(), controller.clientTypeOptions[index].id);
                    // clientTypeController.text =
                    //     controller.clientTypeOptions[index].name.toString();
                    // clientId = controller.clientTypeOptions[index].id;
                    Get.back();
                  },
                );
              },
            ),
          );
        });

  }

   filterParentCustomerList(String searchTerm, SfaCustomerList? unchangableParentCustomerList) {
    Map<String, List<SfaCustomerListModel>> filteredParentCustomerList = {};
    unchangableParentCustomerList!.clientLists.forEach((key, value) {
      List<SfaCustomerListModel> filteredParentCustomers = value
          .where((customer) =>
              customer.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              customer.contact
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              (customer.address != null &&
                  customer.address!
                      .toLowerCase()
                      .contains(searchTerm.toLowerCase())))
          .toList();

      if (filteredParentCustomers.isNotEmpty) {
        filteredParentCustomerList[key] = filteredParentCustomers;
        Get.find<SfaCustomerListController>().searchParentCustomer(
            SfaCustomerList(clientLists: filteredParentCustomerList));
      }
    });
    if (filteredParentCustomerList.isEmpty) {
      Get.find<SfaCustomerListController>()
          .searchParentCustomer(SfaCustomerList(clientLists: {}));
    }
  }