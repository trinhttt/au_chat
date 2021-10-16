import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorageByFile {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local.txt');
  }

  Future<File> writeContents(String contents) async {
    final file = await _localFile;
    print('contents $contents');

    // Write the file
    return file.writeAsString('$contents');
  }

  Future<String?> readContents() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }
}
