import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:productive_families_admin/application/authentication/model/user_model.dart';
import 'package:productive_families_admin/application/products/models/product_model.dart';
import 'package:productive_families_admin/application/stores/models/ads_model.dart';
import 'package:productive_families_admin/application/stores/models/store_model.dart';
import 'package:productive_families_admin/core/data/local_data/shared_pref.dart';

//user
Future createUser(
    {required String name,
    required int age,
    required String email,
    required String gender}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(email);
  final user = UserModel(
    id: email,
    name: name,
    age: age,
    email: email,
    gender: gender,
    // store: StoreModel(),
  );
  final json = user.toJson();
  await docUser.set(json).then((value) {
    setValue('ID', email);
    setValue('NAME', name);
    setValue('AGE', age);
    setValue('EMAIL', email);
  });
}

Future<UserModel?> getUser() async {
  final docUser =
      FirebaseFirestore.instance.collection('users').doc(getStringAsync("ID"));
  final snapshot = await docUser.get();
  if (snapshot.exists) {
    print(snapshot.exists);
    print(snapshot.data()!);
    return UserModel.fromJson(snapshot.data()!);
  } else {
    return null;
  }
}

Future<int> createStore({
  required String? storeName,
  required String? activityType,
  required String? description,
  File? storeImage,
}) async {
  final storageRef = FirebaseStorage.instance
      .ref()
      .child('store_images/${DateTime.now().millisecondsSinceEpoch}');
  final uploadTask = storageRef.putFile(storeImage!);
  final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() => null));
  final String imageUrl = await downloadUrl.ref.getDownloadURL();
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(getStringAsync('EMAIL'));
  final storeModel = StoreModel(
    id: ('${getStringAsync('EMAIL')} store').toString(),
    storeName: storeName,
    activityType: activityType,
    desciption: description,
    storeImage: imageUrl,
  );
  setValue('STOREID', storeModel.id);
  setValue('STORENAME', storeModel.storeName);
  setValue('ACTIVITYTYPE', storeModel.activityType);
  setValue('DESCRIPTION', storeModel.desciption);
  final json = storeModel.toJson();
  await setValue('STOREID', '${getStringAsync('EMAIL')} store');
  await docUser.update({'store': json});

  return 0;
}

Future<StoreModel?> getStore() async {
  final docUser =
      FirebaseFirestore.instance.collection('users').doc(getStringAsync("ID"));

  try {
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      final storeData = snapshot.data()?['store'];

      if (storeData != null) {
        print(snapshot.exists);
        print(storeData);
        return StoreModel.fromJson(storeData);
      }
    }
  } catch (e) {
    print("Error getting store: $e");
  }

  return null;
}

//store
Future<void> addProduct(
    {required ProductModel product, required File image}) async {
  final docUser =
      FirebaseFirestore.instance.collection('users').doc(getStringAsync('ID'));

  try {
    // Upload image to Firebase Storage

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('product_images/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = storageRef.putFile(image);
    final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    final String imagePath = storageRef.fullPath;

    product.image = imagePath;

    // Get current list of products
    final snapshot = await docUser.get();
    final List<dynamic> currentProducts =
        snapshot.data()?['store']['products'] ?? [];

    // Append the new product to the list
    product.image = imagePath;
    currentProducts.add(product.toJson());

    // Update Firestore document with the updated list of products
    await docUser.update({
      'store.products': currentProducts,
    });
  } catch (e) {
    print("Error adding product: $e");
  }
}

Future<void> addAds({required AdsModel ads, required File image}) async {
  final docUser =
      FirebaseFirestore.instance.collection('users').doc(getStringAsync('ID'));

  // Uploading image to Firebase Storage
  final storageRef = FirebaseStorage.instance
      .ref()
      .child('ads_images/${DateTime.now().millisecondsSinceEpoch}');
  final uploadTask = storageRef.putFile(image);
  final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
  final String imagePath = storageRef.fullPath;
  ads.image = imagePath;

  final Map<String, dynamic> adsMap = ads.toMap();

// Update Firestore document with the serialized AdsModel map
  await docUser.update({
    'store.ads': adsMap,
  });
}

Future updateStore({
  String? storeName,
  String? activityType,
  String? desciption,
  String? storeImage,
}) async {
  final docUser =
      FirebaseFirestore.instance.collection('store').doc('$storeName');
  final storeModel = StoreModel(
    id: docUser.id,
    storeName: storeName,
    activityType: activityType,
    desciption: desciption,
    storeImage: storeImage,
  );
  final json = storeModel.toJson();

  await setValue('DOC', storeName);
  await docUser.update(json);
}

// Define a function to get orders by user ID
Future<List<Map<String, dynamic>>> getOrdersByStoreId(String storeId) async {
  List<Map<String, dynamic>> userOrders = [];

  try {
    // Query the Firestore collection 'order' for orders matching the user ID
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where(storeId)
        // .where('id', isEqualTo: storeId)
        .get();

    // Iterate over the documents returned by the query
    for (var doc in querySnapshot.docs) {
      // Extract order data from each document
      Map<String, dynamic> orderData = {
        'orderId': doc.id,
        'user': doc['user'],
        'products': doc['products'],
        'status': doc['status'],
        'date': doc['date']
      };
      // Add the order data to the list
      userOrders.add(orderData);
    }

    // Return the list of orders matching the user ID
    print(userOrders);
    return userOrders;
  } catch (e) {
    // Handle any errors that occurred during the process
    print('Error fetching orders: $e');
    return []; // Return an empty list in case of error
  }
}

Future<void> deleteOrderByOrderId(String orderId) async {
  try {
    // Get the document reference for the order to delete
    final orderRef =
        FirebaseFirestore.instance.collection('order').doc(orderId);

    // Delete the document
    await orderRef.delete();

    print('Order deleted successfully');
  } catch (e) {
    print('Error deleting order: $e');
    // Handle any errors that occurred during the deletion process
    rethrow;
  }
}

Future<void> changeOrderStatus(
    {required String orderId, required String newStatus}) async {
  try {
    final orderRef =
        FirebaseFirestore.instance.collection('order').doc(orderId);

    // Update the order document with the new status
    await orderRef.update({
      'status': newStatus,
    });

    print('Order status updated successfully');
  } catch (e) {
    print('Error updating order status: $e');
    // Handle any errors that occurred during the update process
    // You can choose to throw an exception here or handle it accordingly
  }
}

Future<List<ProductModel?>> getRandomProducts() async {
  try {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<ProductModel?> allProducts = [];

    for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
      if (userSnapshot.exists) {
        final dynamic userData = userSnapshot.data();

        if (userData != null && userData['store'] != null) {
          final List<dynamic> productsData =
              userData['store']['products'] ?? [];

          // Convert productsData to a list of ProductModel
          List<ProductModel?> products = productsData
              .map((productData) => ProductModel.fromJson(productData))
              .toList();

          allProducts.addAll(products);
        }
      }
    }

    // Shuffle the list of products
    allProducts.shuffle();

    // Return the first two products (or fewer if there are fewer than two products)
    return allProducts.length >= 2 ? allProducts.sublist(0, 2) : allProducts;
  } catch (e) {
    print('Error fetching random products: $e');
    return [];
  }
}

Future<void> deleteProductById(String productId) async {
  try {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(getStringAsync('ID'));

    // Get the current list of products
    final snapshot = await userDoc.get();
    final List<dynamic> currentProducts =
        snapshot.data()?['store']['products'] ?? [];

    // Find the index of the product to delete
    int indexToDelete = -1;
    for (int i = 0; i < currentProducts.length; i++) {
      if (currentProducts[i]['name'] == productId) {
        indexToDelete = i;
        break;
      }
    }

    if (indexToDelete != -1) {
      // Remove the product from the list
      currentProducts.removeAt(indexToDelete);

      // Update Firestore document with the updated list of products
      await userDoc.update({
        'store.products': currentProducts,
      });

      print('Product with ID $productId deleted successfully');
    } else {
      print('Product with ID $productId not found');
    }
  } catch (e) {
    print('Error deleting product: $e');
  }
}
