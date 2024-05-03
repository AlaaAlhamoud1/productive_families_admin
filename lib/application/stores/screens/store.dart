import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productive_families_admin/application/products/models/product_model.dart';
import 'package:productive_families_admin/application/products/screens/products_screen.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/application/stores/models/ads_model.dart';
import 'package:productive_families_admin/application/stores/models/store_model.dart';
import 'package:productive_families_admin/application/widgets/input_form_button.dart';
import 'package:productive_families_admin/application/widgets/input_text_form_field.dart';
import 'package:productive_families_admin/core/colors.dart';
import 'package:productive_families_admin/core/data/local_data/shared_pref.dart';
import 'package:productive_families_admin/core/utils/common.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

List<ProductModel> products = [];
bool showProducts = false;
bool addProductVisible = false;
bool addAdsVisible = false;
TextEditingController name = TextEditingController();
TextEditingController price = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController amount = TextEditingController();
StoreModel? storeModel;
ProductModel? product;
late ImagePicker _picker;
XFile? _filePicked;
late ImagePicker _adsPicker;
XFile? _adsFilePicked;
List<String> type = ['food', 'beauty', 'handicrafts'];
String? selctedItem = 'food';
String? selected = 'food';

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<StoreModel?>(
        future: getStore(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final storeModel = snapshot.data;
            products = snapshot.data!.products ?? [];
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Storename:',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      Expanded(
                        child: Text(
                          storeModel!.storeName.toString(),
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color(0xff984979),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("add Product", style: TextStyle(fontSize: 20)),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            addProductVisible = true;
                          });
                        },
                        icon: const Icon(Icons.add_circle_rounded),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("add Ads", style: TextStyle(fontSize: 20)),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            addAdsVisible = true;
                          });
                        },
                        icon: const Icon(Icons.add_circle_rounded),
                      )
                    ],
                  ),
                  Visibility(
                    visible: addProductVisible,
                    child: Column(
                      children: [
                        InputTextFormField(
                          type: TextInputType.name,
                          controller: name,
                          hint: 'Name',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputFormButton(
                              onClick: () {
                                _pickImageAndSend();
                              },
                              titleText: "Add Product Image",
                            ),
                          ],
                        ),
                        InputTextFormField(
                          type: TextInputType.number,
                          hint: 'price',
                          controller: price,
                        ),
                        InputTextFormField(
                          type: TextInputType.name,
                          hint: "description",
                          controller: description,
                        ),
                        InputTextFormField(
                          type: TextInputType.number,
                          hint: "amount",
                          controller: amount,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "type",
                              style: TextStyle(
                                  color: AppColors.appColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                              value: selctedItem,
                              items: type
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                      )))
                                  .toList(),
                              onChanged: (item) {
                                setState(() {
                                  if (item == 'beauty') {
                                    selected = 'attention';
                                    selctedItem = item;
                                  } else {
                                    selctedItem = item;
                                    selected = item;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  addProductVisible = false;
                                });
                              },
                              icon: const Icon(
                                size: 35,
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                EasyLoading.show();
                                // await addProductsToList();
                                await addProduct(
                                        product: ProductModel(
                                            type: selected,
                                            image: _filePicked!.path,
                                            description: description.text,
                                            amount: int.tryParse(amount.text),
                                            name: name.text,
                                            price: int.tryParse(price.text),
                                            store: StoreModel(
                                              id: getStringAsync("STOREID"),
                                              activityType:
                                                  getStringAsync("STORENAME"),
                                              desciption: getStringAsync(
                                                  "ACTIVITYTYPE"),
                                              storeName:
                                                  getStringAsync("DESCRIPTION"),
                                            )),
                                        image: File(_filePicked!.path))
                                    .then((value) {
                                  EasyLoading.dismiss();
                                  toast('Product added Successfully');
                                  setState(() {
                                    addProductVisible = false;
                                  });
                                });
                              },
                              icon: Icon(
                                size: 35,
                                Icons.check_circle,
                                color: AppColors.appColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: addAdsVisible,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputFormButton(
                              onClick: () {
                                _pickAdsImageAndSend();
                              },
                              titleText: "Add ads",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  addAdsVisible = false;
                                });
                              },
                              icon: const Icon(
                                size: 35,
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await addAds(
                                    ads: AdsModel(image: _adsFilePicked!.path),
                                    image: File(_adsFilePicked!.path));
                              },
                              icon: Icon(
                                size: 35,
                                Icons.check_circle,
                                color: AppColors.appColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  snapshot.data!.products != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductsScreen(),
                                    ));
                              },
                              child: const Text(
                                "chech your Product",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text('don\'t have any products',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        )
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Future<void> _pickImageAndSend() async {
    _picker = ImagePicker();
    XFile? filePicked = await _picker.pickImage(source: ImageSource.gallery);
    _filePicked = filePicked;
  }

  Future<void> _pickAdsImageAndSend() async {
    _adsPicker = ImagePicker();
    XFile? filePicked = await _adsPicker.pickImage(source: ImageSource.gallery);
    _adsFilePicked = filePicked;
  }

  // Future<void> addProductsToList() async {
  //   products.add(ProductModel(
  //       name: name.text,
  //       price: int.tryParse(price.text),
  //       description: description.text,
  //       amount: int.tryParse(amount.text),
  //       image: _filePicked!.path));
  // }
}
