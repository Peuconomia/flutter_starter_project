import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../helpers/assets.dart';
import '../injections/injections.dart';
import 'file_from_asset.dart' as asset_path_loader;

Future<String?> filePathFrom({required String url}) async {
  Dio dio = getIt<Dio>();

  String? filePath;
  try {
    final response = await dio.get(url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ));

    final tempDirectory = await getTemporaryDirectory();

    final file = File(join(tempDirectory.path, 'nrna_share.png'));

    file.writeAsBytesSync(response.data);

    filePath = file.path;
  } catch (e, stack) {
    await FirebaseCrashlytics.instance.recordError(e, stack);
    filePath =
        await asset_path_loader.filePathFrom(assetPath: ImageAssets.logo);
  }

  return filePath;
}
