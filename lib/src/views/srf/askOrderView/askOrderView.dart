// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_group_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../../../routes/routes.dart';

class AskOrderView extends StatefulWidget {
  const AskOrderView({super.key});

  @override
  State<AskOrderView> createState() => AskOrderViewState();
}

class AskOrderViewState extends State<AskOrderView> {
  late final int customerId;

  List<SfaProduct>? _initialProducts;
  List<SfaProduct>? unchangableData;
  static List<SfaProductGroupList>? unchangableDataGroup = [];
  bool addByGroup = false;
  String groupSearchValue = "";
  String? assignedfor;
  int? orderId;
  String? clientType;
  @override
  void initState() {
    customerId = Get.arguments[0];
    assignedfor = Get.arguments[1];
    orderId = Get.arguments[2];
    clientType = Get.arguments[3] ;
    Get.find<SfaProductListController>().customerId = customerId;
    getData();
    super.initState();
  }

  getData() async {
    await Get.find<SfaProductListController>().getSfaProductList('');
    await Get.find<SfaProductListController>().getSfaProductGroupList('');
    _initialProducts =
        Get.find<SfaProductListController>().sfaProductModel?.data;
    unchangableData =
        Get.find<SfaProductListController>().sfaProductModel?.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<SfaProductListController>(builder: (controller) {
            if (controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: controller.addedProducts.isNotEmpty?MainAxisAlignment.start:MainAxisAlignment.start,
              crossAxisAlignment: controller.addedProducts.isNotEmpty?CrossAxisAlignment.start:CrossAxisAlignment.start,
              children: [
                _inputs(context, controller),
                SizedBox(
                  height: 10,
                ),
                _tableRow(context),
                _listViewBuilder(context, controller),
                //Spacer(),
                controller.addedProducts.isNotEmpty?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:4.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width,
                   
                    color: ColorManager.creamColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Total MRP: ${controller.totalMrp}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
                        Text('Total S.P: ${controller.totalSellingPrice}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
                        Text('Total AVLB QTY: ${controller.totalAvailableQuantity}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
                        Text('Total ASK QTY: ${controller.totalAskQuantity}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
                        Text('Total: ${controller.totalAmount}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
                      ],
                    )),
                ):SizedBox.shrink(),
                controller.addedProducts.isNotEmpty
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      clientType=='Dealer' ||clientType=='Distributor' ? SizedBox.shrink(): _salesButton(context),
                        _button(context),
                      ],
                    )
                    : SizedBox.shrink()
              ],
            );
          }),
        ),
      ),
    );
  }

  SizedBox _button(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width/2.2,
        height: AppSize.s50,
        child: ElevatedButton(
            onPressed: () async {
           var data =    await Get.find<SfaProductListController>().postSfaProductList(assignedfor,null,orderId);
              MessageHelper.showInfoAlert(
                context: context,
                title: data,
                btnOkOnPress: () {
                  successMethod();
                },
                okBtnText: 'Ok'
              );
            },
            child: Text(
              'Order'.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            )));
  }

   SizedBox _salesButton(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width/2.2,
        height: AppSize.s50,
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => ColorManager.primaryOpacity70)),
            onPressed: () async {
           var data =  await Get.find<SfaProductListController>().postSfaProductList(assignedfor,"sales",orderId);
              MessageHelper.showInfoAlert(
                context: context,
                title: data,
                btnOkOnPress: () {
                  successMethod();
                },
                okBtnText: 'Ok'
              );
            },
            child: Text(
              'Sales'.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            )));
  }

  void successMethod() {
    if (StorageHelper.askOrderHit != null) {
      if (StorageHelper.askOrderHit!.isNotEmpty) {
        StorageHelper.askOrderHit!.add(
            '${NepaliDateTime.now().year}-${NepaliDateTime.now().month}-${NepaliDateTime.now().day} $customerId');

        // convert each item to a string by using JSON encoding
        final jsonList =
            StorageHelper.askOrderHit!.map((item) => jsonEncode(item)).toList();

        // using toSet - toList strategy
        final uniqueJsonList = jsonList.toSet().toList();

        // convert each item back to the original form using JSON decoding
        StorageHelper.setAskOrderHit(
            uniqueJsonList.map((item) => jsonDecode(item) as String).toList());
        log(StorageHelper.askOrderHit.toString());
      } else {
        StorageHelper.setAskOrderHit([
          '${NepaliDateTime.now().year}-${NepaliDateTime.now().month}-${NepaliDateTime.now().day} $customerId'
        ]);
      }
    } else {
      StorageHelper.setAskOrderHit([
        '${NepaliDateTime.now().year}-${NepaliDateTime.now().month}-${NepaliDateTime.now().day} $customerId'
      ]);
    }
    Get.back();
    if(orderId != null){
       Get.back();
        Get.back();
    }
    Get.find<SfaProductListController>().update();
  }

  Row _inputs(BuildContext context, SfaProductListController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: kTextTabBarHeight,
          width: MediaQuery.of(context).size.width / 2.3,
          child: SplashWidget(
            splashColor: Pallete.primaryCol,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            shadowColor: Colors.black,
            radius: 8,
            bgCol: ColorManager.orangeColor2,
            onTap: () async {
              addByGroup = false;
              // await Get.find<SfaProductListController>().getSfaProductList('');
              controller.sfaProductModel?.data = unchangableData;
              bottomSheet(context, controller);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: CircleAvatar(
                        backgroundColor: ColorManager.white,
                        child: Icon(
                          Icons.add_outlined,
                          color: ColorManager.orangeColor2,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ADD PRODUCT',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: kTextTabBarHeight,
          width: MediaQuery.of(context).size.width / 2.3,
          child: SplashWidget(
            splashColor: Pallete.primaryCol,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            shadowColor: Colors.black,
            radius: 8,
            bgCol: ColorManager.primaryCol,
            onTap: () async {
              //controller.sfaProductModel.data = unchangableData;

              addByGroup = true;
              bottomSheetForGroup(context, controller);
              if (groupSearchValue != "") {
                groupSearchValue = "";
                await Get.find<SfaProductListController>()
                    .getSfaProductGroupList('');
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: CircleAvatar(
                        backgroundColor: ColorManager.white,
                        child: Icon(
                          Icons.add_outlined,
                          color: ColorManager.primaryCol,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ADD BY GROUP',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> bottomSheet(
      BuildContext context, SfaProductListController controller) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 40,
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: ColorManager.primaryCol,
                              )),
                          Text(
                            'Choose Product',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                if (addByGroup == true) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              )),
                        ],
                      ),
                      CustomTFF(
                          hintText: 'Search Products',
                          onChanged: (value) => _searchItems(value)),
                    ],
                  ),
                ),
                _initialProducts != null
                    ? _initialProducts!.isEmpty
                        ? Center(
                            child: Text(
                            'No Products',
                            style: Theme.of(context).textTheme.displayLarge,
                          ))
                        : Expanded(
                            child: GetBuilder<SfaProductListController>(
                                builder: (controller) {
                              if (controller
                                      .sfaProductByGroupFilterModel?.data ==
                                  null) {
                                if (addByGroup == true) {
                                  return Center(
                                      child: Text(
                                    'No data found.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ));
                                } else {
                                  return productListNormal(controller, context);
                                }
                              } else {
                                if (addByGroup == true) {
                                  return productListFilterByGroup(
                                      controller, context);
                                } else {
                                  return productListNormal(controller, context);
                                }
                              }
                            }),
                          )
                    : Expanded(
                        child: GetBuilder<SfaProductListController>(
                            builder: (controller) {
                          if (controller.sfaProductByGroupFilterModel?.data ==
                                  null ||
                              addByGroup == false) {
                            return productListNormal(controller, context);
                          } else {
                            return productListFilterByGroup(
                                controller, context);
                          }
                        }),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget productListNormal(
      SfaProductListController controller, BuildContext context) {
      var data = controller.sfaProductModel?.data ?? [];
    if (controller.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.isEmpty) {
      return Center(
          child: Text(
        'No data found.',
        style: Theme.of(context).textTheme.displayLarge,
      ));
    }
    _initialProducts = controller.sfaProductModel?.data;
    return ListView.separated(
        itemCount: _initialProducts!.length,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 2,
            height: 2,
          );
        },
        shrinkWrap: true,
        clipBehavior: Clip.hardEdge,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: _initialProducts![index].isSelected == true
                ? ColorManager.primaryColorLight
                : Colors.white,
            onTap: () {
              // _initialProducts![index].isSelected = true;
              bool same = false;
              for (var i = 0;
                  i < controller.addedProducts.length;
                  i++) {
          
                  if (_initialProducts![index].id == controller.addedProducts[i].id) {
                    same = true;
                    Get.toNamed(Routes.EDIT_ASK_ORDER_VIEW, arguments: [
                      index,
                      controller.addedProducts[i],
                      false
                    ]);
                    break;
                  }else{
                    same = false;
                  }
             
              }

              if (same == false) {
                Get.toNamed(Routes.EDIT_ASK_ORDER_VIEW, arguments: [
                  index,
                  controller.sfaProductModel!.data![index],
                  false
                ]);
              }

              // Navigator.pop(context);
            },
            title: Text(controller.sfaProductModel?.data![index].name ?? ''),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.sfaProductModel!.data![index].code ?? ''),
                Text(
                    controller.sfaProductModel!.data![index].description ?? ''),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    'MRP : Rs. ${controller.sfaProductModel?.data![index].price.toString()}'),
                Text(
                    'Selling Price : Rs. ${controller.sfaProductModel?.data![index].sellingPrice.toString()}'),
              ],
            ),
            isThreeLine: true,
          );
        });
  }

  Widget productListFilterByGroup(
      SfaProductListController controller, BuildContext context) {
    if (controller.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (controller.sfaProductByGroupFilterModel!.data!.isEmpty) {
      return Center(
          child: Text(
        'No data found.',
        style: Theme.of(context).textTheme.displayLarge,
      ));
    }
    _initialProducts = controller.sfaProductByGroupFilterModel?.data;

    return ListView.separated(
        itemCount: _initialProducts!.length,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 2,
            height: 2,
          );
        },
        shrinkWrap: true,
        clipBehavior: Clip.hardEdge,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: _initialProducts![index].isSelected == true
                ? ColorManager.primaryColorLight
                : Colors.white,
            onTap: () {
              // _initialProducts![index].isSelected = true;
              // controller.sfaProductByGroupFilterModel!.data![index].isSelected =
              //     true;
              // controller.addProducts(
              //   controller.sfaProductByGroupFilterModel!.data![index],
              // );
              // Fluttertoast.showToast(
              //     msg:
              //         '${controller.sfaProductByGroupFilterModel?.data![index].name} added',
              //     backgroundColor: Colors.green);
                 // _initialProducts![index].isSelected = true;
              bool same = false;
              for (var i = 0;
                  i < controller.addedProducts.length;
                  i++) {
          
                  if (_initialProducts![index].id == controller.addedProducts[i].id) {
                    same = true;
                    Get.toNamed(Routes.EDIT_ASK_ORDER_VIEW, arguments: [
                      index,
                      controller.addedProducts[i],
                      false
                    ]);
                    break;
                  }else{
                    same = false;
                  }
             
              }

              if (same == false) {
                Get.toNamed(Routes.EDIT_ASK_ORDER_VIEW, arguments: [
                  index,
                  controller.sfaProductByGroupFilterModel!.data![index],
                  false
                ]);
              }

              // Navigator.pop(context);
            },
            title: Text(
                controller.sfaProductByGroupFilterModel?.data![index].name ??
                    ''),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller
                        .sfaProductByGroupFilterModel!.data![index].code ??
                    ''),
                Text(controller.sfaProductByGroupFilterModel!.data![index]
                        .description ??
                    ''),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    'MRP : Rs. ${controller.sfaProductByGroupFilterModel?.data![index].price.toString()}'),
                Text(
                    'Selling Price : Rs. ${controller.sfaProductByGroupFilterModel?.data![index].sellingPrice.toString()}'),
              ],
            ),
            isThreeLine: true,
          );
        });
  }

  _tableRow(BuildContext context) {
    return Container(
      color: ColorManager.creamColor,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 9,
                child: Text(
                  'CODE'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: Text(
                  'Product'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width / 11,
                child: Text(
                  'MRP'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width / 13,
                child: Text(
                  'S.P'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            Text(
              'Avlb Qty'.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Ask Qty'.toUpperCase(),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }

  _listViewBuilder(BuildContext context, SfaProductListController controller) {
    if (controller.addedProducts.isEmpty) {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Please add products (+)',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ],
      );
    } else {
      return Expanded(
        // height: MediaQuery.of(context).size.height/1.5,
        // width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: controller.addedProducts.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                alignment: Alignment.centerLeft,
                height: 70,
                color: Colors.red,
                child: Icon(Icons.delete),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                height: 70,
                color: Colors.green,
                child: Icon(Icons.edit),
              ),
              onDismissed: (direction) {
               if (direction == DismissDirection.startToEnd) {
                  String? productName =
                      controller.addedProducts[index].name ?? "";
                  setState(() {});
                  controller.removeProducts(index);
                  Fluttertoast.showToast(
                      msg: '$productName deleted', backgroundColor: Colors.red);
                } else {}
              },
              confirmDismiss: (direction) {
                if (direction == DismissDirection.endToStart) {
                  Get.toNamed(Routes.EDIT_ASK_ORDER_VIEW, arguments: [
                    index,
                    controller.addedProducts[index],
                    true
                  ]);
                  return Future.value(false);
                } else {
                  return Future.value(true);
                }
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color:
                    index.isOdd ? ColorManager.creamColor : ColorManager.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 9,
                          child: Text(
                            controller.addedProducts[index].code ?? '',
                            style: TextStyle(fontSize: 11.0),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                              controller.addedProducts[index].name ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11.0))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 12,
                          child: Text(
                              controller.addedProducts[index].price.toString(),
                              style: TextStyle(fontSize: 11.0))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 12,
                          child: Text(
                              controller.addedProducts[index].sellingPrice
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11.0))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 5.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      controller.addedProducts[index]
                                          .availableQuantity = controller
                                              .addedProducts[index]
                                              .availableQuantity! +
                                          1;
                                    });
                                    controller.total();
                                    log(controller.addedProducts[index]
                                        .toString());
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                  )),
                              Text(
                                  controller
                                      .addedProducts[index].availableQuantity
                                      .toString(),
                                  style: TextStyle(fontSize: 11.0)),
                              InkWell(
                                  onTap: () {
                                    if (controller.addedProducts[index]
                                            .availableQuantity !=
                                        0) {
                                      setState(() {
                                        controller.addedProducts[index]
                                            .availableQuantity = controller
                                                .addedProducts[index]
                                                .availableQuantity! -
                                            1;
                                      });
                                    }
                                     controller.total();
                                    log(controller.addedProducts[index]
                                        .toString());
                                  },
                                  child: Icon(Icons.remove, size: 18))
                            ],
                          )),
                      SizedBox(
                        width: 1,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 5.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      controller.addedProducts[index]
                                          .askQuantity = controller
                                              .addedProducts[index]
                                              .askQuantity! +
                                          1;
                                    });
                                     controller.total();
                                    log(controller.addedProducts[index]
                                        .toString());
                                  },
                                  child: Icon(Icons.add, size: 18)),
                              Text(
                                  controller.addedProducts[index].askQuantity
                                      .toString(),
                                  style: TextStyle(fontSize: 11.0)),
                              InkWell(
                                  onTap: () {
                                    if (controller
                                            .addedProducts[index].askQuantity !=
                                        0) {
                                      setState(() {
                                        controller.addedProducts[index]
                                            .askQuantity = controller
                                                .addedProducts[index]
                                                .askQuantity! -
                                            1;
                                      });
                                       controller.total();
                                      log(controller.addedProducts[index]
                                          .toString());
                                    }
                                  },
                                  child: Icon(Icons.remove, size: 18))
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Future<void> bottomSheetForGroup(
      BuildContext context, SfaProductListController controller) {
    unchangableDataGroup = controller.sfaProductGroupListModel.data;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 40,
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              )),
                          Text(
                            'Choose Group',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              )),
                        ],
                      ),
                      CustomTFF(
                          hintText: 'Search Groups',
                          onChanged: (value) => _searchItemsGroup(value)),
                    ],
                  ),
                ),
                // _initialProducts!.isEmpty
                //     ? Center(
                //         child: Text(
                //         'No Products',
                //         style: Theme.of(context).textTheme.displayLarge,
                //       ))
                //     :
                Expanded(
                  child: GetBuilder<SfaProductListController>(
                      builder: (controller) {
                    if (controller.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (controller
                        .sfaProductGroupListModel.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No data found.',
                        style: Theme.of(context).textTheme.displayLarge,
                      ));
                    }
                    //   _initialProducts = controller.sfaProductModel.data;
                    return ListView.separated(
                        itemCount:
                            controller.sfaProductGroupListModel.data!.length,
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 2,
                            height: 2,
                          );
                        },
                        shrinkWrap: true,
                        clipBehavior: Clip.hardEdge,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor:
                                // _initialProducts![index].isSelected ==
                                //         true
                                //     ? ColorManager.primaryColorLight
                                Colors.white,
                            onTap: () {
                              controller.getSfaProductList('',
                                  groupId: controller
                                      .sfaProductGroupListModel.data![index].id
                                      .toString());
                              bottomSheet(context, controller);
                            },
                            title: Text(controller.sfaProductGroupListModel
                                    .data![index].name ??
                                ''),
                          );
                        });
                  }),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _searchItemsGroup(String value) {
    groupSearchValue = value;
    if (value == "") {
      Get.find<SfaProductListController>().searchGroup(unchangableDataGroup);
    } else {
      List<SfaProductGroupList>? result =
          unchangableDataGroup!.where((products) {
        String name = products.name!.toLowerCase();

        final searchItem = value.toLowerCase();

        return name.contains(searchItem);
      }).toList();

      Get.find<SfaProductListController>().searchGroup(result);
    }
  }

  void _searchItems(String value) {
    if (Get.find<SfaProductListController>().sfaProductByGroupFilterModel ==
            null ||
        addByGroup == false) {
      if (value == "") {
        Get.find<SfaProductListController>().searchProducts(unchangableData);
      } else {
        List<SfaProduct>? result = unchangableData!.where((products) {
          String name = products.name!.toLowerCase();
          String code = products.code!.toLowerCase();
          final searchItem = value.toLowerCase();
          return name.contains(searchItem) || code.contains(searchItem);
        }).toList();
        Get.find<SfaProductListController>().searchProducts(result);
      }
    } else {
      if (value == "") {
        Get.find<SfaProductListController>().searchProductsFilterByGroup(
            Get.find<SfaProductListController>()
                .sfaProductByGroupFilterModelConstant);
      } else {
        List<SfaProduct>? result = Get.find<SfaProductListController>()
            .sfaProductByGroupFilterModelConstant
            .where((products) {
          String name = products.name!.toLowerCase();
          String code = products.code!.toLowerCase();
          final searchItem = value.toLowerCase();
          return name.contains(searchItem) || code.contains(searchItem);
        }).toList();
        Get.find<SfaProductListController>()
            .searchProductsFilterByGroup(result);
      }
    }
  }
}
