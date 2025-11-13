import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "https://api.mydummyapi.com/posts";

  //get request to fetch posts
  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //post request to create a post
  Future<void> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body}),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
    } else {
      print('Sending: title=$title, body=$body');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
