part of 'app_pages.dart';

/// 앱 페이지 경로 설정 클래스
abstract class Routes {
  Routes._(); // 생성자 private

  /// 페이지 경로
  static const initial = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const agreeTerms = '/agree_terms';
  static const main = '/main';
  static const findId = '/find_id';
  static const findPw = '/find_pw';
  static const myPage = '/myPage';
  static const profile = '/profile';
  static const notification = '/notification';
  static const notice = '/notice';
  static const noticeDetail = '/notice_detail';
  static const uploadGame = '/upload_game';
  static const list = '/list';
  static const changePw = '/change_pw';
  static const myPageModify = '/myPage/modify';
  static const gameDetail = '/game_detail';
  static const gamePlay = '/game_play';
  static const myGames = '/my_games';
  static const reviewList = '/review_list';
  static const gameResult = '/game_result';
}
