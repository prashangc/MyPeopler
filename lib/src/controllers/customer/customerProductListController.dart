import 'package:get/get.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/models/customer/order_history/customer_order_history_model.dart';
import 'package:my_peopler/src/models/customer/product/customer_product_model.dart';
import 'package:my_peopler/src/repository/customer/customerProductRespository.dart';

class CustomerProductListController extends GetxController{
  final CustomerProductListRepository _customerProductListRepository =
      getIt<CustomerProductListRepository>();
  CustomerProductModel? customerProductModel;
  CustomerOrderHistoryModel? customerOrderHistoryModel; 
  bool isLoading = true;
  List<ProductModel> cartItems = [];
  double total = 0.0;
  @override
  void onInit() async {
    await getCustomerProductList();
    await getCustomerOrderHistory();
    super.onInit();
  }

  getCustomerProductList() async {
     isLoading = true;
     customerProductModel = await _customerProductListRepository.getCustomerProductList();
     isLoading = false;
     update();
  }

  postCustomerProductList() async{
      isLoading = true;
      var data = await _customerProductListRepository.postCustomerProductList(cartItems);
      isLoading = false;
      getCustomerOrderHistory();
      return data;
  }

  getCustomerOrderHistory() async{
    isLoading = true;
    customerOrderHistoryModel = await _customerProductListRepository.getCustomerOrderHistory();
    isLoading = false;
    update();
  }


  
  void addProducts(ProductModel item){
    bool isOldValue = false;
    cartItems.forEach((e) {
      if(e.name == item.name){
        isOldValue = true;
        e.increment();
      }
    });

    if(isOldValue == false){
      cartItems.add(item);
    }
      
    getOverAllTotal();
     update();
  }

  void removeProducts(int index){
    cartItems.removeAt(index);
    getOverAllTotal();
    update();
  }

  void increaseQuantity(ProductModel item){
    int itemIndex = cartItems.indexOf(item);
    cartItems[itemIndex].increment();
    getOverAllTotal();
     update();
  }

  void decreaseQuantity(ProductModel item){
     int itemIndex = cartItems.indexOf(item);
    cartItems[itemIndex].decrement();
    if(cartItems[itemIndex].quantity == 0 ){
      removeProducts(itemIndex);
    }
    getOverAllTotal();
    update();
  }

  void getOverAllTotal(){
    total = 0.0;
    for (var e in cartItems) {
      total = total+e.total;
    }
  }

  void clearCart(){
    cartItems.clear();
    update();
  }

  void searchProducts(List<ProductModel>? result){
    customerProductModel = CustomerProductModel(data: result);
    update();
  }

  
}