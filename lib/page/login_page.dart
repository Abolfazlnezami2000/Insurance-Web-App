import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_site_with_php_api/core/value.dart';
import 'package:sample_site_with_php_api/model/mode/admin_model.dart';
import 'package:sample_site_with_php_api/model/remote_data_source.dart';
import 'package:sample_site_with_php_api/page/admin_page.dart';
import 'package:sample_site_with_php_api/widget/app_bar_widget.dart';
import 'package:uuid/uuid.dart';

import 'add_user_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                height: 450,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.amber,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sing in',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueAccent,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Username",
                          hintStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueAccent,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
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
                    InkWell(
                      onTap: () => Get.to(CraeteUser(isAdmin: false)),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Sign up"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitCommand() {
    try{
      getAdminData(action: (List<AdminResponse> response) {
        var password = utf8.encode(_passwordController.text);
        String hashPassword = sha256.convert(password).toString();
        AdminResponse? exist = response.firstWhere((element) =>
        _usernameController.text == element.username &&
            hashPassword == element.password);
        if (exist != null) {
          Authentication.token = const Uuid().v1();
          Get.to(const AdminPage());
        } else {
          Get.snackbar("Error", "Error");
        }
      });
    }catch(e){
      Get.snackbar("Error", "Error");
    }
  }
}
