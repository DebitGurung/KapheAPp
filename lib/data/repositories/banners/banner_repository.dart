import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/banner_model.dart';
import '../../../exceptions/firebase/firebase_exception.dart';
import '../../../exceptions/format/format_exception.dart';
import '../../../exceptions/platform/platform_exception.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find(); // Changed from 'to' to 'instance'

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final snapshot = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => BannerModel.fromSnapshot(doc))
          .toList();

    } on SocketException catch (e) {
      throw 'Network error: ${e.message}';
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } catch (e) {
      throw 'Failed to fetch banners: ${e.toString()}';
    }
  }

  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {
      final batch = _db.batch();

      for (final banner in banners) {
        final docRef = _db.collection('Banners').doc();
        batch.set(docRef, {
          'ImageUrl': banner.ImageUrl,
          'TargetScreen': banner.TargetScreen,
          'Active': banner.Active,
        });
      }

      await batch.commit();

    } on SocketException catch (e) {
      throw 'Network error: ${e.message}';
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Failed to upload banners: ${e.toString()}';
    }
  }
}