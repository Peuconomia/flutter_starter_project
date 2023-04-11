import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileManager {
  static Future<String?> saveFileToDocumentsDirectory(
      {required File file, String? preferredName}) async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      String newFileName = '';
      String ext = extension(file.path);

      if (preferredName != null) {
        newFileName = preferredName;
      } else {
        newFileName = basenameWithoutExtension(file.path);
      }

      File newFile = File('${documentsDirectory.path}/$newFileName$ext');

      final savedFile = await newFile.writeAsBytes(await file.readAsBytes(),
          mode: FileMode.write);

      return savedFile.path;
    } catch (e) {
      return null;
    }
  }
}
