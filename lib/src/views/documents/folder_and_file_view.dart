import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/documentController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/messageHelper.dart';
import 'package:my_peopler/src/models/document/documentModel.dart';
import 'package:my_peopler/src/resources/values_manager.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class FolderAndFileView extends StatelessWidget {
  const FolderAndFileView({Key? key, required this.folders, required this.files}) : super(key: key);
  final List<Folder> folders;
  final List<FileElement> files;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
          ...folders.map((folder) {
           return Padding(
             padding:  EdgeInsets.only(top: AppPadding.p8, left: AppPadding.p8, right: AppPadding.p8,),
             child: FolderDesign(folder: folder,onTap: (() async{
               await Get.find<DocumentController>().getDocuments(folderId: folder.id);
             }),),
           );
      },),
      ...files.map((file) => Padding(
        padding: const EdgeInsets.only(top: AppPadding.p8, left: AppPadding.p8, right: AppPadding.p8,),
        child: FileDesign(
                file: file,
              ),
      ))
      ]
    );
  }
}

class FolderDesign extends StatelessWidget {
  final void Function()? onTap;
  final Folder folder;
  const FolderDesign({
    Key? key,
    this.onTap,
    required this.folder

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      onTap: onTap,
      splashColor: Pallete.primaryCol,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      shadowColor: Colors.black,
      radius: 8,
      bgCol: Colors.white,
      border: Border.all(color: Colors.black12),
      
      child: Container(
           decoration: BoxDecoration(
             // color: HexColor("#EAEDF2"),
             borderRadius: BorderRadius.circular(15),
           ),
           padding: EdgeInsets.all(8),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment:MainAxisAlignment.start,
             children: [
               Image.asset(
                 MyAssets.folder,
                 height: AppSize.s28,
               ),
               SizedBox(width: AppSize.s8,),
               Text(
                 folder.name ??"",
                   style: Theme.of(context).textTheme.displayLarge,
                 maxLines: 3,
                 overflow: TextOverflow.ellipsis,
                 textAlign: TextAlign.center,
               ),
             ],
           ),
         ),
       );
  }
}


class FileDesign extends StatelessWidget {
  const FileDesign({Key? key, required this.file}) : super(key: key);
  final FileElement file;
  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      onTap: () async {
              try {
                var url = Uri.tryParse(file.fileUrl ?? "");
                if (url == null) {
                  MessageHelper.error("Cannot Open this file");
                  return;
                }
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                }
              } catch (e) {
                MessageHelper.error("Cannot open the file");
              }
            },
      splashColor: Pallete.primaryCol,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      shadowColor: Colors.black,
      radius: 8,
      bgCol: Colors.white,
      border: Border.all(color: Colors.black12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.caption ?? "",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  MyDateUtils.getDateOnly(file.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                var url = Uri.tryParse(file.fileUrl ?? "");
                if (url == null) {
                  MessageHelper.error("Cannot Open this file");
                  return;
                }
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                }
              } catch (e) {
                MessageHelper.error("Cannot open the file");
              }
            },
            icon: Icon(
              Icons.open_in_new,
            ),
          ),
        ],
      ),
    );
  }
}