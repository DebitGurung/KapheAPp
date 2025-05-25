import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String imageUrl;
  final String targetScreen;
  final bool active;

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    // Sanitize imageUrl by removing extra quotes
    String rawImageUrl = (data['ImageUrl'] as String?) ?? '';
    String sanitizedImageUrl = rawImageUrl.replaceAll('"', '').trim();
    return BannerModel(
      imageUrl: sanitizedImageUrl.isNotEmpty
          ? sanitizedImageUrl
          : 'assets/images/placeholder.png',
      targetScreen: data['TargetScreen'] as String? ?? '',
      active: data['Active'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }
}