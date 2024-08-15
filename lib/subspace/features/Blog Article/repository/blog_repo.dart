import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchBlogs() async {
  String url = dotenv.env['url'] as String;
  String adminSecret = dotenv.env['adminSecret'] as String;
  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });
    return response;
  } catch (e) {
    rethrow;
  }
}
