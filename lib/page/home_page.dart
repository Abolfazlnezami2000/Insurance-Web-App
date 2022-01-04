import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_site_with_php_api/widget/app_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          appBar(),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          Expanded(
            child: Image.asset(
              'images/image.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
