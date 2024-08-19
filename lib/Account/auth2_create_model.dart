import 'package:flutter/material.dart';

class Auth2CreateModel with ChangeNotifier {
  // TextEditingController 및 FocusNode 선언
  late TextEditingController emailAddressTextController1;
  late TextEditingController passwordTextController1;
  late TextEditingController passwordTextController2;
  late TextEditingController emailAddressTextController2;
  late TextEditingController emailAddressTextController3;
  late TextEditingController emailAddressTextController4;

  late FocusNode emailAddressFocusNode1;
  late FocusNode passwordFocusNode1;
  late FocusNode passwordFocusNode2;
  late FocusNode emailAddressFocusNode2;
  late FocusNode emailAddressFocusNode3;
  late FocusNode emailAddressFocusNode4;

  // 패스워드 보이기/숨기기 상태
  bool passwordVisibility1 = false;
  bool passwordVisibility2 = false;

  // 유효성 검사 메서드
  String? Function(String?)? emailAddressTextController1Validator;
  String? Function(String?)? passwordTextController1Validator;
  String? Function(String?)? passwordTextController2Validator;
  String? Function(String?)? emailAddressTextController2Validator;
  String? Function(String?)? emailAddressTextController3Validator;
  String? Function(String?)? emailAddressTextController4Validator;

  // 생성자
  Auth2CreateModel() {
    emailAddressTextController1 = TextEditingController();
    passwordTextController1 = TextEditingController();
    passwordTextController2 = TextEditingController();
    emailAddressTextController2 = TextEditingController();
    emailAddressTextController3 = TextEditingController();
    emailAddressTextController4 = TextEditingController();

    emailAddressFocusNode1 = FocusNode();
    passwordFocusNode1 = FocusNode();
    passwordFocusNode2 = FocusNode();
    emailAddressFocusNode2 = FocusNode();
    emailAddressFocusNode3 = FocusNode();
    emailAddressFocusNode4 = FocusNode();

    // 유효성 검사 메서드 초기화
    emailAddressTextController1Validator = (String? value) {
      if (value == null || value.isEmpty) {
        return '이메일을 입력해주세요.';
      }
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return '올바른 이메일 주소를 입력해주세요.';
      }
      return null;
    };

    passwordTextController1Validator = (String? value) {
      if (value == null || value.isEmpty) {
        return '비밀번호를 입력해주세요.';
      }
      if (value.length < 6) {
        return '비밀번호는 최소 6자 이상이어야 합니다.';
      }
      return null;
    };

    passwordTextController2Validator = (String? value) {
      if (value == null || value.isEmpty) {
        return '비밀번호 확인을 입력해주세요.';
      }
      if (value != passwordTextController1.text) {
        return '비밀번호가 일치하지 않습니다.';
      }
      return null;
    };

    emailAddressTextController2Validator = (String? value) {
      if (value == null || value.isEmpty) {
        return '이름을 입력해주세요.';
      }
      return null;
    };

    emailAddressTextController3Validator = (String? value) {
      if (value == null || value.isEmpty) {
        return '생년월일을 입력해주세요.';
      }
      if (!RegExp(r'^\d{8}$').hasMatch(value)) {
        return '올바른 생년월일을 입력해주세요. (예: 19900101)';
      }
      return null;
    };

    emailAddressTextController4Validator = (String? value) {
      if (value == null || value.isEmpty) {
        return '닉네임을 입력해주세요.';
      }
      return null;
    };
  }

  // dispose 메서드
  @override
  void dispose() {
    emailAddressTextController1.dispose();
    passwordTextController1.dispose();
    passwordTextController2.dispose();
    emailAddressTextController2.dispose();
    emailAddressTextController3.dispose();
    emailAddressTextController4.dispose();

    emailAddressFocusNode1.dispose();
    passwordFocusNode1.dispose();
    passwordFocusNode2.dispose();
    emailAddressFocusNode2.dispose();
    emailAddressFocusNode3.dispose();
    emailAddressFocusNode4.dispose();

    super.dispose();
  }

  // 패스워드 보이기/숨기기 토글 메서드
  void togglePasswordVisibility1() {
    passwordVisibility1 = !passwordVisibility1;
    notifyListeners();
  }

  void togglePasswordVisibility2() {
    passwordVisibility2 = !passwordVisibility2;
    notifyListeners();
  }
}
