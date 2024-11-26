// To parse this JSON data, do
//
//     final documentsModel = documentsModelFromJson(jsonString);

import 'dart:convert';

DocumentsModel documentsModelFromJson(String str) => DocumentsModel.fromJson(json.decode(str));

String documentsModelToJson(DocumentsModel data) => json.encode(data.toJson());

class DocumentsModel {
    DocumentsModel({
        this.data,
    });

    final Data? data;

    factory DocumentsModel.fromJson(Map<String, dynamic> json) => DocumentsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.folders,
        this.files,
    });

    final List<Folder>? folders;
    final List<FileElement>? files;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        folders: json["folders"] == null ? [] : List<Folder>.from(json["folders"]!.map((x) => Folder.fromJson(x))),
        files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "folders": folders == null ? [] : List<dynamic>.from(folders!.map((x) => x.toJson())),
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
    };
}

class FileElement {
    FileElement({
        this.id,
        this.caption,
        this.fileName,
        this.createdAt,
        this.fileUrl,
    });

    final int? id;
    final String? caption;
    final String? fileName;
    final DateTime? createdAt;
    final String? fileUrl;

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        caption: json["caption"],
        fileName: json["file_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        fileUrl: json["file_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "caption": caption,
        "file_name": fileName,
        "created_at": createdAt?.toIso8601String(),
        "file_url": fileUrl,
    };
}

class Folder {
    Folder({
        this.id,
        this.name,
        this.description,
        this.createdAt,
    });

    final int? id;
    final String? name;
    final dynamic description;
    final DateTime? createdAt;

    factory Folder.fromJson(Map<String, dynamic> json) => Folder(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
    };
}
