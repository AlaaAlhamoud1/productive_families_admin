import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/authentication/model/user_model.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4AC382),
        title: const Text("Profile"),
      ),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'NAME:',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                            // const SizedBox(
                            //   width: 20,
                            // ),
                            Expanded(
                              child: Text(
                                userModel.name ?? "",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Age:',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                userModel.age.toString() ?? "",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Email:',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                userModel.email ?? "",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Gender:',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                            // const SizedBox(
                            //   width: 20,
                            // ),
                            Expanded(
                              child: Text(
                                userModel.gender ?? "",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Stores:',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                            // const SizedBox(
                            //   width: 20,
                            // ),
                            Expanded(
                              child: Text(
                                1.toString() ?? "",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'edit Profile:',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                            // const SizedBox(
                            //   width: 20,
                            // ),
                            Expanded(
                                child: IconButton(
                              color: const Color(0xFF4AC382),
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Delete Account:',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                            // const SizedBox(
                            //   width: 20,
                            // ),
                            Expanded(
                                child: IconButton(
                              color: const Color.fromARGB(255, 210, 9, 9),
                              icon: const Icon(Icons.cancel_rounded),
                              onPressed: () {},
                            )),
                          ],
                        )
                      ],
                    ),
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
}
