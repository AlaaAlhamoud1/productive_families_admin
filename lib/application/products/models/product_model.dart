import '../../stores/models/store_model.dart';

class ProductModel {
  String? id;
  String? name;
  String? image;
  String? description;
  int? price;
  int? amount;
  String? type;
  StoreModel? store;
  ProductModel(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.price,
      this.amount,
      this.store,
      required this.type});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'description': description,
        'price': price,
        'amount': amount,
        'type': type,
        'store': store!.toJson()
      };
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    amount = json['amount'];
    type = json['type'];
    if (json['store'] != null) {
      store = StoreModel.fromJson(json['store']);
    } else {
      store = null;
    }
  }
}
