import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapheapp/features/shop/models/cafe_model.dart';

class CafeRepository {
  final _db = FirebaseFirestore.instance;

  /// Fetch featured cafes for a specific branch
  Future<List<CafeModel>> getFeaturedCafes(String branchId) async {
    try {
      final snapshot = await _db
          .collection('branches')
          .doc(branchId)
          .collection('cafes')
          .where('isFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((doc) => CafeModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch featured cafes: $e');
    }
  }

  /// Fetch all cafes for a specific branch
  Future<List<CafeModel>> getAllCafes(String branchId) async {
    try {
      final snapshot = await _db
          .collection('branches')
          .doc(branchId)
          .collection('cafes')
          .get();
      return snapshot.docs.map((doc) => CafeModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch cafes: $e');
    }
  }

  /// Fetch a single cafe by ID for a specific branch
  Future<CafeModel?> getCafeById(String branchId, String cafeId) async {
    try {
      final doc = await _db
          .collection('branches')
          .doc(branchId)
          .collection('cafes')
          .doc(cafeId)
          .get();
      return doc.exists ? CafeModel.fromSnapshot(doc) : null;
    } catch (e) {
      throw Exception('Failed to fetch cafe: $e');
    }
  }
}