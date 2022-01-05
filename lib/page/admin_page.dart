import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_site_with_php_api/core/value.dart';
import 'package:sample_site_with_php_api/model/mode/data_model.dart';
import 'package:sample_site_with_php_api/model/mode/post_response_model.dart';
import 'package:sample_site_with_php_api/model/mode/user_response_model.dart';
import 'package:sample_site_with_php_api/model/remote_data_source.dart';
import 'package:sample_site_with_php_api/page/add_post_page.dart';
import 'package:sample_site_with_php_api/page/add_user_page.dart';
import 'package:sample_site_with_php_api/widget/app_bar_widget.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class Menu {
  final String title;
  final Function action;

  Menu({required this.title, required this.action});
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isLoading = false;

  List<DataResponse> contactUsData = [];
  List<PostResponseModel> postData = [];
  List<UserResponseModel> userData = [];

  List<Menu> menu = <Menu>[];
  Widget child = Container();

  late Timer _timer;
  int _start = 5;

  void _fillMenu() {
    menu = <Menu>[
      Menu(
          title: "Contact Us",
          action: () {
            setState(() {
              isLoading = true;
            });
            getData(action: (List<DataResponse> response) {
              setState(() {
                contactUsData = response;
                isLoading = false;
                child = _showContactUsList();
              });
            });
          }),
      Menu(
          title: "User List",
          action: () {
            setState(() {
              isLoading = true;
            });
            getUserData(action: (List<UserResponseModel> response) {
              setState(() {
                userData = response;
                isLoading = false;
                child = _showUserList();
              });
            });
          }),
      Menu(
          title: "Post List",
          action: () {
            setState(() {
              isLoading = true;
            });
            getPostData(action: (List<PostResponseModel> response) {
              setState(() {
                postData = response;
                isLoading = false;
                child = _showPostList();
              });
            });
          }),
      Menu(
          title: "Add user",
          action: () {
            Get.to(CraeteUser(isAdmin: true));
          }),
      Menu(
          title: "Add post",
          action: () {
            Get.to(AddPostPage(isAdmin: true));
          }),
      Menu(
          title: "Logout",
          action: () {
            Get.back();
            Authentication.token = "";
          }),
    ];
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    if (Authentication.token.isNotEmpty) {
    print(Authentication.token);
    _fillMenu();
    startTimer();
    } else {
      _showMyDialog();
    }
    super.initState();
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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50, child: _showMenu()),
                const Divider(height: 5, color: Colors.black45),
                if (isLoading)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                      const CircularProgressIndicator(
                        color: Colors.blueAccent,
                        strokeWidth: 5,
                      ),
                    ],
                  )
                else
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    const oneMin = Duration(minutes: 1);
    _timer = Timer.periodic(
      oneMin,
      (Timer timer) {
        if (_start == 0) {
          Get.back();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Widget _showContactUsList() {
    return ListView.builder(
      itemCount: contactUsData.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            const Text("ID : "),
            Text(contactUsData[index].id + "  "),
            const Text(" | "),
            const Text("Email : "),
            Text(contactUsData[index].email + "  "),
            const Text(" | "),
            const Text("Full Name : "),
            Text(contactUsData[index].fullName + "  "),
            const Text(" | "),
            const Text("Description : "),
            Text(contactUsData[index].description + "  "),
            const Text(" | "),
            IconButton(
                onPressed: () {
                  deleteData(
                      id: contactUsData[index].id,
                      action: () {
                        getData(action: (List<DataResponse> response) {
                          setState(() {
                            contactUsData = response;
                            isLoading = false;
                          });
                        });
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            const Text(" | "),
          ],
        );
      },
    );
  }

  Widget _showUserList() {
    return ListView.builder(
      itemCount: userData.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(userData[index].image),
              ),
            ),
            const Text("   ID : "),
            Text(userData[index].id + "  "),
            const Text(" | "),
            const Text("Email : "),
            Text(userData[index].email + "  "),
            const Text(" | "),
            const Text("Username : "),
            Text(userData[index].username + "  "),
            const Text(" | "),
            const Text("Date : "),
            Text(userData[index].date + "  "),
            const Text(" | "),
            IconButton(
                onPressed: () => Get.to(CraeteUser(isAdmin: true,data: userData[index])),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blueAccent,
                )),
            const Text(" | "),
            IconButton(
                onPressed: () {
                  deleteUser(
                      id: userData[index].id,
                      action: () {
                        setState(() {
                          isLoading = true;
                        });
                        getUserData(action: (List<UserResponseModel> response) {
                          setState(() {
                            userData = response;
                            isLoading = false;
                            child = _showUserList();
                          });
                        });
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            const Text(" | "),
          ],
        );
      },
    );
  }

  Widget _showPostList() {
    return ListView.builder(
      itemCount: postData.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(300.0),
                child: Image.network(postData[index].image),
              ),
            ),
            const Text("    ID : "),
            Text(postData[index].id + "  "),
            const Text(" | "),
            const Text("Title : "),
            Text(postData[index].title + "  "),
            const Text(" | "),
            const Text("Price : "),
            Text(postData[index].price.toString() + "  "),
            const Text(" | "),
            const Text("Category : "),
            Text(postData[index].category + "  "),
            const Text(" | "),
            Expanded(
                child: Text("Description : " + postData[index].category + "  ",
                    overflow: TextOverflow.ellipsis)),
            IconButton(
                onPressed: () => Get.to(AddPostPage(isAdmin: true,data: postData[index])),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blueAccent,
                )),
            IconButton(
                onPressed: () {
                  deletePost(
                      id: postData[index].id,
                      action: () {
                        setState(() {
                          isLoading = true;
                        });
                        getPostData(action: (List<PostResponseModel> response) {
                          setState(() {
                            postData = response;
                            isLoading = false;
                            child = _showPostList();
                          });
                        });
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        );
      },
    );
  }

  Widget _showMenu() {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: menu.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => menu[index].action(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        menu[index].title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              "Timer : $_start Min",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  void _showMyDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Auth Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please Login'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Get.offAll(const HomePage());
              },
            ),
          ],
        );
      },
    );
  }
}
