import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_site_with_php_api/page/about_page.dart';
import 'package:sample_site_with_php_api/page/contact_page.dart';
import 'package:sample_site_with_php_api/page/home_page.dart';
import 'package:sample_site_with_php_api/page/login_page.dart';

Widget appBar() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40,
          width: 100,
          child: Center(
              child: IconButton(
                  onPressed: () =>Get.to(const AdminPage()),
                  icon: const Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Colors.amber,
                  ))),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(ContactUs());
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(20),
                child: const Center(child: Text('Contact US')),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(AboutUs());
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(20),
                child: const Center(child: Text('About Us')),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(const HomePage());
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(20),
                child: const Center(child: Text('Home')),
              ),
            ),
          ],
        ),
      ],
    );
