import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth2_create_model.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with TickerProviderStateMixin {
  late Auth2CreateModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<Auth2CreateModel>();

    // TextEditingController와 FocusNode 초기화
    _model.emailAddressTextController1 = TextEditingController();
    _model.emailAddressFocusNode1 = FocusNode();

    _model.emailAddressTextController2 = TextEditingController();
    _model.emailAddressFocusNode2 = FocusNode();

    _model.emailAddressTextController3 = TextEditingController();
    _model.emailAddressFocusNode3 = FocusNode();
  }

  @override
  void dispose() {
    // TextEditingController와 FocusNode를 명시적으로 해제
    _model.emailAddressTextController1.dispose();
    _model.emailAddressFocusNode1.dispose();

    _model.emailAddressTextController2.dispose();
    _model.emailAddressFocusNode2.dispose();

    _model.emailAddressTextController3.dispose();
    _model.emailAddressFocusNode3.dispose();

    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xFF0367A6),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // 뒤로가기 동작
            },
          ),
        ),
        backgroundColor: const Color(0xFF0367A6),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40), // 간격 조정
                  child: Text(
                    '비밀번호 찾기',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Yangjin',
                      color: Colors.white,
                      fontSize: 40,
                      letterSpacing: 0,
                    ),
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
                      color: Colors.white,
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
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                controller: _model.emailAddressTextController1,
                                focusNode: _model.emailAddressFocusNode1,
                                autofocus: true,
                                autofillHints: const [AutofillHints.name],
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '이름',
                                  hintText: '홍길동',
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
                                          .primary, // 변경된 부분
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error, // 변경된 부분
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error, // 변경된 부분
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
                                    .primary, // 변경된 부분
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '이름을 입력해 주세요.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                controller: _model.emailAddressTextController2,
                                focusNode: _model.emailAddressFocusNode2,
                                autofocus: true,
                                autofillHints: const [AutofillHints.birthday],
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '생년월일',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Yangjin',
                                    letterSpacing: 0,
                                  ),
                                  hintText: '8자리',
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
                                          .primary, // 변경된 부분
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error, // 변경된 부분
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error, // 변경된 부분
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
                                    .primary, // 변경된 부분
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '생년월일을 입력해 주세요.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                controller: _model.emailAddressTextController3,
                                focusNode: _model.emailAddressFocusNode3,
                                autofocus: true,
                                autofillHints: const [AutofillHints.email],
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email',
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
                                          .primary, // 변경된 부분
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error, // 변경된 부분
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error, // 변경된 부분
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
                                    .primary, // 변경된 부분
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '이메일을 입력해 주세요.';
                                  }
                                  return null;
                                },
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
                                      // 임시 비밀번호 전송 로직 추가
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('임시 비밀번호가 전송되었습니다.')),
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
                                    '임시 비밀번호 전송하기',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
