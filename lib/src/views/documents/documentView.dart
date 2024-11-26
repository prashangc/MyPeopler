import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/document/documentModel.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/splashWidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentView extends StatelessWidget {
  DocumentView({Key? key, required this.files}) : super(key: key);
  final RefreshController refreshController = RefreshController();
  final List<FileElement> files;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return DocumentCard(
            file: files[index],
          );
        },
      );
    // Scaffold(
    //   appBar: AppBar(
    //     leading: Builder(
    //       builder: (context) {
    //         return IconButton(
    //           onPressed: () {
    //             Get.find<NavController>().back();
    //           },
    //           icon: Icon(
    //             Icons.arrow_back_ios_new,
    //           ),
    //         );
    //       },
    //     ),
    //     title: Text("Documents"),
    //     automaticallyImplyLeading: false,
    //   ),
    //   body: ListView.builder(
    //     itemCount: files.length,
    //     itemBuilder: (context, index) {
    //       return DocumentCard(
    //         file: files[index],
    //       );
    //     },
    //   ),
    // );
  }
}

class DocumentCard extends StatelessWidget {
  const DocumentCard({Key? key, required this.file}) : super(key: key);
  final FileElement file;
  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      onTap:() async {
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
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shadowColor: Colors.black,
      radius: 8,
      bgCol: Colors.white,
      border: Border.all(color: Colors.black12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.caption ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
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
