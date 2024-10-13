import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure Storage 추가
import 'dart:convert'; // JSON 파싱을 위해 추가
import 'Account/auth2_create_model.dart'; // auth2_create_model.dart 파일을 임포트.
import 'Account/login.dart'; // login.dart 파일을 임포트.
import 'Home.dart'; // LobyPage를 임포트.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InitalPageModel()),
        ChangeNotifierProvider(create: (_) => Auth2CreateModel()), // Auth2CreateModel 추가
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 배지 제거
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontFamily: 'Yangjin'), // Flutter 3.24.3에서 bodyText2 -> bodyLarge로 변경
          ),
        ),
        home: const InitalPageWidget(), // 앱 시작 시 InitalPageWidget으로 이동.
      ),
    );
  }
}

class InitalPageWidget extends StatefulWidget {
  const InitalPageWidget({super.key});

  @override
  State<InitalPageWidget> createState() => _InitalPageWidgetState();
}

class _InitalPageWidgetState extends State<InitalPageWidget>
    with TickerProviderStateMixin {
  late InitalPageModel _model;
  bool _checkingLoginStatus = true; // 로그인 상태 확인 여부
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage(); // Secure Storage 추가

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<InitalPageModel>();

    // 애니메이션 설정
    Animate.defaultDuration = 600.ms;
    Animate.defaultCurve = Curves.easeInOut;

    // 로그인 상태 확인 후 처리
    _checkLoginStatus();
  }

  // 로그인 상태 확인 함수
  Future<void> _checkLoginStatus() async {
    try {
      // Secure Storage에서 리프레시 토큰을 읽어옴
      String? refreshToken = await secureStorage.read(key: 'refreshToken');
      print('저장된 리프레시 토큰: $refreshToken'); // 리프레시 토큰 출력

      if (refreshToken != null) {
        // 리프레시 토큰을 API 요청에 포함하여 서버에 로그인 상태 확인 요청
        print('로그인 상태 확인 API 호출 시작');
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8080/api/check-login-status'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $refreshToken',  // Authorization 헤더에 토큰 추가
          },
        );
        print('API 응답 상태 코드: ${response.statusCode}'); // 상태 코드 출력
        print('API 응답 내용: ${response.body}'); // 응답 내용 출력

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          bool isLoggedIn = jsonResponse['isLoggedIn'];

          if (isLoggedIn) {
            // 로그인 되어 있으면 LobyPage로 이동
            print('로그인 성공, Loby로 이동');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Loby()),
            );
          } else {
            // 로그인 안 되어 있으면 LoginWidget으로 이동
            print('로그인 실패, LoginWidget으로 이동');
            _redirectToLogin();
          }
        } else {
          // 오류 발생 시 로그인 페이지로 이동
          print('API 오류 발생, 상태 코드: ${response.statusCode}');
          _redirectToLogin();
        }
      } else {
        // 리프레시 토큰이 없으면 로그인 페이지로 이동
        print('리프레시 토큰 없음, LoginWidget으로 이동');
        _redirectToLogin();
      }
    } catch (e) {
      // 예외 발생 시 로그인 페이지로 이동
      print('예외 발생: $e');
      _redirectToLogin();
    } finally {
      setState(() {
        _checkingLoginStatus = false; // 로그인 상태 확인 완료
      });
    }
  }


  // LoginWidget으로 전환하는 함수
  void _redirectToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginWidget()),
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF0367A6),
        body: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0.05),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/dishes-297268_1280.png',
                  width: 187,
                  height: 148,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 0),
                ),
              ).animate().rotate(begin: 0.0, end: 1.0), // 애니메이션 유지
            ),
            Align(
              alignment: const AlignmentDirectional(0, -0.25),
              child: Text(
                '순슐랭가이드',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Yangjin',
                  color: const Color(0xFFEFF5F9),
                  fontSize: 40,
                  letterSpacing: 0,
                ),
              ).animate().fadeIn(), // 텍스트 애니메이션 유지
            ),
            if (_checkingLoginStatus) // 로그인 상태 확인 중일 때 메시지 표시
              Align(
                alignment: const AlignmentDirectional(0, 0.9),
                child: Text(
                  '로그인 상태 확인 중...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class InitalPageModel extends ChangeNotifier {
  final FocusNode unfocusNode = FocusNode();

  @override
  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }
}
