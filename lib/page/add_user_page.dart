import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_site_with_php_api/model/remote_data_source.dart';
import 'package:sample_site_with_php_api/widget/app_bar_widget.dart';
import 'package:sample_site_with_php_api/widget/textfiled_widget.dart';

class CraeteUser extends StatefulWidget {
  CraeteUser({Key? key}) : super(key: key);

  @override
  State<CraeteUser> createState() => _CraeteUserState();
}

class _CraeteUserState extends State<CraeteUser> {
  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _emailController = TextEditingController();

  final fullNameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _passwordAgianController = TextEditingController();

  String _email = '';

  String _fullName = '';

  String _password = '';

  String _passwordAgain = '';

  String imageText = 'Upload Image +';
  String imageBase64 = '';

  void _submitCommand() {
    final form = formKey.currentState;
    if (form!.validate()) {
      if (imageBase64.isNotEmpty) {
        var password = utf8.encode(_passwordController.text);
        String hashPassword = sha256.convert(password).toString();
        createUser(
            username: fullNameController.text,
            password: hashPassword,
            email: _emailController.text,
            imagePath: imageText,
            date: DateTime.now().toString(),
            image: imageBase64);
        Get.snackbar("Message", "User create Successfully");
      }else{
        Get.snackbar("Error", "image not valid");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          appBar(),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.amber,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Create User',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      textField(
                        text: "Please Enter Email Address",
                        value: _email,
                        controller: _emailController,
                        validator: (val) {
                          if (!EmailValidator.validate(val!, true)) {
                            return 'Not a valid email.';
                          } else if (val.isEmpty) {
                            return "Please enter value";
                          }
                        },
                      ),
                      textField(
                        text: "Please Enter Username",
                        value: _fullName,
                        controller: fullNameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter value';
                          } else if (val.length <= 5) {
                            return "Full name too short..";
                          }
                        },
                      ),
                      textField(
                        text: "Please Enter your password",
                        value: _password,
                        controller: _passwordController,
                        validator: (val) {
                          bool passValid = RegExp(
                                  "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
                              .hasMatch(val ?? "");
                          if (val == null) {
                            return 'please fill field';
                          } else if (val.length < 8) {
                            return 'min 8 word';
                          } else if (val.length > 12) {
                            return 'max 12 word';
                          } else if (!passValid) {
                            return 'not valid password';
                          }
                        },
                      ),
                      textField(
                        text: "Please Enter your password Again",
                        value: _passwordAgain,
                        controller: _passwordAgianController,
                        validator: (val) {
                          if (val == null) {
                            return 'please fill field';
                          } else if (val != _passwordController.text) {
                            return "password is not equal";
                          }
                        },
                      ),
                      Center(
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueAccent),
                              child: Text(
                                imageText,
                                style: const TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () => _submitCommand(),
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Center(
                            child: Text(
                              "Send",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (image.mimeType == "image/png") {
        Uint8List byte = await image.readAsBytes();
        imageBase64 = base64Encode(byte);
        setState(() {
          imageText = image.name;
        });
      }else{
        Get.snackbar("Error", "image not valid");
      }
    }
  }
}
