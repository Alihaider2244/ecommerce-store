class CategoryModel {
  String? id;
  String? img;
  String? name;

  CategoryModel({this.id, this.img, this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        img: json["img"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "name": name,
      };
}
