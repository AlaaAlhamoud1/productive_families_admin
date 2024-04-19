import 'package:productive_families_admin/application/stores/models/store_model.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  int? age;
  StoreModel? store;
  String? gender;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.age,
    this.store,
    this.gender,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'age': age,
        'store': store,
        'gender': gender,
      };

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    age = json['age'];
    if (json['store'] != null) {
      store = StoreModel.fromJson(json['store']);
    } else {
      store = null;
    }
    gender = json['gender'];
  }
}
