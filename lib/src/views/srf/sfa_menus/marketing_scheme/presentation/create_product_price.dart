import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/views/srf/srfView.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class CreateProductPrice extends StatefulWidget {
  const CreateProductPrice({super.key});

  @override
  State<CreateProductPrice> createState() => _CreateProductPriceState();
}

class _CreateProductPriceState extends State<CreateProductPrice> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  NepaliDateTime? startDate;
  NepaliDateTime? endDate;
  List<ListedProduct> addProducts = [];
  List<SfaProduct>? unchangableData;
  TextEditingController titleController = TextEditingController();
  var amountTypes = [
    {'Flat Amount': 'flat_amount'},
    {'Flat Quantity': 'flat_qty'}
  ];
  final customerId = Get.arguments[0];
  final clientTypeName = Get.arguments[1];
  late String newPrice;
  SfaCustomerList? _unchangablesfaCustomerList;
  final List<SfaCustomerListModel> _selectedCustomerList = [];
  
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Get.find<SfaProductListController>().getSfaProductList('');
    unchangableData =
        Get.find<SfaProductListController>().sfaProductModel?.data;
    _unchangablesfaCustomerList = await Get.find<SfaCustomerListController>()
        .getSfaCustomerList('all', customer_id: customerId, marketScheme: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create Product Price'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(children: [
            DateRangeButton(
              isNepaliDate: true,
              nepaliDateFrom: startDate,
              nepaliDateTo: endDate,
              width: 1,
              label: "From Date     -      To Date",
              onTap: () async {
                NepaliDateTimeRange? date = await showMaterialDateRangePicker(
                  context: context,
                  firstDate: NepaliDateTime(1970),
                  lastDate: NepaliDateTime(2250),
                );
                if (date != null) {
                  setStartDate(date.start);
                  setEndDate(date.end);
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is Empty';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Marketing Scheme Title',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 30, horizontal: 10)),
            ),
            SizedBox(
              height: 30,
            ),
            addProducts.isEmpty
                ? Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'No Products Added',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
                : Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.creamColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                          children: List.generate(addProducts.length, (index) {
                        var product = addProducts[index];
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorManager.creamColor2,
                                borderRadius: BorderRadius.circular(12)),
                            width: 400,
                            child: ListTile(
                                title: Text(
                                    '${product.name.toString()} ( Rs.${product.sellingPrice.toString()} )'),
                                subtitle: product.hasQuantity
                                    ? Text(
                                        'Sale Quantity : ${product.salesQuantity}\nProduct Quantity : ${product.bonusQuantity}')
                                    : null,
                                onTap: () {
                                  _modalBottomSheet(product);
                                },
                                trailing: Wrap(children: [
                                  Icon(Icons.edit),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Fluttertoast.showToast(
                                          msg: '${product.name} removed',
                                          backgroundColor: Colors.red);
                                      setState(() {
                                        addProducts.removeAt(index);
                                      });
                                    },
                                    child: Icon(Icons.close),
                                  ),
                                ])),
                          ),
                        );
                      })),
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton.icon(
                onPressed: () {
                  showProductList(context);
                },
                icon: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircleAvatar(
                      backgroundColor: ColorManager.white,
                      child: Icon(
                        Icons.add_outlined,
                        color: ColorManager.primaryCol,
                      )),
                ),
                label: Text(
                  'Add Product',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ButtonStyle(
                    elevation: WidgetStateProperty.all(2),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        WidgetStateProperty.all(ColorManager.primaryCol)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showAssignedCustomer(context);
              },
              style: ButtonStyle(
                  fixedSize:
                      WidgetStatePropertyAll(Size(double.maxFinite, 50))),
              child: Text(
                'Choose Customer',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GetBuilder<SfaProductListController>(builder: (controller) {
              return SubmitButton(
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      List<ProductItem> items = [];
                      for (var i = 0; i < addProducts.length; i++) {
                        var product = addProducts[i];

                        items.add(ProductItem(
                            productCategoryID: null,
                            productID: product.id,
                            amount: product.hasQuantity
                                ? null
                                : product.sellingPrice,
                            type: product.type ?? 'flat_amount',
                            saleQty: product.hasQuantity
                                ? product.salesQuantity
                                : null,
                            bonusQty: product.hasQuantity
                                ? product.bonusQuantity
                                : null));
                      }
                      var res = await controller.postSfaMarketScheme(
                          titleController.text,
                          startDate!,
                          endDate!,
                          items,
                          _selectedCustomerList);

                      Fluttertoast.showToast(
                          msg: res, backgroundColor: Colors.green);
                      controller.getSfaMarketScheme(customerId);
                      Get.back();
                    }
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: 'Something went wrong!',
                        backgroundColor: Colors.red);
                  }
                },
                label: 'Submit',
                // isLoading: controller.isLoading,
              );
            }),
            // Spacer()
          ]),
        ),
      ),
    );
  }

  setStartDate(NepaliDateTime val) {
    setState(() {
      startDate = val;
    });
  }

  setEndDate(NepaliDateTime val) {
    setState(() {
      endDate = val;
    });
  }

  _modalBottomSheet(ListedProduct product) {
    var entry = product.hasQuantity ? 'flat_qty' : 'flat_amount';
    String priceValue = product.sellingPrice.toString();
    String saleQty = product.salesQuantity != null? product.salesQuantity.toString() : '';
    String bonusQty= product.bonusQuantity != null? product.bonusQuantity.toString() : '';
    TextEditingController priceController = TextEditingController(text: priceValue);
    TextEditingController saleQuantityController = TextEditingController(text: saleQty);
    TextEditingController bonusQuantityController = TextEditingController(text: bonusQty);
    bool isQuantity = product.hasQuantity;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Form(
                    key: _formKey2,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.close))),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                              child: Text(
                            product.name ?? "",
                            style: TextStyle(fontSize: 18),
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select Type:',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            value: entry,
                            items: amountTypes
                                .map((e) => DropdownMenuItem(
                                    value: e.values.first,
                                    child: Text(e.keys.first)))
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                entry = newValue!;
                                isQuantity = entry == 'flat_qty';
                              });
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          isQuantity
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sale Quantity:',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: saleQuantityController,
                                          decoration: InputDecoration(),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some value!';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Bonus Quantity:',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: bonusQuantityController,
                                          decoration: InputDecoration(),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some value!';
                                            }
                                            return null;
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                )
                              : amountField(priceController),
                          SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey2.currentState!.validate()) {
                                Navigator.of(context).pop();
                                int? price = int.tryParse(priceController.text);
                                product.sellingPrice = price;
                                product.hasQuantity = isQuantity;
                                product.type = entry;
                                if (isQuantity) {
                                  product.bonusQuantity =
                                      int.parse(bonusQuantityController.text);
                                  product.salesQuantity =
                                      int.parse(saleQuantityController.text);
                                }
                              }
                            },
                            style: ButtonStyle(
                                minimumSize:
                                    WidgetStateProperty.all(Size(340, 45))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.update),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Confirm',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                  ),
                ),
              );
            },
          );
        });
  }

  Column amountField(TextEditingController priceController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount: ',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          textAlign: TextAlign.center,
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration:
              InputDecoration(fillColor: Colors.indigo.shade50, filled: true),
        ),
      ],
    );
  }

  Future<void> showProductList(BuildContext context) {
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
                          ],
                        ),
                        CustomTFF(
                            hintText: 'Search Products',
                            onChanged: (value) => _searchItems(value)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<SfaProductListController>(
                        builder: (controller) {
                      return productListNormal(controller, context);
                    }),
                  ),
                ]),
          ),
        );
      },
    );
  }

  void addProductsMethod(SfaProduct e, bool hasQuantity) {
    var previousItem =
        addProducts.firstWhereOrNull((element) => element.id == e.id);
    if (previousItem != null) {
      Fluttertoast.showToast(
          msg: '${e.name} is already added', backgroundColor: Colors.red);
    } else {
      ListedProduct item = ListedProduct(
          id: e.id,
          name: e.name,
          sellingPrice: e.sellingPrice,
          hasQuantity: hasQuantity);
      addProducts.add(item);
    }

    Get.back();
    setState(() {});
  }

  Widget productListNormal(
      SfaProductListController controller, BuildContext context) {
    if (controller.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      var productList = controller.sfaProductModel!.data ?? [];
      if (productList.isEmpty) {
        return Center(
            child: Text(
          'No data found.',
          style: Theme.of(context).textTheme.displayLarge,
        ));
      } else {
        return ListView.separated(
            itemCount: productList.length,
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
              var product = productList[index];
              return ListTile(
                onTap: () {
                  addProductsMethod(product, false);
                },
                title: Text(product.name ?? ''),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.code ?? ''),
                    Text(product.description ?? ''),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('MRP : Rs. ${product.price.toString()}'),
                    Text(
                        'Selling Price : Rs. ${product.sellingPrice.toString()}'),
                  ],
                ),
                isThreeLine: true,
              );
            });
      }
    }
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

  Future<void> showAssignedCustomer(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        useSafeArea: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => SafeArea(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height - 40,
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Choose Customer',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: _selectedCustomerList.isEmpty
                                    ? Icon(
                                        Icons.close,
                                        color: ColorManager.red,
                                      )
                                    : Icon(
                                        Icons.check,
                                        size: 30,
                                        color: Colors.green,
                                      )),
                          ],
                        ),
                        CustomTFF(
                            hintText: 'Search Customer',
                            onChanged: (data) => filterBySearchTerm(
                                data, _unchangablesfaCustomerList)),
                      ]),
                      Expanded(child: GetBuilder<SfaCustomerListController>(
                          builder: (controller) {
                        if (controller.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (controller
                            .sfaCustomerListAll.clientLists.isEmpty) {
                          return Center(
                              child: SizedBox(
                            height: 370,
                            width: MediaQuery.of(context).size.width,
                            child: NoDataWidget(),
                          ));
                        }
                        return ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: controller
                                .sfaCustomerListAll.clientLists.entries
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
                                            selected: _selectedCustomerList
                                                .contains(e),
                                            selectedTileColor: Colors.red,
                                            onTap: () {
                                              setState(() {
                                                _selectedCustomerList
                                                        .contains(e)
                                                    ? _selectedCustomerList
                                                        .remove(e)
                                                    : _selectedCustomerList
                                                        .add(e);
                                              });
                                            },
                                            title: Text(
                                              e.name,
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
                                                Text(e.contact),
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
                      }))
                    ]))),
          );
        });
  }
}

class ListedProduct {
  final int? id;
  String? name;
  int? sellingPrice;
  bool hasQuantity;
  String? type;

  // Only if hasQuantity is true
  int? bonusQuantity;
  int? salesQuantity;

  ListedProduct(
      {this.id,
      this.name,
      this.sellingPrice,
      this.type,
      required this.hasQuantity,
      this.bonusQuantity,
      this.salesQuantity});
}
