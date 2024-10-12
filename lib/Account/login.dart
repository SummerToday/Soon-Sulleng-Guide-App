import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/Home.dart%20';
import 'auth2_login_model.dart';
import 'flutter_flow_theme.dart';
import 'flutter_flow_widgets.dart';
import 'flutter_flow_animations.dart';
import '../Home.dart' as home; // Loby 화면 임포트

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late Auth2LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  GoogleSignInAccount? _user;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _model = Auth2LoginModel();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.ms,
            duration: 300.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.ms,
            duration: 300.ms,
            begin: const Offset(0.0, 140.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
  }

  // 구글 로그인 처리
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        setState(() {
          _isLoggedIn = true;
          _user = googleUser;
        });
        print('name = ${googleUser.displayName}');
        print('email = ${googleUser.email}');

        // 로그인 성공 시 Loby 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => home.Loby()), // Loby로 이동
        );
      }
    } catch (error) {
      print('구글 로그인 에러: $error');
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.secondaryBackground,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.primaryColor, theme.primaryColor],
            stops: [0, 1],
            begin: const AlignmentDirectional(0.87, -1),
            end: const AlignmentDirectional(-0.87, 1),
          ),
        ),
        alignment: const AlignmentDirectional(0, -1),
        child: Align(
          alignment: Alignment.topCenter, // 컴포넌트들을 위쪽으로 올리기 위해 Align 사용
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 110), // 상단 여백
                // 이미지 추가
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    'assets/images/dishes-297268_1280.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                // "설마 아직도 안 먹어 봤어!?" 텍스트
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    '설마 아직도 안 먹어 봤어!?',
                    textAlign: TextAlign.center,
                    style: theme.displaySmall.copyWith(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 570,
                    ),
                    decoration: BoxDecoration(
                      color: theme.secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: const Color(0x33000000),
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Text(
                                '순슐랭가이드',
                                textAlign: TextAlign.center,
                                style: theme.displaySmall.copyWith(
                                  fontSize: 40,
                                  color: const Color(0xFF0367A6),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: FFButtonWidget(
                                onPressed: signInWithGoogle, // 구글 로그인 함수 연결
                                text: '구글 계정으로 시작하기',
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity, // 너비를 화면에 맞게 설정
                                  height: 60, // 높이를 기존보다 늘림
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: theme.secondaryBackground,
                                  textStyle: theme.titleSmall.copyWith(
                                    color: theme.primaryText,
                                    fontSize: 20,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: theme.alternate,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  hoverColor: theme.primaryBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
