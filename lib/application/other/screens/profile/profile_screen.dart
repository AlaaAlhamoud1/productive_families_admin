import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/authentication/model/user_model.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({Key? key}) : super(key: key);

  @override
  State<ProfileScreen1> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen1> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("profile"),
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: ListView(
                    children: [
                      const Hero(
                        tag: "C001",
                        child: CircleAvatar(
                          radius: 75.0,
                          backgroundImage:
                              AssetImage('assets/images/profile-picture.png'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Name:',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),

                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                            child: Text(
                              userModel.name ?? "",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Age:',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              userModel.age.toString() ?? "",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Email:',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),

                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                            child: Text(
                              userModel.email ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Gender:',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),

                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                            child: Text(
                              userModel.gender ?? "",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
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
      // bottomNavigationBar: SafeArea(
      //     child: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //   child: InputFormButton(onClick: () {}, titleText: language.update),
      // )),
    );
  }
}
