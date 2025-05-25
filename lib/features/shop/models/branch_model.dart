import 'package:flutter/cupertino.dart';

@immutable
class BranchModel {
  final String id;
  final String name;
  final bool isFeatured;
  final int branchCount; // Renamed for clarity

  const BranchModel({
    required this.id,
    required this.name,
    this.isFeatured = false,
    this.branchCount = 0, // Consistent naming
  });

  static BranchModel empty() => const BranchModel(
    id: '',
    name: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'IsFeatured': isFeatured,
      'BranchCount': branchCount, // Matches property
    };
  }

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    try {
      if (json.isEmpty) return BranchModel.empty();

      return BranchModel(
        id: json['Id'] as String? ?? '',
        name: json['Name'] as String? ?? '',
        isFeatured: json['IsFeatured'] as bool? ?? false,
        branchCount: json['BranchCount'] as int? ?? 0, // Added deserialization
      );
    } catch (e) {
      throw FormatException('Failed to parse BranchModel: $e');
    }
  }

  // Update copyWith, ==, hashCode, and toString accordingly
  BranchModel copyWith({
    String? id,
    String? name,
    bool? isFeatured,
    int? branchCount,
  }) {
    return BranchModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isFeatured: isFeatured ?? this.isFeatured,
      branchCount: branchCount ?? this.branchCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BranchModel &&
        other.id == id &&
        other.name == name &&
        other.isFeatured == isFeatured &&
        other.branchCount == branchCount;
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    isFeatured,
    branchCount,
  );

  @override
  String toString() => '''
BranchModel(
  Id: $id,
  Name: $name,
  BranchCount: $branchCount,
  IsFeatured: $isFeatured
)''';
}