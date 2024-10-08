import 'dart:io';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/review.dart';

import '../data/provider/report_repository.dart';
import '../data/provider/review_list_repository.dart';

/// 신고 카테고리
enum REPORTCATEGORY {
  abusiveLanguage, // 욕설
  falseInformation, // 허위사실
  advertising, // 광고성
  spam, // 스팸
  personalInformationExposure, // 개인정보노출
  others, // 기타
}

/// 신고 카테고리 확장 - 문자열 반환
extension ReportCategoryExtension on REPORTCATEGORY {
  String get displayName {
    switch (this) {
      case REPORTCATEGORY.abusiveLanguage:
        return "욕설";
      case REPORTCATEGORY.falseInformation:
        return "허위사실";
      case REPORTCATEGORY.advertising:
        return "광고성";
      case REPORTCATEGORY.spam:
        return "스팸";
      case REPORTCATEGORY.personalInformationExposure:
        return "개인정보노출";
      case REPORTCATEGORY.others:
        return "기타";
    }
  }
}

/// 리뷰 리스트 컨트롤러
class ReviewController extends GetxController {
  /// 리뷰 리스트
  final reviews = <Review>[].obs;

  /// 게시글 ID
  final boardId = 0.obs;

  /// 게시글 ID를 받아오는 생성자
  ReviewController(int boardId) {
    this.boardId.value = boardId;
  }

  @override
  void onInit() {
    // 게시글 ID를 받아온 후 리뷰 리스트 조회
    getReviewList(boardId.value);
    super.onInit();
  }

  /// 리뷰 리스트 조회 메서드
  Future<void> getReviewList(int boardId) async {
    try {
      final reviewList = await ReviewListRepository().getReviewList(
        AuthController.to.accessToken.value,
        boardId,
      );
      reviews.value = reviewList.reviews;
      print('리뷰 리스트 조회 성공 : ${reviews.toString()}');
    } catch (e) {
      print('리뷰 리스트 조회 실패 : $e');
    }
  }

  /// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 리뷰 신고 파트 변수 및 메서드 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

  /// 게시물의 각 리뷰 ID
  final boardReviewId = 0.obs;

  /// 신고 내용
  final content = ''.obs;

  /// 카테고리
  final categories = REPORTCATEGORY.values;

  /// 선택된 신고 카테고리
  final selectedCategory = Rx<REPORTCATEGORY?>(null);

  /// 카테고리 선택 메서드
  void toggleCategory(REPORTCATEGORY category) {
    selectedCategory.value = category;
  }

  /// 신고 내용 업데이트
  void updateContent(String value) {
    content.value = value;
    print('신고 내용: ${content.value}');
  }

  /// 리뷰 신고 메서드
  Future<bool> reviewReport(int reviewId, String reviewContent) async {
    boardReviewId.value = reviewId;
    content.value = reviewContent;

    try {
      final response = await ReportRepository().reviewReport(
          AuthController.to.accessToken.value,
          boardReviewId.value,
          content.value);
      if (response) {
        print('(controller)리뷰 신고 성공');
        return true;
      } else {
        print('(controller)리뷰 신고 api조회 false');
        return false;
      }
    } on HttpException catch (e) {
      print('(controller)리뷰 신고 실패 - Http 예외: $e');
      rethrow;
      // 필요시 사용자에게 오류 메시지를 표시할 수 있습니다.
    } catch (e) {
      print('(controller)리뷰 신고 api 받아오기 실패: $e');
      rethrow;
    }
  }

  /// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
}
