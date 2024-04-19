import 'package:productive_families_admin/application/products/models/product_model.dart';

class OrderModel {
  String? orderId;
  User? user;
  List<ProductModel>? products;
  String? status;
  String? date;

  OrderModel({this.orderId, this.user, this.products, this.status, this.date});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json["orderId"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    products = json["products"] == null
        ? null
        : (json["products"] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
    status = json["status"];
    date = json["date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["orderId"] = orderId;
    if (user != null) {
      data["user"] = user?.toJson();
    }
    if (products != null) {
      data["products"] = products?.map((e) => e.toJson()).toList();
    }
    data["status"] = status;
    data["date"] = date;
    return data;
  }
}

// class Products {
//   String? image;
//   int? amount;
//   int? price;
//   String? name;
//   String? description;
//   dynamic id;
//   Store? store;

//   Products(
//       {this.image,
//       this.amount,
//       this.price,
//       this.name,
//       this.description,
//       this.id,
//       this.store});

//   Products.fromJson(Map<String, dynamic> json) {
//     image = json["image"];
//     amount = json["amount"];
//     price = json["price"];
//     name = json["name"];
//     description = json["description"];
//     id = json["id"];
//     store = json["store"] == null ? null : Store.fromJson(json["store"]);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["image"] = image;
//     data["amount"] = amount;
//     data["price"] = price;
//     data["name"] = name;
//     data["description"] = description;
//     data["id"] = id;
//     if (store != null) {
//       data["store"] = store?.toJson();
//     }
//     return data;
//   }
// }

class Store {
  dynamic storeImage;
  String? description;
  String? storeName;
  String? id;
  String? activityType;
  dynamic products;

  Store(
      {this.storeImage,
      this.description,
      this.storeName,
      this.id,
      this.activityType,
      this.products});

  Store.fromJson(Map<String, dynamic> json) {
    storeImage = json["storeImage"];
    description = json["description"];
    storeName = json["storeName"];
    id = json["id"];
    activityType = json["activityType"];
    products = json["products"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["storeImage"] = storeImage;
    data["description"] = description;
    data["storeName"] = storeName;
    data["id"] = id;
    data["activityType"] = activityType;
    data["products"] = products;
    return data;
  }
}

class User {
  String? gender;
  String? name;
  String? id;
  dynamic store;
  String? email;
  int? age;

  User({this.gender, this.name, this.id, this.store, this.email, this.age});

  User.fromJson(Map<String, dynamic> json) {
    gender = json["gender"];
    name = json["name"];
    id = json["id"];
    store = json["store"];
    email = json["email"];
    age = json["age"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["gender"] = gender;
    data["name"] = name;
    data["id"] = id;
    data["store"] = store;
    data["email"] = email;
    data["age"] = age;
    return data;
  }
}
