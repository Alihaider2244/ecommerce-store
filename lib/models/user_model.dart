class UserModel {
  String? id;
  String? img;
  String? name;
  String? email;
  String? phone;

  UserModel(
      {required this.id,
      required this.img,
      required this.name,
      required this.email,
      required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        img: json["img"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "name": name,
        "email": email,
        "phone": phone,
      };

  UserModel copywith({String? name, String? img}) => UserModel(
      id: id,
      name: name ?? this.name,
      img: img ?? this.img,
      email: email,
      phone: phone ?? this.phone);
}
