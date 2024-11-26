import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class EditAskOrderView extends StatefulWidget {
  const EditAskOrderView({super.key});

  @override
  State<EditAskOrderView> createState() => _EditAskOrderViewState();
}

class _EditAskOrderViewState extends State<EditAskOrderView> {
  TextEditingController? codeController = TextEditingController();

  TextEditingController? productController = TextEditingController();

  TextEditingController? mrpController = TextEditingController();

  TextEditingController? spController = TextEditingController();

  TextEditingController? availQController = TextEditingController();

    TextEditingController? askQController = TextEditingController();
    int? index;
SfaProduct? product;
bool? isEdit;
    @override
  void initState() {
    var args = Get.arguments as List;
    product = args[1];
    index = args[0];
    isEdit = args[2];
    codeController = TextEditingController(text: product?.code ?? '');
    productController = TextEditingController(text: product?.name ?? '');
    mrpController = TextEditingController(text: product?.price.toString() ?? '');
    spController = TextEditingController(text: product?.sellingPrice.toString() ?? '' );
    availQController = TextEditingController(text: product?.availableQuantity.toString() ?? '');
    askQController = TextEditingController(text: product?.askQuantity.toString() ?? '');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Fields'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTFF(labelText: 'Code',readOnly: true,controller: codeController,),
            CustomTFF(labelText: 'Product',readOnly: true,controller: productController,),
            CustomTFF(labelText: 'MRP',readOnly: true,controller: mrpController,),
            CustomTFF(labelText: 'Selling Price (S.P)',controller: spController,keyboardType: TextInputType.number,),
          //  CustomTFF(labelText: 'Available Quantity',controller: availQController,keyboardType: TextInputType.number,),
            CustomTFF(labelText: 'Ask Quantity',controller: askQController,keyboardType: TextInputType.number,),
      
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(onPressed: (){
                  // MessageHelper.showSuccessAlert(
                  //   context: context, title: 'Success',desc: 'Successfully Saved',btnOkOnPress: (){
                          Get.find<SfaProductListController>().addProducts(
                  SfaProduct(
                    id: product!.id,
                          code: codeController?.text,
                          name: productController?.text,
                          price: num.parse(mrpController?.text ?? '0'),
                          sellingPrice: num.parse(spController?.text ?? '0'),
                          availableQuantity: num.parse(availQController?.text ?? '0'),
                          askQuantity: num.parse(askQController?.text ?? ''),
                          isSelected: true
                        ),
              );
              Fluttertoast.showToast(
                  msg: '${productController?.text} added',
                  backgroundColor: Colors.green);
                  if(isEdit == true){
                    Get.find<SfaProductListController>().editProduct(
                        index!, 
                        SfaProduct(
                          id: product!.id,
                          code: codeController?.text,
                          name: productController?.text,
                          price: num.parse(mrpController?.text ?? '0'),
                          sellingPrice: num.parse(spController?.text ?? '0'),
                          availableQuantity: num.parse(availQController?.text ?? '0'),
                          askQuantity: num.parse(askQController?.text ?? '')
                        ));
                  }
                      
                      Get.back();
                  //});
                }, child: Text('SAVE')),
              ),
            )
          ],
        ),
      ),
    );
  }
}