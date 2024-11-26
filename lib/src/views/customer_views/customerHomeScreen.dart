import 'package:flutter/material.dart';
import 'package:my_peopler/src/resources/color_manager.dart';


class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: IconButton(icon: Icon(Icons.menu),onPressed: (){},color: ColorManager.primaryCol),
          backgroundColor: Colors.transparent,
          elevation: 0,
         
          actions: [
            IconButton(
              onPressed: (){
              
          }, icon: Icon(Icons.notifications_outlined,color: ColorManager.primaryCol,))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome,',style: TextStyle(fontSize: 16,color: ColorManager.grey),),
              Text('Denny Brown',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
            ],
          ),
        )),
    );
  }
}