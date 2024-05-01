import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/authentication/model/user_model.dart';
import 'package:productive_families_admin/application/home/settings_screen.dart';
import 'package:productive_families_admin/application/orders/screens/orders_sreen.dart';
import 'package:productive_families_admin/application/other/most_ordered.dart';
import 'package:productive_families_admin/application/other/screens/profile/profile_screen.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/auth.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/other_item_card.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Hero(
                  tag: "C001",
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                        AssetImage('assets/images/profile-picture.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(width: 12),
                FutureBuilder<UserModel?>(
                    future: getUser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<UserModel?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return const Text('no data');
                        } else {
                          UserModel userModel = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width / 2,
                                    child: Text(
                                      userModel.name ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: size.width / 2,
                                      child: Text(
                                        userModel.email ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ],
                              )
                            ],
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return const Text('Error'); // error
                      } else {
                        return Expanded(
                            child: Column(
                          children: [
                            shimmer(height: 10, horizontalPadding: 10),
                            shimmer(
                                height: 10,
                                horizontalPadding: 10,
                                verticalPadding: 10),
                          ],
                        ));
                      }
                    }),
              ],
            ),
          ),
          const SizedBox(height: 30),
          OtherItemCard(
            image: 'assets/images/profile.png',
            onClick: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen1(),
                  ));
              // Navigator.of(context).pushNamed(AppRouter.profile);
            },
            title: 'profile',
          ),
          const SizedBox(height: 6),
          OtherItemCard(
            image: 'assets/images/setting.png',
            onClick: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ));
              // Navigator.of(context).pushNamed(AppRouter.settings);
            },
            title: "settings",
          ),
          const SizedBox(height: 6),
          OtherItemCard(
            image: 'assets/images/orders.png',
            onClick: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersTabScreen(),
                  ));
              // Navigator.of(context).pushNamed(AppRouter.settings);
            },
            title: "orders",
          ),
          const SizedBox(height: 6),
          OtherItemCard(
            image: 'assets/images/star.png',
            onClick: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MostOrderedProductsScreen(),
                  ));
            },
            title: "mostOrderedProducts",
          ),
          const SizedBox(height: 6),
          OtherItemCard(
            image: 'assets/images/logout.png',
            onClick: () {
              Auth().signOut();
            },
            title: "Logout",
          ),
        ],
      ),
    );
  }

  Widget shimmer(
      {int? verticalPadding, int? horizontalPadding, required double height}) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (horizontalPadding ?? 0.0).toDouble(),
            vertical: (verticalPadding ?? 0).toDouble()),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.8),
          highlightColor: Colors.grey.withOpacity(0.2),
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: height,
              width: double.infinity),
        ));
  }
}
