class Term {
  final int id;
  final String title;
  final String titleAr;
  final String description;
  final String descriptionAr;

  Term({
    required this.id,
    required this.title,
    required this.description,
    required this.titleAr,
    required this.descriptionAr,
  });

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      id: json['id'],
      title: json['title'],
      titleAr: json['title_ar'],
      descriptionAr: json['description_ar'],
      description: json['description'],
    );
  }
}
