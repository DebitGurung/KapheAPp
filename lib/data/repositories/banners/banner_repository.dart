import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/banner_model.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final snapshot = await _db
          .collection('banners')
          .where('Active', isEqualTo: true)
          .get();
      return snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw 'Error fetching banners: $e';
    }
  } 

  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {
      final batch = _db.batch();
      for (var banner in banners) {
        final docRef = _db.collection('banners').doc();
        batch.set(docRef, banner.toJson());
      }
      await batch.commit();
    } catch (e) {
      throw 'Error uploading banners: $e';
    }
  }
}