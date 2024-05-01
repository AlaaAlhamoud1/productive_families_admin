import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/products/models/product_model.dart';
import 'package:productive_families_admin/application/products/widgets/products_card.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/core/colors.dart';

class MostOrderedProductsScreen extends StatefulWidget {
  const MostOrderedProductsScreen({super.key});

  @override
  State<MostOrderedProductsScreen> createState() =>
      _MostOrderedProductsScreenState();
}

class _MostOrderedProductsScreenState extends State<MostOrderedProductsScreen> {
  List list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Text(
          "Most Ordered Products",
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: FutureBuilder(
        future: getRandomProducts(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            list = snapshot.data as List<ProductModel?>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(
                    snapshot.data!.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductWidget(product: snapshot.data![index]),
                        )),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
