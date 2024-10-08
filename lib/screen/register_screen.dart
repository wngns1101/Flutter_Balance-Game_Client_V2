import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/register_controller.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/register/basic_input_field.dart';
import 'package:yangjataekil/widget/register/birth_input_field.dart';
import 'package:yangjataekil/widget/register/check_email_btn.dart';
import 'package:yangjataekil/widget/register/email_input_field.dart';
import 'package:yangjataekil/widget/register/basic_btn.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
        elevation: 0,
        title: const Text(
          '회원가입',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          // 오버 스크롤 방지
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('이름'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BasicInputField(
                        hintText: '이름',
                        obscureText: false,
                        controller: controller,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('아이디'),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: EmailInputField(
                        hintText: '아이디',
                        obscureText: false,
                        textController: controller.accountNameController,
                        icon: const Icon(
                          size: 20,
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Obx(
                        () => ChkEmailBtn(
                          title: '중복확인',
                          color: controller.accountName.isEmpty
                              ? const Color(0xffE5E5E5)
                              : AppColors.primaryColor,
                          fontColor: controller.accountName.isEmpty
                              ? Colors.grey
                              : Colors.white,
                          onPressed: () => {
                            /// TODO: 이메일 중복 검사 연결
                            controller.checkDuplicateAccountName()
                          },
                          isEnabled:
                              controller.accountName.isEmpty ? false : true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('비밀번호'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BasicInputField(
                        hintText: '비밀번호',
                        obscureText: true,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: BasicInputField(
                        hintText: '비밀번호 확인',
                        obscureText: true,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '영문 대문자와 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 6~20자로 입력해주세요.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('생년월일'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BirthInputField(
                        registerController: controller,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '생년월일 8자리를 입력해주세요',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('이메일'),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: BasicInputField(
                        hintText: '이메일',
                        obscureText: false,
                        controller: controller,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Obx(
                        () => ChkEmailBtn(
                          title: '인증요청',
                          color: controller.email.isEmpty
                              ? const Color(0xffE5E5E5)
                              : AppColors.primaryColor,
                          fontColor: controller.email.value.isEmpty
                              ? Colors.grey
                              : Colors.white,
                          onPressed: () =>

                              /// TODO: 이메일 인증 요청
                              controller.requestEmailVerification(),
                          isEnabled: controller.email.isEmpty ? false : true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: TextField(
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration(
                            hintText: '인증번호를 입력해주세요.',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffFF9297),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            /// TODO: 인증번호 입력
                            controller.updateEmailAuthCode(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Obx(
                        () => ChkEmailBtn(
                          title: '인증확인',
                          color: controller.isEmailSent.value
                              ? AppColors.primaryColor
                              : const Color(0xffE5E5E5),
                          fontColor: controller.isEmailSent.value
                              ? Colors.white
                              : Colors.grey,
                          onPressed: () => {
                            /// TODO: 이메일 인증 요청
                            controller.verifyEmail()
                          },
                          isEnabled: controller.isEmailSent.value,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                BasicBtn(
                  onPressed: () {
                    controller.nextStep();
                  },
                  buttonText: '다음',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
