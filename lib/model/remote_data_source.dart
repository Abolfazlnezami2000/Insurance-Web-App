import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample_site_with_php_api/model/data_model.dart';

void sendData(
    {required String email,
    required String fullName,
    required String description}) async {
  try {
    var body = json.encode(
        {"email": email, "fullName": fullName, "description": description});

    Uri uri = Uri.parse('http://abolfazlnezami.ir/api/post_api.php');

    var response = await http.post(uri, body: body);
    print(response.body);
  } catch (e) {
    print(e);
  }
}

void createUser(
    {required String username,
      required String password,
      required String email,
      required String imagePath,
      required String date,
      required String image}) async {
  try {
    var body = json.encode(
        {"username": username,"password": password,"email": email,"path": imagePath,"image": image,"date": date});

    Uri uri = Uri.parse('https://abolfazlnezami.ir/api/create_user.php');

    var response = await http.post(uri, body: body);
    print(response.body);
  } catch (e) {
    print(e);
  }
}

void getData({required Function(List<DataResponse> response) action}) async {
  try {
    Uri uri = Uri.parse('http://abolfazlnezami.ir/api/get_api.php');

    var response = await http.get(uri);

    var jsonFeedback = jsonDecode(response.body) as List;
    List<DataResponse> data =
        jsonFeedback.map((json) => DataResponse.fromJson(json)).toList();
    action(data);
  } catch (e) {
    print(e);
  }
}

void deleteData({required String id, required Function() action}) async {
  try {
    var body = json.encode({
      "id": id,
    });

    Uri uri = Uri.parse('http://abolfazlnezami.ir/api/delete_api.php');

    var response = await http.post(uri, body: body);
    print(response.body);
    action();
  } catch (e) {
    print(e);
  }
}
