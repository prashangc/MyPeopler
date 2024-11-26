import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/views/srf/office_view/buildOptions.dart';
import 'package:url_launcher/url_launcher.dart';

class Tilees {
  String price;
  String title;
  String imagePath;
  Color color;
  Tilees(this.price, this.title, this.imagePath, this.color);
}

class OfficeView extends StatefulWidget {
  const OfficeView({super.key});

  @override
  State<OfficeView> createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> {
  late final SfaCustomerListModel sfaCustomerListModel;

  List<Tilees> tilees = [];
  Uri? _url;
  String? assignedFor;
  @override
  void initState() {
    sfaCustomerListModel = Get.arguments[0];
    assignedFor = Get.arguments[1];
    tilees = [
      Tilees(sfaCustomerListModel.totalOrderQty.toString(), 'Total orders',
          MyAssets.askDetail, ColorManager.orangeColor),
      Tilees(sfaCustomerListModel.totalOrderAmount.toString(), 'Total amount',
          MyAssets.askOrder, ColorManager.strawBerryColor),
      Tilees(sfaCustomerListModel.totalPaymentAmount.toString() , 'Total Payment',
          MyAssets.askOrder, ColorManager.lightGreen),
    ];
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<SfaCustomerListController>().onInit();
    // });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sfaCustomerListModel.name.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            _profileView(context),
            _buildOptions(context),
            _buildAskOption(context,
                title: 'ask orders', color: ColorManager.primaryCol),
            SizedBox(
              height: 5,
            ),
            _buildTaskOption(context,
                title: 'Tasks', color: ColorManager.darkPrimary),
            SizedBox(
              height: 5,
            ),
            buildOption(context,
                title: 'Payment Collection', color: ColorManager.primaryOpacity70,
                onTap: () {
                  Get.toNamed(Routes.PAYMENT_COLLECTION_VIEW,arguments: sfaCustomerListModel.id);
                },
                )
          ]),
        ),
      ),
    );
  }

  _profileView(BuildContext context) {
    return Container(
      height: AppSize.s100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Phone: '),
                InkWell(
                  onTap: (){
                      _url = Uri(
                              scheme: 'tel',
                              path: sfaCustomerListModel.contact ?? '',
                            );
                      _launchUrl();
                  },
                  child: Text(sfaCustomerListModel.contact ?? ''))
              ],
            ),
            Row(
              children: [
                Text('Email: '),
                InkWell(
                  onTap: (){
                      _url = Uri(
                              scheme: 'mailto',
                              path: sfaCustomerListModel.email ?? '',         
                            );
                      _launchUrl();
                  },
                  child: Text(sfaCustomerListModel.email ?? ''))
              ],
            ),
            Row(
              children: [
                Text('Beat Name: '),
                Text(sfaCustomerListModel.beatName ?? '')
              ],
            ),
            Row(
              children: [
                Text('Address: '),
                Text(sfaCustomerListModel.address ?? 'Address not available')
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
  if (!await launchUrl(_url!)) {
    throw Exception('Could not launch $_url');
  }
}

  _buildOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 255,
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Container(
                // height: AppSize.s40,
                decoration: BoxDecoration(
                    color: tilees[index].color,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.transparent)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tilees[index].price == 'null' ? 'N/A':tilees[index].price,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Image.asset(
                            tilees[index].imagePath,
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            tilees[index].title.toUpperCase(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: AppSize.s20,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildAskOption(BuildContext context,
      {required String title, required Color color}) {
    return GetBuilder<SfaProductListController>(builder: (controller) {
      if (controller.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: InkWell(
          onTap: () {
            if (title == 'Tasks') {
              Get.toNamed(
                Routes.TASKS,
              );
            } else {
              Get.toNamed(Routes.ASK_ORDER, arguments: [sfaCustomerListModel.id,assignedFor,null,sfaCustomerListModel.clientType]);
              Get.find<SfaProductListController>().removeAllProducts();
            }
          },
          child: Container(
            height: AppSize.s65,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  tickMethodLogic()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  CircleAvatar tickMethodLogic() {
    var returnValue;
    if (StorageHelper.askOrderHit != null) {
      if (StorageHelper.askOrderHit!.isNotEmpty) {
        for (var i = 0; i < StorageHelper.askOrderHit!.length; i++) {
          if (StorageHelper.askOrderHit![i] ==
              '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} ${sfaCustomerListModel.id}') {
            returnValue = CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.done,
                  color: Colors.green,
                ));
            break;
          } else {
            returnValue = CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward,
                ));
          }
        }
      } else {
        returnValue = CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_forward,
            ));
      }
    } else {
      returnValue = CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_forward,
          ));
    }

    return returnValue;
  }

  _buildTaskOption(BuildContext context,
      {required String title, required Color color}) {
    return GetBuilder<SfaCustomerListController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: InkWell(
          onTap: () {
            if (title == 'Tasks') {
              Get.toNamed(Routes.TASKS, arguments: sfaCustomerListModel.id);
            } else {
              Get.toNamed(Routes.ASK_ORDER, arguments: sfaCustomerListModel.id);
               Get.find<SfaProductListController>().removeAllProducts();
            }
          },
          child: Container(
            height: AppSize.s65,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  taskTickMethodLogic()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  CircleAvatar taskTickMethodLogic() {
    var returnValue;
    if (StorageHelper.taskhit != null) {
      if (StorageHelper.taskhit!.isNotEmpty) {
        for (var i = 0; i < StorageHelper.taskhit!.length; i++) {
          if (StorageHelper.taskhit![i] ==
              '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} ${sfaCustomerListModel.id}') {
            returnValue = CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.done,
                  color: Colors.green,
                ),);
            break;
          } else {
            returnValue = CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward,
                ),);
          }
        }
      } else {
        returnValue = CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_forward,
            ),);
      }
    } else {
      returnValue = CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_forward,
          ),);
    }
    return returnValue;
  }
}
