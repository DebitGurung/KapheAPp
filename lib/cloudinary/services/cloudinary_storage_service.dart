import 'dart:io';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class TCloudinaryStorageService extends GetxController {
  static TCloudinaryStorageService get instance => Get.find();

  final Cloudinary _cloudinary = Get.find<Cloudinary>();
  Cloudinary get cloudinary => _cloudinary;
  final Map<String, String> _uploadPresets = {
    'banners': dotenv.env['CLOUDINARY_UPLOAD_PRESET_BANNERS'] ?? 'banners',
    'category': dotenv.env['CLOUDINARY_UPLOAD_PRESET_CATEGORY'] ?? 'category',
    'cafe_location': dotenv.env['CLOUDINARY_UPLOAD_PRESET_CAFE_LOCATION'] ?? 'cafe_location',
    'brands': dotenv.env['CLOUDINARY_UPLOAD_PRESET_BRANDS'] ?? 'brands',
    'products': dotenv.env['CLOUDINARY_UPLOAD_PRESET_PRODUCTS'] ?? 'products',
  };
  // Get image data from assets
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      );
    } catch (e) {
      throw Exception('Failed to load asset at $path: $e');
    }
  }

  // Upload image using Uint8List data to Cloudinary
  Future<String> uploadImageData(
      String folderPath,
      Uint8List imageData,
      String fileName,
      ) async {
    try {
      // Sanitize file name
      final sanitizedFileName = fileName.replaceAll(RegExp(r'[^\w.]'), '_');
      // Get the upload preset for the given folderPath, default to 'default' if not found
      final uploadPreset = _uploadPresets[folderPath] ?? 'default';

      final response = await _cloudinary.uploadResource(
        CloudinaryUploadResource(
          fileBytes: imageData,
          folder: folderPath,
          fileName: sanitizedFileName,
          resourceType: CloudinaryResourceType.image,
          uploadPreset: uploadPreset, // Add the upload preset
        ),
      );

      if (!response.isSuccessful || response.secureUrl == null) {
        throw Exception('Upload failed: ${response.error ?? "No URL returned"}');
      }

      return response.secureUrl!;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Upload image using FilePicker to Cloudinary
  Future<String> uploadImageFile(String folderPath) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        withData: true, // Ensure fileBytes for web
      );

      if (result == null || result.files.isEmpty) {
        throw Exception('No file selected');
      }

      final PlatformFile platformFile = result.files.first;
      final Uint8List? fileBytes = platformFile.bytes;
      final String? filePath = platformFile.path;
      final fileName = platformFile.name;

      if (fileBytes == null && filePath == null) {
        throw Exception('Failed to get file data');
      }

      // Get the upload preset for the given folderPath, default to 'default' if not found
      final uploadPreset = _uploadPresets[folderPath] ?? 'default';

      final response = await _cloudinary.uploadResource(
        fileBytes != null
            ? CloudinaryUploadResource(
          fileBytes: fileBytes,
          folder: folderPath,
          fileName: fileName,
          resourceType: CloudinaryResourceType.image,
          uploadPreset: uploadPreset, // Add the upload preset
        )
            : CloudinaryUploadResource(
          filePath: filePath!,
          folder: folderPath,
          fileName: fileName,
          resourceType: CloudinaryResourceType.image,
          uploadPreset: uploadPreset, // Add the upload preset
        ),
      );

      if (!response.isSuccessful || response.secureUrl == null) {
        throw Exception('Upload failed: ${response.error ?? "No URL returned"}');
      }

      return response.secureUrl!;
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(dynamic e) {
    if (e is SocketException) return 'Network error: ${e.message}';
    if (e is PlatformException) return 'Platform error: ${e.message}';
    return 'Error: $e (${e.runtimeType})';
  }
}