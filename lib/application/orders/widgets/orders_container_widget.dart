import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/orders/models/orders_model.dart';
import 'package:productive_families_admin/core/colors.dart';
import 'package:shimmer/shimmer.dart';

class OrdersContainerWidget extends StatelessWidget {
  final OrderModel ordersModel;

  const OrdersContainerWidget({
    Key? key,
    required this.ordersModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.appColor.withOpacity(0.7)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FutureBuilder<String>(
                        future: getImageUrl(
                            ordersModel.products!.first.image ?? ""),
                        builder: (context, snapshot) {
                          return Image.network(
                            snapshot.data ?? "",
                            fit: BoxFit.fill,
                            errorBuilder: (context, exception, stackTrace) {
                              if (exception is HttpException) {
                                return Image.asset(
                                  ordersModel.products!.first.image ?? "",
                                  fit: BoxFit.fill,
                                );
                              } else {
                                return Image.asset(
                                  ordersModel.products!.first.image ?? "",
                                  fit: BoxFit.fill,
                                );
                              }
                            },
                            frameBuilder: (context, child, frame, loaded) {
                              if (frame != null) {
                                return child;
                              } else {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.8),
                                  highlightColor: Colors.grey.withOpacity(0.2),
                                  child: Container(
                                      color: Colors.grey,
                                      width: double.infinity),
                                );
                              }
                            },
                          );
                        }),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 75,
                  child: Text(
                    "" ?? '',
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Montserrat-B",
                      fontSize: 12,
                      color: AppColors.appColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "date",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat-M",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.date_range,
                  color: AppColors.appColor,
                  size: 24,
                ),
                Text(
                  ordersModel.date!.substring(0, 10) ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Montserrat-M",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "time",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat-M",
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.timelapse,
                  size: 24,
                  color: AppColors.appColor,
                ),
                Text(
                  ordersModel.date!.substring(11, 16) ?? '',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontFamily: "Montserrat-M",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: (ordersModel.status == 'pending')
                  ? Colors.deepOrange
                  : (ordersModel.status == 'Delivery in progress' ||
                          ordersModel.status == 'Delivered')
                      ? Colors.amber
                      : (ordersModel.status == 'Implemented' ||
                              ordersModel.status == 'Underway')
                          ? Colors.green
                          : Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getImageUrl(String imagePath) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(imagePath);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print("Error getting image URL: $e");
      return ""; // Return an empty string or some default URL in case of an error
    }
  }
}
