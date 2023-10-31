

class ProductModel {
  late String? name;
  late int? price;
  late String? description;
  late bool isFave = false;
  late String? status;
  late String? img;
  late String? id;
  int? qty;

  ProductModel({
    required this.description,
    required this.id,
    required this.img,
    required this.isFave,
    required this.name,
    required this.price,
    required this.status,
    this.qty,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        description: json['description'],
        id: json['id'],
        img: json['img'],
        isFave: false,
        name: json['name'],
        price: json['price'],
        status: json['status'],
        qty: json['qty'],
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'id': id,
        'img': img,
        'isFave': isFave,
        'name': name,
        'price': price,
        'status': status,
        'qty': qty,
      };

  ProductModel copywith({
    int? qty,
  }) =>
      ProductModel(
          description: description,
          id: id,
          img: img,
          isFave: isFave,
          name: name,
          price: price,
          status: status,
          qty: qty ?? this.qty);
}
