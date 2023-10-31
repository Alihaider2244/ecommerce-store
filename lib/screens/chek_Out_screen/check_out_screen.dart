import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/AppProvider.dart';
import 'package:ecommerce_app_2/widgets/topTitles.dart';
import 'package:ecommerce_app_2/models/productModel.dart';
import 'package:ecommerce_app_2/widgets/primaryButton.dart';
import '../../firebaseFirestoreHelper/firebaseFirestoreHelper.dart';
import 'package:ecommerce_app_2/constants/FirestoreHelper/FirestoreHelper.dart';


class CheckOutScreen extends StatefulWidget {
  final ProductModel singleProduct;
  const CheckOutScreen({super.key, required this.singleProduct});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int groupvalue = 0;
  @override
  void initState() {
    groupvalue = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'Orders',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.red)),
              child: Row(children: [
                Radio(
                    value: 1,
                    groupValue: groupvalue,
                    onChanged: (value) {
                      setState(() {
                        groupvalue = value!;
                      });
                    }),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.money),
                ),
                const Text(
                  'Cash on delivery',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          //second box
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.red)),
              child: Row(children: [
                Radio(
                    value: 2,
                    groupValue: groupvalue,
                    onChanged: (value) {
                      setState(() {
                        groupvalue = value!;
                      });
                    }),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.money),
                ),
                const Text(
                  'Online Pay',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          PrimaryButton(
            title: 'continue',
            onPressed: () {
              provider.getBuyproductList.clear();
              provider.addBuyProduct(widget.singleProduct);
              FirebaseFirestoreHelper.instance.uploadOrdersToFirebase(
                  provider.getBuyproductList,
                  groupvalue == 1 ? 'cash on delivery' : 'paid',
                  context);
            },
          )
        ],
      ),
    );
  }
}
