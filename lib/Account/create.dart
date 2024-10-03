import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth2_create_model.dart';

class Auth2CreateWidget extends StatefulWidget {
  const Auth2CreateWidget({super.key});

  @override
  State<Auth2CreateWidget> createState() => _Auth2CreateWidgetState();
}

class _Auth2CreateWidgetState extends State<Auth2CreateWidget>
    with TickerProviderStateMixin {
  late Auth2CreateModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // 모델 가져오기
    _model = context.read<Auth2CreateModel>();

    // TextEditingController와 FocusNode를 명시적으로 초기화
    _model.emailAddressTextController1 = TextEditingController();
    _model.passwordTextController1 = TextEditingController();
    _model.passwordTextController2 = TextEditingController();
    _model.emailAddressTextController2 = TextEditingController();
    _model.emailAddressTextController3 = TextEditingController();
    _model.emailAddressTextController4 = TextEditingController();

    _model.emailAddressFocusNode1 = FocusNode();
    _model.passwordFocusNode1 = FocusNode();
    _model.passwordFocusNode2 = FocusNode();
    _model.emailAddressFocusNode2 = FocusNode();
    _model.emailAddressFocusNode3 = FocusNode();
    _model.emailAddressFocusNode4 = FocusNode();
  }

  @override
  void dispose() {
    // 모든 TextEditingController와 FocusNode를 명시적으로 해제
    _model.emailAddressTextController1.dispose();
    _model.passwordTextController1.dispose();
    _model.passwordTextController2.dispose();
    _model.emailAddressTextController2.dispose();
    _model.emailAddressTextController3.dispose();
    _model.emailAddressTextController4.dispose();

    _model.emailAddressFocusNode1.dispose();
    _model.passwordFocusNode1.dispose();
    _model.passwordFocusNode2.dispose();
    _model.emailAddressFocusNode2.dispose();
    _model.emailAddressFocusNode3.dispose();
    _model.emailAddressFocusNode4.dispose();

    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면 조정
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xFF0367A6), // AppBar 배경색
          elevation: 0, // 그림자 제거
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // 뒤로가기 동작
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            // 스크롤 가능하게 수정
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFF0367A6),
              ),
              alignment: AlignmentDirectional.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '회원가입',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Yangjin',
                        color: const Color(0xFFEFF5F9),
                        fontSize: 40,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 570,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: AlignmentDirectional.center,
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller:
                                  _model.emailAddressTextController1,
                                  focusNode: _model.emailAddressFocusNode1,
                                  autofocus: true,
                                  autofillHints: [AutofillHints.email],
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '이메일',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Yangjin',
                                      letterSpacing: 0,
                                    ),
                                    hintText: '~ @ ~',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .inputDecorationTheme
                                        .fillColor,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Yangjin',
                                    letterSpacing: 0,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Theme.of(context)
                                      .colorScheme
                                      .primary, // 변경됨
                                  validator: _model
                                      .emailAddressTextController1Validator,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _model.passwordTextController1,
                                  focusNode: _model.passwordFocusNode1,
                                  autofocus: true,
                                  autofillHints: [AutofillHints.password],
                                  obscureText: !_model.passwordVisibility1,
                                  decoration: InputDecoration(
                                    labelText: '비밀번호',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Yangjin',
                                      letterSpacing: 0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .inputDecorationTheme
                                        .fillColor,
                                    suffixIcon: InkWell(
                                      onTap: () => setState(() {
                                        _model.togglePasswordVisibility1();
                                      }),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.passwordVisibility1
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Theme.of(context).disabledColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Yangjin',
                                    letterSpacing: 0,
                                  ),
                                  cursorColor: Theme.of(context)
                                      .colorScheme
                                      .primary, // 변경됨
                                  validator:
                                  _model.passwordTextController1Validator,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _model.passwordTextController2,
                                  focusNode: _model.passwordFocusNode2,
                                  autofocus: true,
                                  obscureText: !_model.passwordVisibility2,
                                  decoration: InputDecoration(
                                    labelText: '비밀번호 확인',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Yangjin',
                                      letterSpacing: 0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .inputDecorationTheme
                                        .fillColor,
                                    suffixIcon: InkWell(
                                      onTap: () => setState(() {
                                        _model.togglePasswordVisibility2();
                                      }),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.passwordVisibility2
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Theme.of(context).disabledColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Yangjin',
                                    letterSpacing: 0,
                                  ),
                                  cursorColor: Theme.of(context)
                                      .colorScheme
                                      .primary, // 변경됨
                                  validator:
                                  _model.passwordTextController2Validator,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _model.emailAddressTextController2,
                                  focusNode: _model.emailAddressFocusNode2,
                                  autofocus: true,
                                  autofillHints: [AutofillHints.name],
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '이름',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Yangjin',
                                      letterSpacing: 0,
                                    ),
                                    hintText: '홍길동',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .inputDecorationTheme
                                        .fillColor,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Yangjin',
                                    letterSpacing: 0,
                                  ),
                                  cursorColor: Theme.of(context)
                                      .colorScheme
                                      .primary, // 변경됨
                                  validator:
                                  _model.emailAddressTextController2Validator,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _model.emailAddressTextController3,
                                  focusNode: _model.emailAddressFocusNode3,
                                  autofocus: true,
                                  autofillHints: [AutofillHints.birthday],
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '생년월일',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Yangjin',
                                      letterSpacing: 0,
                                    ),
                                    hintText: '19990930',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .inputDecorationTheme
                                        .fillColor,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Yangjin',
                                    letterSpacing: 0,
                                  ),
                                  cursorColor: Theme.of(context)
                                      .colorScheme
                                      .primary, // 변경됨
                                  validator:
                                  _model.emailAddressTextController3Validator,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _model.emailAddressTextController4,
                                  focusNode: _model.emailAddressFocusNode4,
                                  autofocus: true,
                                  autofillHints: [AutofillHints.nickname],
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '닉네임',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Yangjin',
                                      letterSpacing: 0,
                                    ),
                                    hintText: '순슐랭가이드',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error, // 변경됨
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .inputDecorationTheme
                                        .fillColor,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Yangjin',
                                    letterSpacing: 0,
                                  ),
                                  cursorColor: Theme.of(context)
                                      .colorScheme
                                      .primary, // 변경됨
                                  validator:
                                  _model.emailAddressTextController4Validator,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // 유효성 검사 수행
                                      if (Form.of(context)!.validate()) {
                                        // 계정 생성 로직 추가
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                              Text('계정이 성공적으로 생성되었습니다.')),

                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF787DEA),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 3,
                                    ),
                                    child: Text(
                                      '계정 생성하기',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                        fontFamily: 'Yangjin',
                                        letterSpacing: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
