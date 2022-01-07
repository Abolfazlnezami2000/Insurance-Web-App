import 'package:flutter/material.dart';
import 'package:sample_site_with_php_api/model/mode/post_response_model.dart';
import 'package:sample_site_with_php_api/widget/app_bar_widget.dart';

class PostDetialPage extends StatefulWidget {
  final bool isAdmin;
  final PostResponseModel data;

  const PostDetialPage({Key? key, required this.isAdmin, required this.data})
      : super(key: key);

  @override
  State<PostDetialPage> createState() => _PostDetialPageState();
}

class _PostDetialPageState extends State<PostDetialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAdmin ? AppBar() : null,
      body: Column(
        children: [
          if (!widget.isAdmin) appBar(),
          if (!widget.isAdmin)
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Title :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                          Text(
                            widget.data.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          const Text(
                            "Category :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                          Text(
                            widget.data.category,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          const Text(
                            "Price",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                          Text(
                            widget.data.price,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Image.network(widget.data.image),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  const Divider(height: 3, color: Colors.black),
                  Text(
                    widget.data.description,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
