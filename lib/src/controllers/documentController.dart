import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_peopler/src/models/document/documentModel.dart';
import 'package:my_peopler/src/repository/documentRepository.dart';

class DocumentController extends GetxController {
  DocumentController(this._documentRepository);

  final DocumentRepository _documentRepository;

  final Rx<DocumentsModel?> _documentResponse = Rx<DocumentsModel?>(null);
  List<Folder>? get folders => _documentResponse.value?.data?.folders ?? [];
  List<FileElement>? get files => _documentResponse.value?.data?.files ?? [];
  var isLoading = false.obs;
  List<int> pages = [];


  getDocuments({int? folderId}) async {
    isLoading(true);
    if(folderId != null){
      pages.add(folderId);
    }
    
    var res = await _documentRepository.getDocuments(folderId);
    isLoading(false);
    if (!res.hasError) {
      _documentResponse.value = res.data as DocumentsModel;
      log(folders.toString(), name: "DocumentController");
      update();
    }
  }

  fetchPreviousDocuments() async {
    isLoading(true);
     pages.removeLast();
    var res = await _documentRepository.getDocuments(
      //pages.last == 1 ? null:pages.last
      pages.isEmpty ? null:  pages.last
      );
    
    isLoading(false);
    if (!res.hasError) {
      _documentResponse.value = res.data as DocumentsModel;
      log(folders.toString(), name: "DocumentController");
      update();
    }
  }

  Future<void> refreshDocuments() async{
    isLoading(true);
    update();
    await getDocuments();
    isLoading(false);
    update();
  }

 
}
