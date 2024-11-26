import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/helpers/imageHelper.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/profileTFF.dart';
import 'package:my_peopler/src/widgets/splashWidget.dart';
import 'package:my_peopler/src/widgets/submitButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  String? profilePhoto;

  File? avatar;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  late ImagePicker _picker;

  @override
  void initState() {
    setInitialValue();
    _picker = ImagePicker();
    super.initState();
  }

  setInitialValue() {
    var user = Get.find<ProfileController>().user;
    _name.text = user?.name ?? "";
    _email.text = user?.email ?? "";
    _contact.text = user?.contact_no_one ?? "";
    if(user?.present_address != null){
      _address.text = (user?.present_address is String?  user?.present_address: '${user!.permanent_address?['province']}${user.permanent_address?['district']}${user.permanent_address?['local_body']}${user.permanent_address?['tole']}${user.permanent_address?['ward']}')!;
    }else{
        _address.text = "";
    }
    _dob.text = user?.date_of_birth != null
        ? MyDateUtils.getDateOnly(user!.date_of_birth!)
        : "";
    profilePhoto = user?.avatar;
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
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
          //log(avatar!.path.toString());
        });
      } else {
        return;
      }
    } catch (e) {
      MessageHelper.showInfoAlert(
          context: context, title: "Something went wrong. Please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryCol,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Get.find<NavController>().back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
            ),
          );
        }),
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SplashWidget(
                          onTap: () async {
                            await pickImage(context);
                          },
                          splashColor: Colors.grey,
                          margin: EdgeInsets.all(0),
                          contentPadding: EdgeInsets.all(0),
                          shadowColor: Colors.black,
                          radius: 50,
                          bgCol: Pallete.primaryCol.withOpacity(0.2),
                          elevation: 10,
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: avatar != null
                                ? Image.file(
                                    avatar!,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  )
                                : profilePhoto != null
                                    ? CachedNetworkImage(
                                        imageUrl: profilePhoto ?? "",
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) {
                                          return Center(
                                            child: Text(
                                              StorageHelper.userName?[0] ?? "",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        },
                                      )
                                    // : Center(
                                    //     child: Image.asset(
                                    //       MyAssets.camera,
                                    //       height: 24,
                                    //       width: 32,
                                    //     ),
                                    //   ),
                                    : Center(
                                        child: Text(
                                          StorageHelper.userName?[0] ?? "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async{
                            await pickImage(context);
                          },
                          child:Icon(Icons.edit_square,
                          color: ColorManager.primaryCol,
                          size: 30,
                          )))
                    ],
                  ),
                ),
                // ProfileTFF(
                //   controller: _id,
                //   name: "Employee Id",
                //   enabled: false,
                // ),
                ProfileTFF(
                  controller: _name,
                  name: "Name",
                  hintText: "Enter your name",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter your name";
                    }
                    return null;
                  },
                ),
                ProfileTFF(
                  controller: _email,
                  name: "Email",
                  hintText: "Enter your email",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter email";
                    }
                    if (!GetUtils.isEmail(val)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                ProfileTFF(
                  controller: _contact,
                  name: "Contact no.",
                  hintText: "Enter your number",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter number";
                    }
                    // if(int.tryParse(val) == null){
                    //   return "Enter valid contact number";
                    // }
                    return null;
                  },
                ),
                ProfileTFF(
                  controller: _address,
                  name: "Address",
                  hintText: "Enter your address",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter address";
                    }
                    return null;
                  },
                ),
                ProfileTFF(
                  controller: _dob,
                  name: "Date of birth",
                  hintText: "Enter your date of birth",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter your date of birth";
                    }
                    return null;
                  },
                ),
                // CustomDFF(
                //   name: "Gender",
                //   items: [
                //     const DropdownMenuItem(
                //       value: "Male",
                //       child: Text("Male"),
                //     ),
                //     const DropdownMenuItem(
                //       value: "Female",
                //       child: Text("Female"),
                //     ),
                //   ],
                //   onChanged: (val) {
                //     if (val == null) {
                //       return;
                //     }
                //     // gender.text = val;
                //   },
                //   value: "Female",
                // ),
                GetBuilder<ProfileController>(builder: (controller) {
                  return SubmitButton(
                    onPressed: () async {
                      await _editProfile();
                    },
                    label: "Save Profile",
                    hPad: 0,
                    isLoading: controller.isUpdatingProfile.value,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _editProfile() async {
    if (_formKey.currentState!.validate()) {
      Get.find<ProfileController>().editProfile(
          name: _name.text,
          email: _email.text,
          contactNo: _contact.text,
          address: _address.text,
          dob: _dob.text,
          avatar: avatar?.path);
    }
  }
}
