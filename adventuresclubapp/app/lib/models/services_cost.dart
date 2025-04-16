class ServicesCost {
  final int id;
  final String description;
  final String createdAt;
  final String updatedAt;

  ServicesCost({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServicesCost.fromJson(Map<String, dynamic> json) {
    return ServicesCost(
      id: json['id'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }
}
