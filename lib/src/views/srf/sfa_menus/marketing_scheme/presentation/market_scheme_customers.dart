import 'package:flutter/material.dart';

class MarketSchemeCustomers extends StatefulWidget {
  final dynamic customers;
  const MarketSchemeCustomers({super.key, required this.customers});

  @override
  State<MarketSchemeCustomers> createState() => _MarketSchemeCustomersState();
}

class _MarketSchemeCustomersState extends State<MarketSchemeCustomers> {
  @override
  Widget build(BuildContext context) {
    var customers = widget.customers;
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Scheme Customers'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(itemBuilder:(context, index) {
          var customerName = customers[index].name;
          return SizedBox(
            height: 80,
            child: Card(
              child: Center(child: Text(customerName,style: TextStyle(fontSize: 14),),),
            ),
          );
        }, 
        separatorBuilder:(context, index) => SizedBox(height: 10,),
        itemCount: customers.length),
      ),
    );
  }
}