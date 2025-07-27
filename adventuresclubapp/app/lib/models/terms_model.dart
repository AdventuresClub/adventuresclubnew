class Term {
  final int id;
  final String title;
  final String description;

  Term({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
