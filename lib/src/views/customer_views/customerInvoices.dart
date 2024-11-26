import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_peopler/src/views/customer_views/invoiceDetailScreen.dart';
import 'package:my_peopler/src/views/customer_views/invoiceListTile.dart';

class CustomerInvoices extends StatefulWidget {
  const CustomerInvoices({super.key});

  @override
  State<CustomerInvoices> createState() => _CustomerInvoicesState();
}

class _CustomerInvoicesState extends State<CustomerInvoices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Invoices'),),
      body: ListView.builder(
        itemCount: 10,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InvoiceListTile();
        },
      )
    );
  }
}