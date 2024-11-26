import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_peopler/src/controllers/expenseController.dart';
import 'package:my_peopler/src/controllers/profileController.dart';
import 'package:my_peopler/src/helpers/imageHelper.dart';
import 'package:my_peopler/src/repository/expense/expenseRepository.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../../helpers/helpers.dart';
import '../../widgets/widgets.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  
  TextEditingController? amountController = TextEditingController();
  TextEditingController? methodController = TextEditingController();
  TextEditingController? categoryController = TextEditingController();
  TextEditingController? notesController = TextEditingController();
  TextEditingController? fromController = TextEditingController();
  TextEditingController? toController = TextEditingController();
  TextEditingController? modeController = TextEditingController();
  TextEditingController? kmController = TextEditingController();

  bool isTravelling = false;
  NepaliDateTime? selectedDateH;
  late ImagePicker _picker;
  File? avatar;
  String? imageName;
  int? categoryId;
  @override
  void initState() {
    _picker = ImagePicker();
    Get.find<ProfileController>().getProfile();
    super.initState();
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }
  
  int? getUserData() {
    var controller = Get.put(ProfileController());
    return controller.user?.id;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expenses'),
      ),
      body: GetBuilder<ExpenseController>(
        builder: (controller) {
          if(controller.isLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //   child: CustomDFF(
                  //     name: 'Category',
                  //     items: [
                  //     ...controller.expenseCategories.map(
                  //       (e) {
                  //         return DropdownMenuItem(
                  //           value: e!.id.toString(),
                  //           child: Text(e.name??""),
                  //         );
                  //       },
                  //     )
                  //   ],
                  //     onChanged: (a) {
                  //       categoryId = int.parse(a!);
                  //       log(categoryId.toString());
                  //     },
                  //     value: null,
                  //   ),
                  // ),
                    CustomTFF(
                      labelText: 'Category',
                      hintText: 'Category',
                      controller: categoryController,
                      readOnly: true,
                      onTap: (){
                      showCategory(context,controller);
                      },
                      ),
                  CustomTFF(
                      labelText: 'Amount',
                      hintText: 'Amount',
                      controller: amountController,
                      keyboardType: TextInputType.number),
                 !isTravelling?  CustomTFF(
                    labelText: 'Description',
                    hintText: 'Description',
                    controller: notesController,
                  ): Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    CustomTFF(
                    labelText: 'From',
                    hintText: 'From',
                    controller: fromController,
                  ),
                  CustomTFF(
                    labelText: 'To',
                    hintText: 'To',
                    controller: toController,
                  ),
                  CustomTFF(
                    labelText: 'Mode',
                    hintText: 'Mode',
                    controller: modeController,
                  ),
                  CustomTFF(
                    labelText: 'KM',
                    hintText: 'KM',
                    controller: kmController,
                  )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 14.0, left: 16, right: 16.0, bottom: 14.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: DateButton(
                        label: 'Select Date',
                        onTap: () async {
                          var selectedNepaliDate = await DateHelper.pickNepaliDate(context);
                          log("Selected Date: $selectedNepaliDate");
                          setState(() {
                            selectedDateH = selectedNepaliDate;
                          });
                        },
                        date: selectedDateH,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 14.0, left: 14, right: 14.0, bottom: 14.0),
                    child: Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: ColorManager.textFeildColor,
                          border: Border.all(color: ColorManager.primaryCol),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            avatar != null
                                ? Image.file(
                                    avatar!,
                                    fit: BoxFit.contain,
                                    width: 50,
                                    height: 40,
                                  )
                                : Icon(
                                    Icons.attach_file,
                                    size: 20,
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Text(
                              imageName ?? 'Attach Image',
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                        onTap: () async {
                          await pickImage(context);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 14.0, left: 14, right: 14.0, bottom: 14.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        child:
                            ElevatedButton(onPressed: () {
                              var travellingDescription = 'From: ${fromController!.text}, To: ${toController!.text}, Mode: ${modeController!.text}, KM: ${kmController!.text}';
                              if(categoryController?.text != 'Travelling') {
                                 if(categoryId == null || amountController!.text == '' || notesController!.text == '' || selectedDateH == null){
                                Fluttertoast.showToast(msg: 'All feilds are required',backgroundColor: Colors.red);
                              }else{
                                controller.postExpenses(Expenses(categoryId.toString(), amountController!.text, notesController!.text, selectedDateH.toString(), avatar));
                                MessageHelper.showSuccessAlert(context: context, title: 'Success',desc: 'Expense Added',
                                btnOkOnPress: (){
                                  controller.getExpenses(employeeId: getUserData(), type: 'own');
                                  Get.back();
                                }
                                );
                              }
                              } else {
                                 if(categoryId == null || amountController!.text == '' || fromController!.text == '' || toController!.text == '' || modeController!.text == '' ||
                                 kmController!.text == '' || selectedDateH == null){
                                Fluttertoast.showToast(msg: 'All feilds are required',backgroundColor: Colors.red);
                              }else{
                                controller.postExpenses(Expenses(categoryId.toString(), amountController!.text, travellingDescription, selectedDateH.toString(), avatar));
                                MessageHelper.showSuccessAlert(context: context, title: 'Success',desc: 'Expense Added',
                                btnOkOnPress: (){
                                  controller.getExpenses(employeeId: getUserData(), type: 'own');
                                  Get.back();
                                }
                                );
                              }
                              }
                            }, child: Text('Submit'))),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

      Future<void> showCategory(
      BuildContext context,ExpenseController controller) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      
      builder: (BuildContext context) {
        return SizedBox(
                  height: MediaQuery.of(context).size.height/2.2,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Divider(thickness: 2,);
                    },
                    itemCount: controller.expenseCategories.length,
                    itemBuilder: (context,index){
                      var categoryName = controller.expenseCategories[index]!.name;
                      return ListTile(
                        title: Text(controller.expenseCategories[index]!.name.toString()),
                        onTap: (){
                          categoryController?.text = controller.expenseCategories[index]!.name.toString();
                          categoryId  = controller.expenseCategories[index]!.id;
                         categoryName == 'Travelling'? setValue(true) : setValue(false);
                          Get.back();
                        },
                        );
                    },),
        );
          }
        );}

     setValue(bool setValue) {
      setState(() {
        isTravelling = setValue;
      });
     }

  pickImage(
    BuildContext context,
  ) async {
    try {
      var isCamera = await ImageHelper.chooseSource(context);
      if (isCamera == null) {
        return;
      }
      ImageSource source = isCamera ? ImageSource.camera : ImageSource.gallery;
      final result = await _picker.pickImage(source: source);
      if (result != null) {
        final permanentImage = await saveImagePermanently(result.path);
        setState(() {
          avatar = permanentImage;
          log(avatar!.path.toString());
          imageName = avatar!.path.toString().split('/').last;
          log(imageName.toString());
        });
      } else {
        return;
      }
    } catch (e) {
      MessageHelper.showInfoAlert(
          context: context, title: "Something went wrong. Please try again");
    }
  }
}
