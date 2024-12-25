class CategoryModel {
  int id;
  String category;
  String image;
  int status;
  String? imageInserted;
  CategoryModel(this.id, this.category, this.image, this.status,
      {this.imageInserted});
}
