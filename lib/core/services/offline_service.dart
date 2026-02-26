import 'package:get_storage/get_storage.dart';

class OfflineService {
  final GetStorage _storage = GetStorage();

  // Save data to local storage
  void saveData(String key, dynamic data) {
    _storage.write(key, data);
  }

  // Get data from local storage
  dynamic getData(String key) {
    return _storage.read(key);
  }

  // Check if data exists
  bool hasData(String key) {
    return _storage.hasData(key);
  }

  // Remove data
  void removeData(String key) {
    _storage.remove(key);
  }
}
