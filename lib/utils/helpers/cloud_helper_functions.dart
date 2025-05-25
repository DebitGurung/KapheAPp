import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../exceptions/platform/platform_exception.dart';

class TCloudHelperFunctions {
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No data found!'));
    }
    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  static Widget? checkMultipleRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No data found!'));
    }
    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if (path.isEmpty) return '';

      // Access the pre-configured Cloudinary instance using GetX
      final cloudinary = Get.find<Cloudinary>();

      // Sanitize the public_id by removing invalid characters and spaces
      final publicId = path
          .replaceAll(RegExp(r'[^a-zA-Z0-9_/]'), '_')
          .replaceAll(' ', '_')
          .trim();

      // Construct the Cloudinary URL manually
      // Format: https://res.cloudinary.com/{cloud_name}/image/upload/{public_id}
      final url = 'https://res.cloudinary.com/${cloudinary.cloudName}/image/upload/$publicId';

      return url;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }
}