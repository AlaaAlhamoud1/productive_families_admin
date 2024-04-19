class AdsModel {
  String? image;

  AdsModel({
    this.image,
  });

  AdsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      // Add other properties if needed
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['image'] = image;
    return data;
  }
}
