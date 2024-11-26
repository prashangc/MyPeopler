import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/views/payroll/salaryListPage.dart';
import 'package:my_peopler/src/views/payroll/salaryStructurePage.dart';
import 'package:my_peopler/src/widgets/myDrawer.dart';

class PayrollView extends StatefulWidget {
  const PayrollView({Key? key}) : super(key: key);

  @override
  State<PayrollView> createState() => _PayrollViewState();
}

class _PayrollViewState extends State<PayrollView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Get.find<PayrollController>().refreshPayroll();
     });
     
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Pallete.primaryCol,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
              ),
            );
          }
        ),
        title: Text("Payroll"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "Salary Structure",
            ),
            Tab(
              text: "Salary List",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SalaryStructurePage(),
          SalaryListPage(),
        ],
      ),
    );
  }
}
