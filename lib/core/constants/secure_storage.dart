import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageConstants {
  static const String iosAccountName = 'flutter_app_secure_storage_service';

  // static const String iosGroupId = 'flutter_nrna_secure_storage_group';

  static const AndroidOptions androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static const IOSOptions iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.unlocked,
    accountName: iosAccountName,
    synchronizable: false,
  );
}
