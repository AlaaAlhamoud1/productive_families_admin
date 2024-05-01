import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/products/widgets/products_card.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/application/stores/models/store_model.dart';
import 'package:productive_families_admin/core/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Text("Products"),
      ),
      body: FutureBuilder<StoreModel?>(
          future: getStore(),
          builder: (BuildContext context, AsyncSnapshot<StoreModel?> snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return const Text('no data');
              } else {
                StoreModel storeModel = snapshot.data!;
                return Center(
                  child: Column(
                    children: [
                      Row(children: [
                        const Text(
                          'Products count:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Expanded(
                          child: Text("${storeModel.products!.length}",
                              style: const TextStyle(fontSize: 20)),
                        )
                      ]),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.separated(
                            shrinkWrap: false,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProductWidget(
                                product: storeModel.products![index],
                              ),
                            ),
                            itemCount: storeModel.products!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text('Error'); // error
            } else {
              return const Center(
                  child: CircularProgressIndicator()); // loading
            }
          }),
    );
  }
}
