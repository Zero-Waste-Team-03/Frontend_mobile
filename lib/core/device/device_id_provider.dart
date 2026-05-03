import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceIdProvider {
  DeviceIdProvider(this._secureStorage, this._uuid);

  final FlutterSecureStorage _secureStorage;
  final Uuid _uuid;

  static const String _deviceIdKey = 'x-device-id';

  Future<String> getOrCreateDeviceId() async {
    final cached = await _secureStorage.read(key: _deviceIdKey);
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final generated = _uuid.v4();
    await _secureStorage.write(key: _deviceIdKey, value: generated);
    return generated;
  }
}
