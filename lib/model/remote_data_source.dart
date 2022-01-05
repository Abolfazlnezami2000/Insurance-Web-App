import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample_site_with_php_api/model/mode/admin_model.dart';
import 'package:sample_site_with_php_api/model/mode/data_model.dart';
import 'package:sample_site_with_php_api/model/mode/post_response_model.dart';
import 'package:sample_site_with_php_api/model/mode/user_response_model.dart';

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
    var body = json.encode({
      "username": username,
      "password": password,
      "email": email,
      "path": imagePath,
      "image": image,
      "date": date
    });

    Uri uri = Uri.parse('https://abolfazlnezami.ir/api/create_user.php');

    var response = await http.post(uri, body: body);
    print(response.body);
  } catch (e) {
    print(e);
  }
}

void editUser(
    {
      required String id,
      required String username,
      required String password,
      required String email,
      required String imagePath,
      required String date,
      required String image}) async {
  try {
    var body = json.encode({
      "id": id,
      "username": username,
      "password": password,
      "email": email,
      "path": imagePath,
      "image": image,
      "date": date
    });

    Uri uri = Uri.parse('https://abolfazlnezami.ir/api/edit_user.php');

    var response = await http.post(uri, body: body);
    print(response.body);
  } catch (e) {
    print(e);
  }
}

void createPost(
    {required String title,
      required String price,
      required String category,
      required String description,
      required String imagePath,
      required String image}) async {
  try {
    var body = json.encode({
      "title": title,
      "price": price,
      "category": category,
      "path": imagePath,
      "image": image,
      "description": description
    });

    Uri uri = Uri.parse('https://abolfazlnezami.ir/api/create_post.php');

    var response = await http.post(uri, body: body);
    print(response.body);
  } catch (e) {
    print(e);
  }
}

void editPost(
    {
      required String id,
      required String title,
      required String price,
      required String category,
      required String description,
      required String imagePath,
      required String image}) async {
  try {
    var body = json.encode({
      "id": id,
      "title": title,
      "price": price,
      "category": category,
      "path": imagePath,
      "image": image,
      "description": description
    });

    Uri uri = Uri.parse('https://abolfazlnezami.ir/api/edit_post.php');

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

void getAdminData(
    {required Function(List<AdminResponse> response) action}) async {
  try {
    Uri uri = Uri.parse('http://abolfazlnezami.ir/api/get_admin.php');

    var response = await http.get(uri);
    var jsonFeedback = jsonDecode(response.body) as List;
    List<AdminResponse> data =
        jsonFeedback.map((json) => AdminResponse.fromJson(json)).toList();
    action(data);
  } catch (e) {
    print(e);
  }
}

void getUserData(
    {required Function(List<UserResponseModel> response) action}) async {
  try {
    Uri uri = Uri.parse('http://abolfazlnezami.ir/api/get_user.php');

    var response = await http.get(uri);
    var jsonFeedback = jsonDecode(response.body) as List;
    List<UserResponseModel> data =
        jsonFeedback.map((json) => UserResponseModel.fromJson(json)).toList();
    action(data);
  } catch (e) {
    print(e);
  }
}

void getPostData(
    {required Function(List<PostResponseModel> response) action}) async {
  try {
    Uri uri = Uri.parse('http://abolfazlnezami.ir/api/get_post.php');

    var response = await http.get(uri);
    var jsonFeedback = jsonDecode(response.body) as List;
    List<PostResponseModel> data =
        jsonFeedback.map((json) => PostResponseModel.fromJson(json)).toList();
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

void deleteUser({required String id, required Function() action}) async {
  try {
    var body = json.encode({
      "id": id,
    });

    Uri uri = Uri.parse('http://abolfazlnezami.ir/api/delete_user.php');

    var response = await http.post(uri, body: body);
    print(response.body);
    action();
  } catch (e) {
    print(e);
  }
}

void deletePost({required String id, required Function() action}) async {
  try {
    var body = json.encode({
      "id": id,
    });

    Uri uri = Uri.parse('http://abolfazlnezami.ir/api/delete_post.php');

    var response = await http.post(uri, body: body);
    print(response.body);
    action();
  } catch (e) {
    print(e);
  }
}
