import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/report_controller.dart';
import 'package:yangjataekil/controller/review_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class BoardTap extends GetView<ReviewController> {
  const BoardTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
            elevation: 0,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            backgroundColor: AppColors.primaryColor,
            onPressed: () async {
              // /// 로그인 여부 확인
              // AuthController.to.accessToken.value == ''
              //     ? Get.toNamed('/login')
              //     : Get.toNamed('/upload_game');
              controller.reviewReport(6, 'ㅇ나닝ㄹ;ㅁㅇ라문ㅇ리ㅏ');
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
