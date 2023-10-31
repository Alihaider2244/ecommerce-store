import '../models/productModel.dart';
import '../models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_2/models/user_model.dart';
import 'package:ecommerce_app_2/models/Order_Model.dart';
import 'package:ecommerce_app_2/constants/constants.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCAtegories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection('categories').get();
      List<CategoryModel> CategoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return CategoriesList;
    } catch (error) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(error.toString())));
      return [];
    }
  }

  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collectionGroup('products').get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (error) {
      return [];
    }
  }

  Future<List<ProductModel>> getViewCategoryProducts(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('categories')
          .doc(id)
          .collection('products')
          .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (error) {
      return [];
    }
  }

  Future<UserModel> getUserInfo() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

  Future<bool> uploadOrdersToFirebase(
      List<ProductModel> list, String payment, BuildContext context) async {
    try {
      double totalPrice = 0.0;
      for (var element in list) {
        if (element != null) {
          totalPrice += (element.price ?? 0.0) * (element.qty ?? 0);
        }
      }
      showLoaderDialogue(context);
      DocumentReference documentReference = firestore
          .collection('userorders')
          .doc(FirebaseAuth.instance.currentUser!.uid!)
          .collection('orders')
          .doc();
      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": 'pending',
        "totalPrice": totalPrice,
        "payment": payment
      });
      Navigator.of(context).pop();
      showMessage('order success');
      return true;
    } catch (e) {
      Navigator.of(context).pop();
      showMessage(e.toString());
      return false;
    }
  }
  // Get user orders

  Future<List<OrderModel>> GetUserOrderList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection("userorders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .get();
      List<OrderModel> orderList = querySnapshot.docs
          .map((Element) => OrderModel.fromJson(Element.data()))
          .toList();

      print(orderList.toString());
      return orderList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
