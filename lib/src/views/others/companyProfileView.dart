import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/widgets/optionCardTile.dart';

class CompanyProfileView extends StatelessWidget {
  const CompanyProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Detail"),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.find<NavController>().back();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Image.asset(
                  MyAssets.logo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            DescriptionBox(
              desc:
                  "MyPeopler, a complete HRM Software with integrated Payroll, Administrative System. It is engineered with compact systems which allows any organisation to use a single software for their administration activities. MyPeopler is a cloud based HR Software that allows you to keep up-to-date records of your organisation and employees. We are offering high data security and efficient data management with secure cloud system backup.",
            ),
            OptionTileCard(
              title: "abgroup.com.np@gmail.com",
              icon: Icons.email,
              onTap: null,
              hideArrow: true,
            ),
            OptionTileCard(
              title: "+977-9808063542",
              icon: Icons.phone,
              onTap: null,
              hideArrow: true,
            ),
          ],
        ),
      ),
    );
  }
}

// class WhyChooseUs extends StatelessWidget {
//   const WhyChooseUs({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column();
//   }
// }

// class HrmsKeyFeatures extends StatelessWidget {
//   const HrmsKeyFeatures({Key? key}) : super(key: key);
//   static const List<String> keyFeatures = [
//     "Document Management",
//     "Employee Onboarding and Administration",
//     "Time and Attendance Management",
//     "Employee Management",
//     "Onboarding and Recruitment",
//     "Performance Management",
//     "Learning and Professional Development",
//     "Payroll Management",
//     "Detail Reporting and Analysis",
//     "Notice Management"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Text(
//               "HRMS KEY FEATURES",
//               style: TextStyle(
//                 fontSize: 19,
//                 color: HexColor("#3EADEB"),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Divider(
//             thickness: 1.5,
//           ),
//           ...keyFeatures.map(
//             (e) => CheckRowText(text: e),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MajorHighlight extends StatelessWidget {
//   const MajorHighlight({Key? key}) : super(key: key);

//   static const List<String> highlights = [
//     "Track Real Time Employees Attendance",
//     "Generate Payroll in Efficient Way",
//     "Track Organisation Expenses",
//     "Recruit New Employees",
//     "Secured File Management"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Text(
//               "Major Highlights:",
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           ...highlights.map(
//             (e) => CheckRowText(text: e),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CheckRowText extends StatelessWidget {
//   const CheckRowText({Key? key, required this.text, this.desc})
//       : super(key: key);
//   final String text;
//   final String? desc;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: HexColor("#3EADEB"),
//           ),
//           padding: EdgeInsets.all(5),
//           margin: EdgeInsets.all(5),
//           child: Icon(
//             Icons.done,
//             color: Colors.white,
//             size: 12,
//           ),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               text,
//               style:
//                   desc == null ? null : TextStyle(color: HexColor("#3EADEB")),
//             ),
//             Visibility(
//               visible: desc != null,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Text(
//                   desc.toString(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class WhoWeAreBox extends StatelessWidget {
//   const WhoWeAreBox({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             child: Text(
//               "WHO WE ARE",
//               style: TextStyle(
//                 fontSize: 19,
//                 color: HexColor("#3EADEB"),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Text(
//             "A Complete HRM Software",
//             style: TextStyle(
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           DescriptionBox(
//             hPad: 0,
//             vPad: 10,
//             desc:
//                 "MyPeopler, a complete HRM Software with integrated Payroll, Administrative System. It is engineered with compact systems which allows any organisation to use a single software for their administration activities. MyPeopler is a cloud based HR Software that allows you to keep up-to-date records of your organisation and employees. We are offering high data security and efficient data management with secure cloud system backup.",
//           )
//         ],
//       ),
//     );
//   }
// }

// class MyPeoplerFeatures extends StatelessWidget {
//   const MyPeoplerFeatures({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: HexColor("#F1F1F1"),
//       height: 500,
//       padding: EdgeInsets.all(0),
//       child: PageView(
//         children: [
//           ...myPeoplerFeatures.map(
//             (e) => Column(
//               children: [
//                 Container(
//                   color: HexColor("#3EADEB"),
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                   child: Column(
//                     children: [
//                       Icon(
//                         e['icon'],
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         e['name'].toString().toUpperCase(),
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 22,
//                             color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                   child: Image.asset(
//                     e['imgUrl'],
//                   ),
//                 ),
//                 DescriptionBox(
//                   desc: e['description'].toString(),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class DescriptionBox extends StatelessWidget {
  const DescriptionBox(
      {Key? key, required this.desc, this.hPad = 15, this.vPad = 10})
      : super(key: key);
  final String desc;
  final double hPad;
  final double vPad;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: Text(
        desc,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black87,
          height: 1.5,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
