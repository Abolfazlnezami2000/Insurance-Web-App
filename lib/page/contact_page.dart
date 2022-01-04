import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_site_with_php_api/model/remote_data_source.dart';
import 'package:sample_site_with_php_api/widget/app_bar_widget.dart';
import 'package:sample_site_with_php_api/widget/textfiled_widget.dart';

class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final descriptionController = TextEditingController();

  String _email = '';
  String _fullName = '';
  String _description = '';

  void _submitCommand() {
    final form = formKey.currentState;
    if (form!.validate()) {
      sendData(
          email: _emailController.text,
          fullName: fullNameController.text,
          description: descriptionController.text);
      Get.snackbar("Message", "Message Sent Successfully");
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
                height: 450,
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
                        'Contact Form',
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
                          } else if (val.isEmpty){
                            return "Please enter value";
                          }
                        },
                      ),
                      textField(
                          text: "Please Enter Full Name",
                          value: _fullName,
                          controller: fullNameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter value';
                          } else if (val.length <=5){
                            return "Full name too short..";
                          }
                        },
                      ),
                      textField(
                        text: "Please Enter your description",
                        value: _description,
                        controller: descriptionController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter value';
                          } else if (val.length <=20){
                            return "description too short..";
                          }
                        },
                      ),
                      InkWell(
                        onTap: ()=> _submitCommand(),
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
}
