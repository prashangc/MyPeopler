import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> fileForName(String name) async {
    final path = await _localPath;
    return File('$path/$name');
  }

  static Future<List<String>> readFile(String name) async {
    try {
      final file = await fileForName(name);
      final contents = await file.readAsLines();
      return contents;
    } catch (e) {
      return [];
    }
  }

  static Future<void> writeContentInFile(String name, String content) async {
    final file = await fileForName(name);
    await file.writeAsString(content + Platform.lineTerminator, mode: FileMode.append);
  }

  static Future<void> writeContentsInFile(
      String name, List<String> contents) async {
    final file = await fileForName(name);
    for (String content in contents) {
      file.writeAsString(content, mode: FileMode.append);
    }
  }
  // Function to clear the contents of the file (keep the file)
  static Future<void> clearFileData(String name) async {
    final file = await fileForName(name);

    if (await file.exists()) {
      // Clear the file by writing an empty string to it
      await file.writeAsString('', mode: FileMode.write); 
      print('File cleared: $name');
    } else {
      // print('File does not exist: $name');
    }
  }
}
