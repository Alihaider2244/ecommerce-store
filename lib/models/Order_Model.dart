import 'package:ecommerce_app_2/models/productModel.dart';


class OrderModel {
  String orderid;
  String payment;
  String status;
  List<ProductModel> products;
  double totalPrice;

  OrderModel(
      {required this.orderid,
      required this.payment,
      required this.status,
      required this.products,
      required this.totalPrice});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsMap = json['products'];
    return OrderModel(
      orderid: json["orderid"],
      payment: json["payment"],
      status: json["status"],
      products: productsMap.map((e) => ProductModel.fromJson(e)).toList(),
      totalPrice: json["totalPrice"],
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "orderid": orderid,
  //       "payment": payment,
  //       "status": status,
  //       "product": produsctMap.map((e) => ProductModel.fromJson(e).tolist()),
  //       "totalPrice": totalPrice,
  //     };

  // OrderModel copywith({String? name, String? img}) => OrderModel(
  //     orderid: orderid,
  //     name: name ?? this.name,
  //     img: img ?? this.img,
  //     email: email,
  //     phone: phone ?? this.phone);
}
