import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/model/theme/list_theme_response.dart';
import 'package:yangjataekil/theme/app_color.dart';

import 'package:http/http.dart' as http;

final baseUrl = dotenv.env['BASE_URL'];

class ThemeRepository {
  Future<ListThemeResponse> getList() async {
    final url = Uri.parse('$baseUrl/common/v2/themes');

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    print('테마 조회 응답: ${utf8.decode(response.bodyBytes)}');
    if (response.statusCode == 200) {
      return ListThemeResponse.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('테마 조회 실패 ${response.statusCode}');
    }
  }
}
