import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String id; // Firestore document ID
  final String ImageUrl; // Match exact Firestore field name
  final String TargetScreen; // Match exact Firestore field name
  final bool Active; // Match exact Firestore field name

  BannerModel({
    required this.id,
    required this.ImageUrl,
    required this.TargetScreen,
    required this.Active,
  });

  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': ImageUrl, // Must match Firestore field name
      'TargetScreen': TargetScreen, // Must match Firestore field name
      'Active': Active, // Must match Firestore field name
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id, // Capture Firestore document ID
      ImageUrl: data['ImageUrl'] ?? '',
      TargetScreen: data['TargetScreen'] ?? '',
      Active: data['Active'] ?? false,
    );
  }
}