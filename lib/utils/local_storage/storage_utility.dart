import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  late final GetStorage _storage;
  static TLocalStorage? _instance;
  static String _currentBucket = 'get_storage'; // Now used in switchBucket()

  TLocalStorage._internal();

  // Static getter for instance access
  static TLocalStorage get instance {
    if (_instance == null) {
      throw Exception('TLocalStorage not initialized. Call init() first.');
    }
    return _instance!;
  }

  // Initialization method
  static Future<void> init([String bucketName = 'get_storage']) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
    _currentBucket = bucketName; // Track the active bucket
  }

  // Switch to a different storage bucket
  static Future<void> switchBucket(String bucketName) async {
    if (_currentBucket != bucketName) {
      // Only switch if the bucket name changes
      await GetStorage.init(bucketName);
      _instance!._storage = GetStorage(bucketName);
      _currentBucket = bucketName; // Update current bucket
    }
  }

  // Example method (using the active bucket)
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }

  // Optional: Expose current bucket for debugging/logging
  String get currentBucket => _currentBucket;
}