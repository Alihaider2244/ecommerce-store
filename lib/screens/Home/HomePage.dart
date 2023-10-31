import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../productView/productViewpage.dart';
import 'package:ecommerce_app_2/constants/routes.dart';
import 'package:ecommerce_app_2/widgets/topTitles.dart';
import 'package:ecommerce_app_2/models/productModel.dart';
import 'package:ecommerce_app_2/Provider/AppProvider.dart';
import 'package:ecommerce_app_2/models/CategoryModel.dart';
import 'package:ecommerce_app_2/screens/product_details/product_details.dart';
import 'package:ecommerce_app_2/screens/Favoyrite_Screen/favouritre_screen.dart';
import 'package:ecommerce_app_2/firebaseFirestoreHelper/firebaseFirestoreHelper.dart';

// ignore_for_file: prefer_interpolation_to_compose_strings

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> bestProductList = [];
  bool islaoding = false;
  @override
  void initState() {
   AppProvider provider=Provider.of<AppProvider>(context,listen: false);
    provider.getUserInfoFIrebase();
    getCtegory();
    super.initState();
  }

  void getCtegory() async {
    setState(() {
      islaoding = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCAtegories();
    bestProductList = await FirebaseFirestoreHelper.instance.getBestProducts();
    
    bestProductList.shuffle();
    setState(() {
      islaoding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: islaoding
          ? Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Colors.red.shade300,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: kToolbarHeight,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TopTitles(title: 'E-commerce', subtitle: ''),
                          Padding(
                            padding: const EdgeInsets.only(bottom:15.0,right: 10),
                            child: CupertinoButton(padding: EdgeInsets.zero,
                                child: Icon(Icons.favorite,color: Colors.red.shade200,),
                                onPressed: () {
                                  Routes.instance
                                      .Push(FavouriteScreen(), context);
                                }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'search'),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18, top: 13),
                      child: TopTitles(title: 'Categories', subtitle: ''),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: categoriesList
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.Push(
                                            ProductViewPage(productModel: e),
                                            context);
                                      },
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          child:
                                              Image.network(e.img.toString()),
                                          // child: Text(e..toString()),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList()),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18, top: 13),
                      child: TopTitles(title: 'Top selling', subtitle: ''),
                    ),
                    bestProductList.isEmpty
                        ? Center(
                            child: Text('Best product is empty yet'),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: bestProductList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 2,
                                        childAspectRatio: 0.8),
                                itemBuilder: ((context, index) {
                                  ProductModel singleChild =
                                      bestProductList[index];
                                  return Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 70,
                                            child: Image.network(
                                              singleChild.img.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            singleChild.name.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'price:\$' +
                                                singleChild.price.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          OutlinedButton(
                                              onPressed: () {
                                                Routes.instance.Push(
                                                    ProductDetails(
                                                        singleProduct:
                                                            singleChild),
                                                    context);
                                              },
                                              child: const Text(
                                                'Buy',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                        ],
                                      ));
                                })),
                          ),
                  ]),
            ),
    );
  }
}
