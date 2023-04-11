import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> filePathFrom({required String assetPath}) async {
  final byteData = await rootBundle.load(assetPath);

  final file = File('${(await getTemporaryDirectory()).path}/share_image.png');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file.path;
}
