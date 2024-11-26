import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/controllers/customer/customerProductListController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/models/customer/product/customer_product_model.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/customer_views/customerCartView.dart';
import 'package:my_peopler/src/views/customer_views/customerProductCard.dart';
import 'package:my_peopler/src/views/customer_views/customerProductCardRow.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerProductListView extends StatefulWidget {
  const CustomerProductListView({super.key});

  @override
  State<CustomerProductListView> createState() =>
      _CustomerProductListViewState();
}

class _CustomerProductListViewState extends State<CustomerProductListView> {
  TextEditingController? searchController;
  bool isGridView = true;
  List<ProductModel>? _productModel;
  bool enableToolBarHeight = true;
  final refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    _productModel =
        Get.find<CustomerProductListController>().customerProductModel!.data;
  }

  @override
  void dispose() {
   Get.find<CustomerProductListController>().searchProducts(_productModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerProductListController>(builder: (controller) {
      if (controller.isLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return Scaffold(
          appBar: AppBar(
            title: Text('Products List'),
            actions: [
              IconButton(
                  onPressed: () {
                    // Get.find<NavController>().toNamed(
                    //       Routes.CUSTOMER_CART_VIEW,
                    //     );
                    Get.to(() => CustomerCartView());
                  },
                  icon: Badge(
                    label: Text(controller.cartItems.length.toString()),
                    child: Icon(Icons.shopping_cart),
                  ))
            ],
          ),
          body: Column(
            children: [
              CustomTFF(
                  hintText: 'Search',
                  labelText: 'Search',
                  controller: searchController,
                  // onTap: (){Get.to(() => CustomerProductSearchView());}),
                  onChanged: (data) => _searchProducts(data)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isGridView = true;
                              });
                            },
                            icon: Icon(Icons.grid_view_outlined,
                                color: isGridView
                                    ? Colors.blue
                                    : Pallete.primaryCol)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isGridView = false;
                              });
                            },
                            icon: Icon(Icons.list_alt_rounded,
                                color: isGridView
                                    ? Pallete.primaryCol
                                    : Colors.blue))
                      ],
                    ),
                  ],
                ),
              ),
            controller.customerProductModel!.data!.isNotEmpty?  isGridView
                  ? Expanded(
                      child: SmartRefresher(
                      controller: refreshController,
                      onRefresh: () async {
                        controller.getCustomerProductList();
                        refreshController.refreshCompleted();
                      },
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 3 / 3,
                        ),
                        itemCount:
                            controller.customerProductModel!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomerProductCard(
                            onTapAddIcon: () {
                              controller.addProducts(controller
                                  .customerProductModel!.data![index]);
                              Fluttertoast.showToast(
                                  msg:
                                      '${controller.customerProductModel!.data![index].name.toString()} added');
                            },
                            product: Product(
                                controller.customerProductModel!.data![index]
                                        .name ??
                                    '',
                                controller.customerProductModel!.data![index]
                                            .sellingPrice
                                            .toString() ==
                                        'null'
                                    ? controller.customerProductModel!
                                        .data![index].price
                                        .toString()
                                    : controller.customerProductModel!
                                        .data![index].sellingPrice
                                        .toString(),
                                ''),
                          );
                        },
                      ),
                    ))
                  : Expanded(
                      child: SmartRefresher(
                      controller: refreshController,
                      onRefresh: () async {
                        controller.getCustomerProductList();
                        refreshController.refreshCompleted();
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              controller.customerProductModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomerProductCardRow(
                              onTapAddIcon: () {
                                controller.addProducts(controller
                                    .customerProductModel!.data![index]);
                                Fluttertoast.showToast(
                                    msg:
                                        '${controller.customerProductModel!.data![index].name.toString()} added');
                              },
                              product: Product(
                                  controller.customerProductModel!.data![index]
                                          .name ??
                                      '',
                                  controller.customerProductModel!.data![index]
                                              .sellingPrice
                                              .toString() ==
                                          'null'
                                      ? controller.customerProductModel!
                                          .data![index].price
                                          .toString()
                                      : controller.customerProductModel!
                                          .data![index].sellingPrice
                                          .toString(),
                                  ''),
                            );
                          },
                        ),
                      ),
                    ):NoDataWidget(),
              enableToolBarHeight
                  ? SizedBox(
                      height: kToolbarHeight + 10,
                    )
                  : SizedBox.shrink()
            ],
          ));
    });
  }

  _searchProducts(String searchTerm) {
    if (searchTerm == "") {
      Get.find<CustomerProductListController>().searchProducts(_productModel);
      enableToolBarHeight = true;
    } else {
      enableToolBarHeight = false;
      List<ProductModel>? result = _productModel!.where((products) {
        String name = products.name!.toLowerCase();
        String price = products.sellingPrice!.toString();
        final searchItem = searchTerm.toLowerCase();
        return name.contains(searchItem) || price.contains(searchItem);
      }).toList();
      Get.find<CustomerProductListController>().searchProducts(result);
    }
  }
}
