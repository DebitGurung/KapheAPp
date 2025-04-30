import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TCloudinaryStorageService extends GetxController {
  static TCloudinaryStorageService get instance => Get.find();

  final Cloudinary _cloudinary = Get.find<Cloudinary>();

  // Get image data from assets
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      );
    } catch (e) {
      throw 'Error loading image data: $e';
    }
  }

  // Upload image using Uint8List data to Cloudinary
  Future<String> uploadImageData(
    String folderPath,
    Uint8List imageData,
    String fileName,
  ) async {
    try {
      final response = await _cloudinary.uploadResource(
        CloudinaryUploadResource(
          fileBytes: imageData,
          folder: folderPath,
          fileName: fileName,
          resourceType: CloudinaryResourceType.image,
        ),
      );
      return response.secureUrl ?? '';
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
      );

      if (result == null || result.files.isEmpty) {
        throw 'No file selected';
      }

      final PlatformFile platformFile = result.files.first;
      final Uint8List? fileBytes = platformFile.bytes;
      final String? filePath = platformFile.path;

      if (fileBytes == null && filePath == null) {
        throw 'Failed to get file data.';
      }

      final response = await _cloudinary.uploadResource(
        fileBytes != null
            ? CloudinaryUploadResource(
          fileBytes: fileBytes,
          folder: folderPath,
          resourceType: CloudinaryResourceType.image,
        )
            : CloudinaryUploadResource(
          filePath: filePath!,
          folder: folderPath,
          resourceType: CloudinaryResourceType.image,
        ),
      );

      if (response.secureUrl == null) {
        throw 'Image upload succeeded but returned no URL.';
      }

      return response.secureUrl!;
    } catch (e) {
      throw FirebaseException(
        code: 'cloudinary_upload_failed',
        message: _handleError(e), plugin: '',
      );
    }
  }

  String _handleError(dynamic e) {
    if (e is SocketException) return 'Network error: ${e.message}';
    if (e is PlatformException) return 'Platform error: ${e.message}';
    return e.toString();
  }
}

