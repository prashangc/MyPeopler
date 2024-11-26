import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_order_report.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class ProductOrderReportAddItemView extends StatefulWidget {
  const ProductOrderReportAddItemView({super.key});

  @override
  State<ProductOrderReportAddItemView> createState() => _ProductOrderReportAddItemViewState();
}

class _ProductOrderReportAddItemViewState extends State<ProductOrderReportAddItemView> {
  TextEditingController _productName = TextEditingController();
  TextEditingController _sellingPrice = TextEditingController();
  TextEditingController _availableQty = TextEditingController();
  TextEditingController _askQty = TextEditingController();

  String? orderId;
  int? productId;
  String? productName;
  String? productCode;
  List<SfaProduct>? unchangableData;
  List<SfaProduct>? _initialProducts;
  @override
  void initState() {
    orderId = Get.arguments;
    getData();
    super.initState();
  }

  getData() async{
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
        title: Text('Add Items for Order #$orderId'),
      ),
      body: GetBuilder<SfaProductListController>(
        builder: (controller) {
          return Column(
            children: [
              CustomTFF(
                  readOnly: true,
                  onTap: () {
                    Get.find<SfaProductListController>().searchProducts(unchangableData);
                    bottomSheet(context,controller);
                  },
                  hintText: 'Product Name',
                  labelText: 'Product Name',
                  controller: _productName),
                
                CustomTFF(
                  hintText: 'Selling Price',
                  labelText: 'Selling Price',
                  keyboardType: TextInputType.number,
                  controller: _sellingPrice,
                   onChanged: (data){
                    if(data!=""){
                      //controller.changeSellingPriceInProductOrderReport(index, double.parse(data));
                    }
                  },
                ),
                // CustomTFF(
                //   hintText: 'Available Quantity',
                //   labelText: 'Available Quantity',
                //   keyboardType: TextInputType.number,
                //   controller: _availableQty,
                //    onChanged: (data){
                //     if(data!=""){
                //       //controller.changeAvailableQtyInProductOrderReport(index, int.parse(data));
                //     }
                //   },
                // ),
                CustomTFF(
                  hintText: 'Ask  Quantity',
                  labelText: 'Ask  Quantity',
                  controller: _askQty,
                  keyboardType: TextInputType.number,
                  onChanged: (data){
                    if(data!=""){
                       //controller.changeAskQtyInProductOrderReport(index, int.parse(data));
                    }
                  },
                ),
                SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:14.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton.icon(
                     onPressed: (){
                      if(_productName.text == '' || _sellingPrice.text ==  ''  || _askQty.text == ''){
                        MessageHelper.errorDialog(
                          context: context, 
                          errorMessage: 'Enter all fields',
                          btnOkOnPress: (){},
                          btnOkText: 'Ok'
                        );
                      }else{
                        controller.addOrderItem(
                          ProductOrderReportItem(
                            id: null,
                            productId: productId,
                            productName: productName,
                            productCode: productCode,
                            availableQty: 0,
                            askQty: int.parse(_askQty.text),
                            price: double.parse(_sellingPrice.text)
                          )
                        );
                       
                        Fluttertoast.showToast(msg: '$productName',backgroundColor: Colors.green);
                        Get.back();
                      }
                     },
                     icon: Icon(Icons.add), 
                     label: Text('Add',style: TextStyle(fontSize: 20),)),
                  ),
                )
            ],
          );
        }
      ),
    );
  }

  Future<void> bottomSheet(
      BuildContext context, SfaProductListController controller) {
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
                                  return productListNormal(controller, context);
                              } else {
                                  return productListNormal(controller, context);
                              }
                            }),
                          )
                    : Expanded(
                        child: GetBuilder<SfaProductListController>(
                            builder: (controller) {
                            return productListNormal(controller, context);
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
      SfaProductListController controller, BuildContext context,) {
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
              _productName.text = '${controller.sfaProductModel!.data![index].name} - ${controller.sfaProductModel!.data![index].code}';
              _sellingPrice.text = controller.sfaProductModel!.data![index].sellingPrice.toString();
              productId = controller.sfaProductModel!.data![index].id;
              productName = controller.sfaProductModel!.data![index].name;
              productCode = controller.sfaProductModel!.data![index].code;
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
}