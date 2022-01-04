import 'package:flutter/material.dart';

Widget textField({
  required String text,
  required TextEditingController controller,
  required String value,
  required Function(String?)? validator,

}) =>
    Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextFormField(
        controller: controller,
        validator: (val) => validator!(val),
        onSaved: (val) => value = val!,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: text,
          hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
