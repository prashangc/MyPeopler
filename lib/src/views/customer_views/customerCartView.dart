import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/customer/customerProductListController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/views/customer_views/customerCartItemTile.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class CustomerCartView extends StatefulWidget {
  const CustomerCartView({super.key});

  @override
  State<CustomerCartView> createState() => _CustomerCartViewState();
}

class _CustomerCartViewState extends State<CustomerCartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: GetBuilder<CustomerProductListController>(
        builder: (controller) {
          if(controller.cartItems.isEmpty){
            return NoDataWidget();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.cartItems.length,
                    itemBuilder: (_, i) {
                      return CustomerCartItemTile(
                        key: Key(i.toString()),
                        imageUrl: MyAssets.sfa,
                        name: controller.cartItems[i].name.toString(),
                        price: controller.cartItems[i].sellingPrice?.toDouble() ?? controller.cartItems[i].price!.toDouble(),
                        quantity: controller.cartItems[i].quantity,
                        deleteFromCart: () {
                          controller.removeProducts(i);
                        },
                        increment: () {
                          controller.increaseQuantity(controller.cartItems[i]);
                        },
                        decrement: () {
                          controller.decreaseQuantity(controller.cartItems[i]);
                        },
                      );
                    },
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,),
                child: Text('Total: ${controller.total}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              SubmitButton(
                onPressed: () async{
                var data = await controller.postCustomerProductList();
                MessageHelper.showSuccessAlert(context: context, title: data,btnOkOnPress: (){
                  Get.back();
                  controller.clearCart();
                },);
                }, 
                label: 'Place Order'),
                // SizedBox(height: kToolbarHeight+20,)
            ],
          );
        }
      ),
    );
  }
}