import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/marketing_scheme/presentation/market_scheme_customers.dart';

class NewPriceDetail extends StatefulWidget {
  const NewPriceDetail({super.key});

  @override
  State<NewPriceDetail> createState() => _NewPriceDetailState();
}

class _NewPriceDetailState extends State<NewPriceDetail> {
  final items = Get.arguments[0];
  final title = Get.arguments[1];
  final customers = Get.arguments[2];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true,),
      body: Column(
        children: [
         GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder:(context) => MarketSchemeCustomers(customers: customers,)));
                },
                child: SizedBox(
                  height: 100,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                        widthFactor: 3,
                        child: Text('Customers', style: TextStyle(fontSize: 18),)),
                        CircleAvatar(child: Icon(Icons.arrow_forward_rounded)),
                      ],
                    ),
                  ),
                ),
              ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder:(context, index) {
                    var item = items[index];
                    var priceType = item.type;
                    return SizedBox(
                      height: 150,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Name: ${item.name}',style: TextStyle(fontSize: 14),),
                              Text('Regular Price: ${item.regularPrice ?? 0}',style: TextStyle(fontSize: 14),),
                              priceType == 'flat_qty'?
                              Text('${item.amount.replaceAll("{", '').replaceAll("}", '').replaceAll(",", '\n').replaceAll('"sale_qty":', 'Sale Quantity: ').
                              replaceAll('"bonus_qty":', 'Bonus Quantity: ')}',
                              style: TextStyle(fontSize: 14),):
                              Text('New Price: ${item.amount}',style: TextStyle(fontSize: 14),),
                              amountType(priceType)
                            ],
                          ),
                        ),
                      ),
                    );
                  }, 
                  separatorBuilder:(context, index) => SizedBox(height: 10,),
                  itemCount: items.length),
          ),
        ],
      )
    );
  }
         amountType (dynamic priceType) {
                switch(priceType) {
                case 'flat_amount':
                return Text('Type: Flat Amount',style: TextStyle(fontSize: 14),);
                case 'flat_qty':
                return Text('Type: Flat Quantity',style: TextStyle(fontSize: 14),);
              }
  }
}