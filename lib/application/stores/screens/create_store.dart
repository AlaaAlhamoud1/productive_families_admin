import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/application/widgets/input_form_button.dart';
import 'package:productive_families_admin/application/widgets/input_text_form_field.dart';
import 'package:productive_families_admin/core/utils/common.dart';

class CreateStore extends StatefulWidget {
  const CreateStore({super.key});

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  late ImagePicker _picker;
  XFile? _filePicked;
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController storeName = TextEditingController();
  TextEditingController activityType = TextEditingController();
  TextEditingController desciption = TextEditingController();
  TextEditingController storeImage = TextEditingController();
  String? _chosenModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Store"),
        backgroundColor: const Color(0xFF4AC382),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Row(
              //   children: [
              //     Text(
              //       "Seller information",
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     )
              //   ],
              // ),
              // InputTextFormField(
              //   controller: name,
              //   hint: 'Name',
              // ),
              // InputTextFormField(
              //   hint: 'age',
              //   controller: age,
              // ),
              // InputTextFormField(
              //   hint: " Phone Number",
              //   controller: phoneNumber,
              // ),
              // InputTextFormField(
              //   hint: "Email",
              //   controller: email,
              // ),
              const Row(
                children: [
                  Text(
                    "Store information",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              InputTextFormField(
                controller: storeName,
                hint: 'Store Name',
              ),
              InputTextFormField(
                hint: 'activity type',
                controller: activityType,
              ),
              InputTextFormField(
                hint: "description",
                controller: desciption,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputFormButton(
                    onClick: () {
                      _pickImageAndSend();
                    },
                    titleText: "Add Logo",
                  ),
                ],
              ),
              DropdownButton<String>(
                value: _chosenModel,
                items: <String>['visa card 1', 'visa card 2 ', 'visa card 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _chosenModel = newValue!;
                  });
                },
                hint: const Text(
                  "Choose a Payment Type",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Choose Location",
                      style: TextStyle(
                        color: Color(0xFF4AC382),
                      )),
                  Icon(
                    Icons.location_on_rounded,
                    color: Color(0xFF4AC382),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      size: 35,
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      EasyLoading.show();
                      if (storeName.text != '' &&
                          activityType.text != '' &&
                          desciption.text != '') {
                        await createStore(
                          storeName: storeName.text,
                          activityType: activityType.text,
                          description: desciption.text,
                          storeImage: File(_filePicked!.path) ?? File(''),
                        ).then(
                          (value) {
                            toast("Store Added Successfully");
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        EasyLoading.dismiss();
                        toast('error');
                      }
                    },
                    icon: const Icon(
                      size: 35,
                      Icons.check_circle,
                      color: Color(0xFF4AC382),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageAndSend() async {
    _picker = ImagePicker();

    XFile? filePicked = await _picker.pickImage(source: ImageSource.gallery);
    _filePicked = filePicked;
  }
}
