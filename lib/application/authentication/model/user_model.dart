import 'package:productive_families_admin/application/stores/models/store_model.dart';
import 'package:productive_families_admin/core/data/local_data/shared_pref.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  int? age;
  StoreModel? store;
  String? gender;
  String? location;
  UserModel(
      {this.id,
      this.name,
      this.email,
      this.age,
      this.store,
      this.gender,
      required this.location});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'age': age,
        'store': store,
        'gender': gender,
        'location': location
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
    if (json['location'] != null) {
      location = json['location'];
    } else {
      location = null;
    }
    setValue('ID', email);
    setValue('NAME', name);
    setValue('AGE', age.toString());
    setValue('EMAIL', email);
    setValue('GENDER', gender);
    setValue('LOCATION', location);
  }
}
