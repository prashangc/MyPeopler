import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/models/document/documentModel.dart';
import 'package:my_peopler/src/views/views.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:my_peopler/src/views/documents/folder_and_file_view.dart';
class DocumentFolderView extends StatefulWidget {
  DocumentFolderView({Key? key}) : super(key: key);

  @override
  State<DocumentFolderView> createState() => _DocumentFolderViewState();
}

class _DocumentFolderViewState extends State<DocumentFolderView> {
  final RefreshController refreshController = RefreshController();
  @override
  void initState() {
    Get.find<DocumentController>().refreshDocuments();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(
      builder: (documentController) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: documentController.pages.isEmpty? AppBar(
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
            title: Text("Documents"),
            automaticallyImplyLeading: false,
          ): AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () async{
                    await Get.find<DocumentController>().fetchPreviousDocuments();
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                );
              },
            ),
            title: Text("Documents"),
            automaticallyImplyLeading: false,
          ),
          body:
        SmartRefresher(
            controller: refreshController,
            onRefresh: () async {
              await Get.find<DocumentController>().refreshDocuments();
              refreshController.refreshCompleted();
            },
            child: views(documentController,context)
            ),
          );
      }
    );
  }

  Widget views(DocumentController documentController, BuildContext context) {
    if (documentController.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }else if(documentController.folders!.isNotEmpty && documentController.files!.isNotEmpty){
      return FolderAndFileView(folders: documentController.folders ?? [],files: documentController.files ?? [],);
    }
    else if(documentController.folders!.isNotEmpty){
      return FolderGrid(folders: documentController.folders ?? [],);
    }else if(documentController.folders!.isEmpty && documentController.files!.isEmpty){
      return NoDataWidget();
    }
    else{
      return DocumentView(files: documentController.files ?? [],);
    }
  }
}



class FolderGrid extends StatelessWidget {
  const FolderGrid({Key? key, required this.folders}) : super(key: key);
  final List<Folder> folders;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 3 / 3.6,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.all(10),
      itemCount: folders.length,
      itemBuilder: (context, index) {
        var folder = folders[index];
        return InkWell(
          onTap: () async{
            await Get.find<DocumentController>().getDocuments(folderId: folders[index].id);
          },
          splashColor:  Pallete.primaryCol,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
              // color: HexColor("#EAEDF2"),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  MyAssets.folder,
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    folder.name ??"",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


