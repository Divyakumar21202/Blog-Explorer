import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:subspace/subspace/features/Blog%20Article/models/blog_model.dart';

Future<http.Response> fetchBlogs() async {
  const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  const String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  // return response;
  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });
   
      return response;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}
