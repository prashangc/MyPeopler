import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/helpers/messageHelper.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_order_report.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class ProductOrderEditView extends StatefulWidget {
  const ProductOrderEditView({super.key});

  @override
  State<ProductOrderEditView> createState() => _ProductOrderEditViewState();
}

class _ProductOrderEditViewState extends State<ProductOrderEditView> {

  // TextEditingController _productName = TextEditingController();
  // TextEditingController _sellingPrice = TextEditingController();
  // TextEditingController _availableQty = TextEditingController();
  // TextEditingController _askQty = TextEditingController();

  List<SfaProduct>? unchangableData;
  List<SfaProduct>? _initialProducts;
 
  ProductOrderReport? _reportDetails;
  // double? _total = 0.0;
  @override
  void initState() {
    _reportDetails = Get.arguments;
    getAndSetData();
    super.initState();
  }

   getAndSetData() async {
    Get.find<SfaProductListController>().customerId = _reportDetails!.customerId;
    Get.find<SfaProductListController>().reportDetails = _reportDetails;
    await Get.find<SfaProductListController>().getSfaProductList('');
    _initialProducts =
        Get.find<SfaProductListController>().sfaProductModel?.data;
    unchangableData =
        Get.find<SfaProductListController>().sfaProductModel?.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editing Order #${_reportDetails?.orderNumber}'),
        actions: [
          IconButton(
            onPressed: (){
              Get.toNamed(Routes.PRODUCT_ORDER_REPORT_ADD_ITEM_VIEW,arguments: _reportDetails?.orderNumber);
            }, 
            icon: Icon(Icons.add))
        ],
      ),
      persistentFooterButtons: [_buildSaveButton()],
      body: GetBuilder<SfaProductListController>(
        builder: (controller) {
          return ListView.separated(
            itemCount: controller.reportDetails?.items?.length ?? 0,
            itemBuilder: (context, index) {
              return _items(
                controller:controller,
                index:index,
                onDelete:(){
                  Fluttertoast.showToast(msg: '${controller.reportDetails?.items?[index].productName} deleted',backgroundColor: Colors.red);
                  controller.deleteOrderReport(index);
                });
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
        }
      ),
    );
  }

  Card _items({required SfaProductListController controller,required int index,required void Function()? onDelete}) {
    return Card(
      child: SizedBox(
        height: 290,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTFF(
              readOnly: true,
              onTap: () {
                Get.find<SfaProductListController>().searchProducts(unchangableData);
                bottomSheet(context,controller,index);
              },
              hintText: 'Product Name',
              labelText: 'Product Name',
              controller: TextEditingController(text: '${controller.reportDetails!.items![index].productName!} - ${_reportDetails!.items![index].productCode!}'),
            ),
            CustomTFF(
              hintText: 'Selling Price',
              labelText: 'Selling Price',
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: controller.reportDetails!.items![index].price.toString()),
               onChanged: (data){
                if(data!=""){
                  controller.changeSellingPriceInProductOrderReport(index, double.parse(data));
                }
              },
            ),
            // CustomTFF(
            //   hintText: 'Available Quantity',
            //   labelText: 'Available Quantity',
            //   keyboardType: TextInputType.number,
            //   controller: TextEditingController(text: controller.reportDetails!.items![index].availableQty.toString()),
            //    onChanged: (data){
            //     if(data!=""){
            //       controller.changeAvailableQtyInProductOrderReport(index, int.parse(data));
            //     }
            //   },
            // ),
            CustomTFF(
              hintText: 'Ask  Quantity',
              labelText: 'Ask  Quantity',
              controller: TextEditingController(text: controller.reportDetails!.items![index].askQty.toString()),
              keyboardType: TextInputType.number,
              onChanged: (data){
                if(data!=""){
                   controller.changeAskQtyInProductOrderReport(index, int.parse(data));
                }
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Text(
            //     'Total: ${controller.reportDetails!.items![index].price!.toDouble()*controller.reportDetails!.items![index].askQty!.toDouble()}',
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: (){
                    MessageHelper.showInfoAlert(
                      context: context,
                     title: 'Deleting ${controller.reportDetails!.items![index].productName!} - ${_reportDetails!.items![index].productCode!}',
                     desc: 'Are you sure ?',
                     okBtnText: 'Yes',
                     cancelBtnText: 'No',
                    btnCancelOnPress: (){},
                     btnOkOnPress: onDelete,
                     );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.red,
                    ),
                  ),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildSaveButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: TextButton.icon(
        icon: Icon(
          Icons.save,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () async {
          MessageHelper.showInfoAlert(
           context: context,
           title: 'Saving Order #${_reportDetails?.orderNumber}',
           desc: 'Are you sure?',
           okBtnText: 'Yes',
           cancelBtnText: 'No',
           btnCancelOnPress: (){},
           btnOkOnPress: () async{
            var message = await Get.find<SfaProductListController>().editProductOrderReport();

            MessageHelper.showInfoAlert(
              context: context,
             title: message,
             okBtnText: 'Ok',
             btnOkOnPress: () {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await Get.find<SfaProductListController>()
                    .getSfaOrdersReport(dispatchable: 0,type: 'subordinates');
                    Get.back();
                    Get.back();
              });
             }
             );
           }
           );
        },
        style: ElevatedButton.styleFrom(
            elevation: 2, backgroundColor: Colors.green),
        label: Text(
          "Save",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }

  Future<void> bottomSheet(
      BuildContext context, SfaProductListController controller,int index) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
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
                                  return productListNormal(controller, context,index);
                              } else {
                                  return productListNormal(controller, context,index);
                              }
                            }),
                          )
                    : Expanded(
                        child: GetBuilder<SfaProductListController>(
                            builder: (controller) {
                            return productListNormal(controller, context,index);
                        }),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  void _searchItems(String value) {
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
  }

  Widget productListNormal(
      SfaProductListController controller, BuildContext context,int orderIndex) {
    if (controller.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (controller.sfaProductModel!.data!.isEmpty) {
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
            tileColor: Colors.white,
            onTap: () {
              controller.changeProductNameInProductOrderReport(
                orderIndex,
                controller.sfaProductModel!.data![index].id!,
                controller.sfaProductModel!.data![index].name!,
                controller.sfaProductModel!.data![index].code!,
                );
                Get.back();
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
            isThreeLine: true,
          );
        });
  }
}
