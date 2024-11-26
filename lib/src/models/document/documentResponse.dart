
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'dart:convert';

// part 'documentResponse.freezed.dart';
// part 'documentResponse.g.dart';

// DocumentResponse documentResponseFromJson(String str) => DocumentResponse.fromJson(json.decode(str));

// String documentResponseToJson(DocumentResponse data) => json.encode(data.toJson());

// @freezed
// abstract class DocumentResponse with _$DocumentResponse {
//     const factory DocumentResponse({
//         required List<DocumentFolder>? data,
//     }) = _DocumentResponse;

//     factory DocumentResponse.fromJson(Map<String, dynamic> json) => _$DocumentResponseFromJson(json);
// }

// @freezed
// abstract class DocumentFolder with _$DocumentFolder {
//     const factory DocumentFolder({
//         required int? id,
//         required String? folder_name,
//         required String? folder_description,
//         required DateTime? created_at,
//         required List<FileElement>? files,
//     }) = _DocumentFolder;

//     factory DocumentFolder.fromJson(Map<String, dynamic> json) => _$DocumentFolderFromJson(json);
// }

// @freezed
// abstract class FileElement with _$FileElement {
//     const factory FileElement({
//         required int? id,
//         required int? created_by,
//         required int? folder_id,
//         required String? caption,
//         required String? file_name,
//         required int? publication_status,
//         required int? deletion_status,
//         required dynamic deleted_at,
//         required DateTime? created_at,
//         required DateTime? updated_at,
//     }) = _FileElement;

//     factory FileElement.fromJson(Map<String, dynamic> json) => _$FileElementFromJson(json);
// }
