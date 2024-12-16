import 'dart:convert';
import 'package:github_wrapped/models/user_model.dart';
import 'package:http/http.dart' as http;
//import 'package:github_wrapped/models/github_data.dart'; // Import your GitHubData model

class ApiService {
  final String baseUrl =
      'https://github-wrapped-backend.vercel.app/github-wrapped/'; // Replace with the appropriate API base URL

  Future<GitHubData> fetchGitHubWrapped(String username) async {
    final response = await http.get(Uri.parse('$baseUrl$username'));

    if (response.statusCode == 200) {
      // If the response is successful, parse the JSON data and convert it to GitHubData
      return GitHubData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load GitHub data');
    }
  }
}
