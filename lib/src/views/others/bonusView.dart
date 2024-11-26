import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/widgets/customTable.dart';
import 'package:my_peopler/src/widgets/myDrawer.dart';

class BonusView extends StatelessWidget {
  const BonusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
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
          },
        ),
        title: Text("Bonus"),
        automaticallyImplyLeading: false,
      ),
      body: CustomTable(
        columnWidths: null,
        onRefresh: () async {
        await Future.delayed(2.seconds);
        
      },
        headings: [
          "S.N.","Bonus Name","Month","Amount","Date Added"
        ],
        rowDatas: [
          ["1","Public Leave","December 2022","1000000","2022-02-03"],
          ["2","Medical","December 2022","4000000","2022-02-03"],
          ["3","Dress","November 2022","5000000","2022-02-03"],
          ["4","Dashain","October 2022","6000000","2022-02-03"],
        ],
      ),
    );
  }
}

