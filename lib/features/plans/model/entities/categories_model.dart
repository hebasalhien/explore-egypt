class CategoriesModel {
  final String name;
  final String id;

  CategoriesModel({required this.name, required this.id});
  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(name: json['label'], id: json['id']);
}
