import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_site_with_php_api/model/mode/post_response_model.dart';
import 'package:sample_site_with_php_api/model/remote_data_source.dart';
import 'package:sample_site_with_php_api/widget/app_bar_widget.dart';
import 'package:sample_site_with_php_api/widget/textfiled_widget.dart';

class AddPostPage extends StatefulWidget {
  final bool isAdmin;
  final PostResponseModel? data;

  const AddPostPage({Key? key, required this.isAdmin, this.data})
      : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String title = '';
  String price = '';
  String category = '';
  String description = '';

  String imageText = 'Upload Image +';
  String imageBase64 = '';

  void _submitCommand() {
    final form = formKey.currentState;
    if (form!.validate()) {
      if (imageBase64.isNotEmpty) {
        if (widget.data != null) {
          editPost(id: widget.data!.id,
              title: _titleController.text,
              price: _priceController.text,
              category: _categoryController.text,
              description: _descriptionController.text,
              imagePath: imageText,
              image: imageBase64);
          Get.snackbar("Message", "Post edit Successfully");
        } else {
          createPost(
              title: _titleController.text,
              price: _priceController.text,
              category: _categoryController.text,
              description: _descriptionController.text,
              imagePath: imageText,
              image: imageBase64);
          Get.snackbar("Message", "Post create Successfully");
        }
      } else {
        Get.snackbar("Error", "image not valid");
      }
    }
  }

  @override
  void initState() {
    if (widget.data != null) {
      _titleController.text = widget.data!.title;
      _priceController.text = widget.data!.price;
      _categoryController.text = widget.data!.category;
      _descriptionController.text = widget.data!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAdmin ? AppBar() : null,
      body: Column(
        children: [
          if(!widget.isAdmin)
            appBar(),
          if(!widget.isAdmin)
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
                        'Create Post',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      textField(
                        text: "Please Enter Title",
                        value: title,
                        controller: _titleController,
                        validator: (val) {
                          if (val!.length > 30) {
                            return 'Not a valid title.';
                          } else if (val.isEmpty) {
                            return "Please enter value";
                          }
                        },
                      ),
                      textField(
                        text: "Please Enter Price",
                        value: price,
                        controller: _priceController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter value';
                          } else if (int.tryParse(val) == null) {
                            return 'Please enter only number';
                          }
                        },
                      ),
                      textField(
                        text: "Please Enter category",
                        value: category,
                        controller: _categoryController,
                        validator: (val) {
                          if (val == null) {
                            return 'please fill field';
                          }
                        },
                      ),
                      textField(
                        text: "Please Enter description",
                        value: description,
                        controller: _descriptionController,
                        validator: (val) {
                          if (val == null) {
                            return 'please fill field';
                          }
                        },
                      ),
                      Center(
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
      } else {
        Get.snackbar("Error", "image not valid");
      }
    }
  }
}
