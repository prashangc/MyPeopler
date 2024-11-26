import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/storageHelper.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class SrfView extends StatefulWidget {
  const SrfView({super.key});

  @override
  State<SrfView> createState() => _SrfViewState();
}

class _SrfViewState extends State<SrfView> {
  bool showAllFloationActionButtons = false;
  List? assignedfor;
  SfaCustomerList? sfaCustomerList;
  SfaCustomerList? _unchangablesfaCustomerList;
  TextEditingController? searchController;
  @override
  void initState() {
    assignedfor = Get.arguments;
    getCustomerList();
    super.initState();
  }

  getCustomerList() async {
    _unchangablesfaCustomerList = await Get.find<SfaCustomerListController>()
        .getSfaCustomerList(assignedfor![0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: ListTile(
            leading: Image.asset(
              MyAssets.sfa,
              height: 40,
              width: 40,
            ),
            title: Text(
              'SFA',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text('Sales Force Automation',
                style: TextStyle(color: Colors.white)),
            isThreeLine: false,
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            showAllFloationActionButtons
                ? Column(
                    children: [
                      FloatingActionButton(
                        mini: !showAllFloationActionButtons,
                        heroTag: 'Customers Location',
                        tooltip: 'Customers Location',
                        backgroundColor: ColorManager.orangeColor2,
                        child: Icon(Icons.location_pin),
                        onPressed: () {
                          Get.toNamed(Routes.SFA_GOOGLE_MAP_VIEW);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: () {
                          Get.toNamed(Routes.CREATE_CUSTOMER);
                        },
                        tooltip: 'Create Customer',
                        child: Icon(
                          Icons.add,
                          size: 28,
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
                mini: showAllFloationActionButtons,
                heroTag: 'Menu',
                tooltip: 'Menu',
                backgroundColor: ColorManager.primaryColorLight,
                child: showAllFloationActionButtons
                    ? Icon(
                        Icons.close,
                      )
                    : Icon(Icons.dashboard),
                onPressed: () {
                  setState(() {
                    showAllFloationActionButtons =
                        !showAllFloationActionButtons;
                  });
                }),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<SfaCustomerListController>()
                .getSfaCustomerList(assignedfor![0]);
          },
          color: ColorManager.darkGrey,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          child: GetBuilder<SfaCustomerListController>(builder: (controller) {
            if (controller.isLoading) {
              // return Center(
              //   child: CircularProgressIndicator(),
              // );
            }

            if (assignedfor![0] == 'daily') {
              sfaCustomerList = controller.sfaCustomerList;
                return Column(
                  children: [
                    CustomTFF(
                  hintText: 'Search',
                  labelText: 'Search',
                  controller: searchController,
                  onChanged: (data) => filterBySearchTerm(data, _unchangablesfaCustomerList)),
                  controller.sfaCustomerList.clientLists.isEmpty?   
                   NoSearchResultWidget(): sfaBody(context),
                  ],
                );
            } else if (assignedfor![0] == 'all') {
              sfaCustomerList = controller.sfaCustomerListAll;
                return Column(
                  children: [
                    CustomTFF(
                  hintText: 'Search',
                  labelText: 'Search',
                  controller: searchController,
                  onChanged: (data) => filterBySearchTerm(data, _unchangablesfaCustomerList)),
                  controller.sfaCustomerListAll.clientLists.isEmpty?   
                  NoSearchResultWidget(): sfaBody(context),
                  ],
                );
            }
            return CircularProgressIndicator();
          }),
        ));
  }

  Expanded sfaBody(BuildContext context) {
    return Expanded(
      child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: sfaCustomerList!.clientLists.entries.map((e) {
            e.value.sort(((a, b) => a.name
                .toLowerCase()
                .compareTo(b.name.toLowerCase())));
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
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
                            if (assignedfor![1] == 'officeView') {
                              Get.toNamed(Routes.OFFICE_VIEW,
                                  arguments: [e, assignedfor![0]]);
                            } else {
                              Get.toNamed(Routes.ORDER_VIEW,
                                  arguments: [e.id,e.name,e.contact,e.clientType]);
                            }
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
                          trailing: CircleAvatar(
                              child: Icon(
                                  Icons.arrow_forward_rounded)),
                        ),
                      ),
                    ))
              ],
            );
          }).toList()),
    );
  }
}

forColorChangeMethod(SfaCustomerListModel e) {
  var color = ColorManager.white;
  if (StorageHelper.askOrderHit != null) {
    if (StorageHelper.askOrderHit!.isNotEmpty) {
      for (var j = 0; j < StorageHelper.askOrderHit!.length; j++) {
        if (StorageHelper.askOrderHit![j] ==
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} ${e.id.toString()}') {
          color = ColorManager.primaryColorLight;
          break;
        } else {
          color = ColorManager.white;
        }
      }
    }
  }
  return color;
}

filterBySearchTerm(String searchTerm, SfaCustomerList? unchangablesfaCustomerList) {
    Map<String, List<SfaCustomerListModel>> filteredClientLists = {};
     unchangablesfaCustomerList!.clientLists.forEach((key, value) {
      List<SfaCustomerListModel> filteredCustomers = value
          .where((customer) =>
              customer.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              customer.contact.toLowerCase().contains(searchTerm.toLowerCase()) ||
              (customer.address != null && customer.address!.toLowerCase().contains(searchTerm.toLowerCase())))
          .toList();

      if (filteredCustomers.isNotEmpty) {
        filteredClientLists[key] = filteredCustomers;
        Get.find<SfaCustomerListController>().searchData(SfaCustomerList(clientLists: filteredClientLists));
      }
    });
    if(filteredClientLists.isEmpty){
      Get.find<SfaCustomerListController>().searchData(SfaCustomerList(clientLists: {}));
    }
  }