import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/authentication/model/user_model.dart';
import 'package:productive_families_admin/application/other/screens/profile/profile_screen.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/application/stores/screens/create_store.dart';
import 'package:productive_families_admin/application/widgets/input_form_button.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel?>(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return const Text('no data');
              } else {
                UserModel userModel = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Welcom',
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen1(),
                                  ),
                                );
                              },
                              child: Text(
                                userModel.name ?? "",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: userModel.store != null,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 100,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            child: Row(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FutureBuilder<String>(
                                    future: getImageUrl(
                                        userModel.store!.storeImage ?? ""),
                                    builder: (context, snapshot) {
                                      return Image.network(
                                        snapshot.data ?? "",
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, exception, stackTrace) {
                                          if (exception is HttpException) {
                                            return Image.asset(
                                              'assets/images/profile.png'
                                              "",
                                              fit: BoxFit.fill,
                                            );
                                          } else {
                                            return Image.asset(
                                              'assets/images/profile.png',
                                              fit: BoxFit.fill,
                                            );
                                          }
                                        },
                                        frameBuilder:
                                            (context, child, frame, loaded) {
                                          if (frame != null) {
                                            return child;
                                          } else {
                                            return Shimmer.fromColors(
                                              baseColor:
                                                  Colors.grey.withOpacity(0.8),
                                              highlightColor:
                                                  Colors.grey.withOpacity(0.2),
                                              child: Container(
                                                  color: Colors.grey,
                                                  width: double.infinity),
                                            );
                                          }
                                        },
                                      );
                                    }),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.store!.storeName!,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                      child: Text(
                                    snapshot.data!.store!.desciption!,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ]),
                          )),
                      Visibility(
                          visible: userModel.store != null &&
                              userModel.store!.products != null,
                          child: const Row(
                            children: [
                              Text(
                                'Products',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      Visibility(
                        visible: userModel.store != null &&
                            userModel.store!.products != null,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(
                              parent: NeverScrollableScrollPhysics()),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.store!.products!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                  child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                height: 150,
                                                child: Column(children: [
                                                  const Expanded(
                                                    child: Row(children: [
                                                      Text(
                                                          "do you want to delete it?")
                                                    ]),
                                                  ),
                                                  Row(
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            deleteProductById(userModel
                                                                        .store!
                                                                        .products![
                                                                            index]
                                                                        .name ??
                                                                    "")
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {});
                                                            });
                                                          },
                                                          child:
                                                              const Text('ok')),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'cancel'))
                                                    ],
                                                  )
                                                ]),
                                              )),
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.more_horiz_outlined))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FutureBuilder<String>(
                                        future: getImageUrl(userModel.store!
                                                .products![index].image ??
                                            ""),
                                        builder: (context, snapshot) {
                                          return Image.network(
                                            snapshot.data ?? "",
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, exception,
                                                stackTrace) {
                                              if (exception is HttpException) {
                                                return Image.asset(
                                                  'assets/images/profile.png'
                                                  "",
                                                  fit: BoxFit.fill,
                                                );
                                              } else {
                                                return Image.asset(
                                                  userModel.store!.products!
                                                          .first.image ??
                                                      "",
                                                  fit: BoxFit.fill,
                                                );
                                              }
                                            },
                                            frameBuilder: (context, child,
                                                frame, loaded) {
                                              if (frame != null) {
                                                return child;
                                              } else {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey
                                                      .withOpacity(0.8),
                                                  highlightColor: Colors.grey
                                                      .withOpacity(0.2),
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
                                Expanded(
                                  child: Text(
                                    userModel.store!.products![index].name ??
                                        "",
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    userModel.store!.products![index]
                                            .description ??
                                        "",
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userModel.store!.products![index]
                                                      .price !=
                                                  null
                                              ? userModel
                                                  .store!.products![index].price
                                                  .toString()
                                              : "",
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.visible,
                                        ),
                                        Visibility(
                                            visible: Random().nextBool(),
                                            child: const Icon(
                                              Icons
                                                  .local_fire_department_rounded,
                                              color: Colors.amber,
                                            ))
                                      ]),
                                )
                              ]),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      Visibility(
                        visible: userModel.store == null,
                        child: InputFormButton(
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CreateStore(),
                                ));
                          },
                          titleText: "add Store",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
