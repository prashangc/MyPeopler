import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/srf/createCustomerView.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class ClientType extends StatefulWidget {
  const ClientType({super.key});

  @override
  State<ClientType> createState() => _ClientTypeState();
}

class _ClientTypeState extends State<ClientType> {
  TextEditingController clientTypeController = TextEditingController();
  TextEditingController? searchController;
  SfaCustomerList? _unchangableParentCustomerList;
  SfaCustomerList? sfaCustomerList;
  bool selectList = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
    Get.find<SfaCustomerListController>().getClientTypeOptions();
    clientTypeController = TextEditingController(text: 'Dealer');
    getCustomerList();
 });
    super.initState();
  }

  getCustomerList() async {
    _unchangableParentCustomerList =
        await Get.find<SfaCustomerListController>().getParentCustomer(marketScheme: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Client Type'),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              Get.find<SfaCustomerListController>().getParentCustomer(marketScheme: true);
            },
            color: ColorManager.darkGrey,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: GetBuilder<SfaCustomerListController>(builder: (controller) {
              sfaCustomerList = controller.parentCustomerList;
              if (controller.isLoading) {
                return Center(  
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(children: [
                  CustomTFF(
                    readOnly: true,
                    controller: clientTypeController,
                    onTap: () {
                      showClientTypes(context, controller, onTap);
                    },
                    // labelText: 'Client Type',
                  ),
                  selectList
                      ? Expanded(
                          child: Column(
                            children: [
                              CustomTFF(
                                  hintText: 'Search',
                                  labelText: 'Search',
                                  controller: searchController,
                                  onChanged: (data) => filterParentCustomerList(
                                      data, _unchangableParentCustomerList)),
                              sfaBody(context, clientTypeController.text),
                            ],
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              CustomTFF(
                                  hintText: 'Search',
                                  labelText: 'Search',
                                  controller: searchController,
                                  onChanged: (data) => filterParentCustomerList(
                                      data, _unchangableParentCustomerList)),
                              sfaBody(context, clientTypeController.text),
                            ],
                          ),
                        ),
                ]),
              );
            })));
  }

  void onTap(String client, int? clientTypeID) {
    clientTypeController.text = client;
    setState(() {
      selectList = true;
    });
  }

  Widget sfaBody(BuildContext context, String client) {
    var clientList = sfaCustomerList!.clientLists[client];
    if (clientList != null) {
      return Expanded(
        child: ListView.separated(
          itemCount: clientList.length,
          itemBuilder: (context, index) => SizedBox(
            height: 80,
            child: Card(
                child: ListTile(
              onTap: () {
               Get.toNamed(Routes.Client_Name, arguments: [clientList[index].id, clientList[index].name, client]);
              },
              title: Text(
                clientList[index].name,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(clientList[index].contact),
                  SizedBox(
                    height: 1,
                  ),
                  Text(clientList[index].address ?? ''),
                ],
              ),
              trailing: CircleAvatar(child: Icon(Icons.arrow_forward_rounded)),
            )),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
        ),
      );
    } else {
      return NoSearchResultWidget();
    }
  }
}
