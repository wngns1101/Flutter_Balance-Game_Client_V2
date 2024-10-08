import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// 서버 baseUrl
final baseUrl = dotenv.env['BASE_URL'];

/// 신고 레포지토리
class ReportRepository {
  /// 리뷰 신고 메서드
  Future<bool> reviewReport(String token, int boardReviewId, String content) async {
    final url = Uri.parse('$baseUrl/board/v2/boards/$boardReviewId/report');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'utf-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'content': content}),
      );

      print('(api)response : $boardReviewId');
      print('(api)response : $content');
      if (response.statusCode == 200) {
        print('(api)유저 신고 성공');
        return true;
      } else {
        print('(api)유저 신고 실패!');
        throw HttpException('Failed to report review: ${response.statusCode}');
      }
    } catch (error) {
      // 여기서 추가적인 예외 처리를 할 수 있습니다.
      print('Exception occurred: $error');
      rethrow; // 예외를 다시 던져서 컨트롤러에서 처리할 수 있게 합니다.
    }
  }
}
