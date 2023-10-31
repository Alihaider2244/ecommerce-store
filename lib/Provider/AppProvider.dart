import '../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_2/constants/constants.dart';
import 'package:ecommerce_app_2/models/productModel.dart';
import 'package:ecommerce_app_2/constants/FirestoreHelper/FirestoreHelper.dart';
import 'package:ecommerce_app_2/firebaseFirestoreHelper/firebaseFirestoreHelper.dart';

class AppProvider with ChangeNotifier {
  //Cart screen work
  List<ProductModel> productModelList = [];
  List<ProductModel> get getProductList => productModelList;

  void AddProductToList(ProductModel productModel) {
    productModelList.add(productModel);
    notifyListeners();
  }

  void RemoveProductToList(ProductModel productModel) {
    productModelList.remove(productModel);
    notifyListeners();
  }

  //Favorite screen work
  List<ProductModel> FavouriteList = [];
  List<ProductModel> get getFavouriteList => FavouriteList;

  void AddToFavList(ProductModel productModel) {
    FavouriteList.add(productModel);
    notifyListeners();
  }

  void RemoveFromFavList(ProductModel productModel) {
    FavouriteList.remove(productModel);
    notifyListeners();
  }

  // User information Firebase
  UserModel? userModel;
  UserModel get getUserInformation => userModel!;
  void getUserInfoFIrebase() async {
    userModel = await FirebaseFirestoreHelper.instance.getUserInfo();
    notifyListeners();
  }

  void updateUserInformation(
      BuildContext context, UserModel _userModel, String img) async {
    showLoaderDialogue(context);
    if (img == null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_userModel.id)
          .set(_userModel.toJson());
    } else {
      String? imgUrl = await FirebaseStorageHelper.instance.uploadImage(img);
      userModel = _userModel.copywith(img: imgUrl);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.id)
          .set(userModel!.toJson());
      notifyListeners();
    }
    Navigator.of(context).pop();
  }

  // Total price for cart screen
  double totalPrice() {
    double price = 0.0;
    for (var element in getProductList) {
      if (element != null) {
        price += (element.price ?? 0.0) * (element.qty ?? 0);
      }
    }
    return price;
  }

  void updateQtyAndPrice(int quantity, ProductModel productModel) {
    int index = getProductList.indexOf(productModel);
    getProductList[index].qty = quantity;
    notifyListeners();
  }

  ///Buy product moedel  
  final List<ProductModel> _buyProductModel=[];
  List<ProductModel> get getBuyproductList=>_buyProductModel;

  void addBuyProduct(ProductModel model){
    _buyProductModel.add(model);
    notifyListeners();
  }


}
