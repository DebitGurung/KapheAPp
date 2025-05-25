class CafeAttributeModel {
  final String name;
  final List<String> values;

  CafeAttributeModel({
    this.name = '',
    this.values = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      if (name.isNotEmpty) 'Name': name,
      'Values': values,
    };
  }

  factory CafeAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return CafeAttributeModel(
        name: json['Name'] as String? ?? '',
        values: (json['Values'] as List<dynamic>?)?.cast<String>() ?? [],
      );
    } catch (e) {
      throw FormatException('Failed to parse ProductAttributeModel: $e');
    }
  }
}