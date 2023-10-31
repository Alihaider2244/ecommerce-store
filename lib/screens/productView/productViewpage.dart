import '../../constants/routes.dart';
import 'package:flutter/material.dart';
import '../../models/productModel.dart';
import 'package:ecommerce_app_2/widgets/topTitles.dart';
import 'package:ecommerce_app_2/models/CategoryModel.dart';
import '../../firebaseFirestoreHelper/firebaseFirestoreHelper.dart';
import 'package:ecommerce_app_2/screens/product_details/product_details.dart';

class ProductViewPage extends StatefulWidget {
  final CategoryModel productModel;
  const ProductViewPage({super.key, required this.productModel});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  List<ProductModel> productViewList = [];
  bool islaoding = false;
  @override
  void initState() {
    getCtegory();
    super.initState();
  }

  void getCtegory() async {
    setState(() {
      islaoding = true;
    });
    productViewList = await FirebaseFirestoreHelper.instance
        .getViewCategoryProducts(widget.productModel.id.toString());

    productViewList.shuffle();
    setState(() {
      islaoding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: islaoding
            ? const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: kToolbarHeight,
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back_ios)),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0),
                          child: TopTitles(title: widget.productModel.name, subtitle: ''),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: productViewList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: 0.8),
                          itemBuilder: ((context, index) {
                            ProductModel singleChild = productViewList[index];

                            return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(10)),
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
                                      'price:\$${singleChild.price}',
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
                                                  singleProduct: singleChild),
                                              context);
                                        },
                                        child: const Text(
                                          'Buy',
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                ));
                          })),
                    ),
                  ],
                ),
              ));
  }
}
