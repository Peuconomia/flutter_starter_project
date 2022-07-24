import 'package:app/core/config_reader/config_reader.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../injections.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(
        baseUrl:
            '${getIt<ConfigReader>().baseURL}${getIt<ConfigReader>().apiPath}',
      ));
}
