import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sample_site_with_php_api/model/data_model.dart';
import 'package:sample_site_with_php_api/model/remote_data_source.dart';
import 'package:sample_site_with_php_api/widget/app_bar_widget.dart';
import 'package:get/get.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({Key? key}) : super(key: key);

  @override
  _DatabasePageState createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  bool isLoading = true;
  List<DataResponse> data = [];

  late Timer _timer;
  int _start = 15;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getData(action: (List<DataResponse> response) {
      setState(() {
        data = response;
        isLoading = false;
        startTimer();
      });
    });
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          const Text("ID : "),
                          Text(data[index].id + "  "),
                          const Text(" | "),
                          const Text("Email : "),
                          Text(data[index].email + "  "),
                          const Text(" | "),
                          const Text("Full Name : "),
                          Text(data[index].fullName + "  "),
                          const Text(" | "),
                          const Text("Description : "),
                          Text(data[index].description + "  "),
                          const Text(" | "),
                          IconButton(
                              onPressed: () {
                                deleteData(
                                    id: data[index].id,
                                    action: () {
                                      getData(action:
                                          (List<DataResponse> response) {
                                        setState(() {
                                          data = response;
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
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Center(child: Text("Admin",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: InkWell(onTap: (){Get.back();},child: Center(child: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueAccent),))),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Center(child: Text("Timer : $_start",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
