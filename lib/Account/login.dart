import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth2_login_model.dart';
import 'flutter_flow_theme.dart';
import 'flutter_flow_widgets.dart';
import 'flutter_flow_animations.dart';
import 'create.dart';
import 'forgotPassword.dart';
import 'ForgotEmail.dart';

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

  @override
  void initState() {
    super.initState();
    _model = Auth2LoginModel();

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

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
            begin: Offset(0.0, 140.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.ms,
            duration: 300.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.ms,
            duration: 300.ms,
            begin: -0.349,
            end: 0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.secondaryBackground,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.primaryColor, theme.primaryColor],
              stops: [0, 1],
              begin: AlignmentDirectional(0.87, -1),
              end: AlignmentDirectional(-0.87, 1),
            ),
          ),
          alignment: AlignmentDirectional(0, -1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70), // 상단 여백 추가
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    '설마 아직도 안 먹어 봤어!?',
                    textAlign: TextAlign.center,
                    style: theme.displaySmall.copyWith(
                      fontSize: 30, // 크기 조정
                      color: Colors.white, // 흰색 텍스트
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
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsets.only(top: 0, bottom: 40),
                                child: Text(
                                  '순슐랭가이드',
                                  textAlign: TextAlign.center,
                                  style: theme.displaySmall.copyWith(
                                    fontSize: 40, // 크기 늘리기
                                    color: const Color(0xFF0367A6),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.emailAddressTextController,
                                  focusNode: _model.emailAddressFocusNode,
                                  autofocus: true,
                                  autofillHints: const [AutofillHints.email],
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: theme.labelLarge,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.primaryColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: theme.primaryBackground,
                                  ),
                                  style: theme.bodyLarge,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: theme.primaryColor,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email을 입력해주세요.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.passwordTextController,
                                  focusNode: _model.passwordFocusNode,
                                  autofocus: true,
                                  autofillHints: const [AutofillHints.password],
                                  obscureText: !_model.passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: theme.labelLarge,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.primaryColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: theme.primaryBackground,
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => _model.passwordVisibility =
                                            !_model.passwordVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: theme.secondaryText,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  style: theme.bodyLarge,
                                  cursorColor: theme.primaryColor,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password를 입력해주세요.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  // 임시 로그인 버튼 동작, 추후 백엔드 연동 필요
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('로그인 클릭됨')),
                                  );
                                },
                                text: '로그인하기',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  // 여기서 const 키워드 제거
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: theme.secondaryColor,
                                  textStyle: theme.titleSmall,
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 24),
                                child: Text(
                                  'or',
                                  textAlign: TextAlign.center,
                                  style: theme.labelMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  // 임시 구글 로그인 버튼 동작, 추후 백엔드 연동 필요
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('구글 계정으로 시작하기 클릭됨')),
                                  );
                                },
                                text: '구글 계정으로 시작하기',
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: theme.secondaryBackground,
                                  textStyle: theme.titleSmall.copyWith(
                                    color: theme.primaryText,
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
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 12),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    // 계정 생성 페이지로 이동
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Auth2CreateWidget(),
                                      ),
                                    );
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '처음이신가요? ',
                                          style: theme.bodyMedium,
                                        ),
                                        TextSpan(
                                          text: '계정 생성하기',
                                          style: theme.bodyMedium.copyWith(
                                            color: theme.primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  // ForgotEmail 페이지로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ForgotEmail(),
                                    ),
                                  );
                                },
                                text: '이메일이 생각이 안나시나요?',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: theme.backgroundColor,
                                  textStyle: theme.titleSmall.copyWith(
                                    color: theme.primaryText,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: theme.primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  hoverColor: theme.primaryBackground,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  // ForgetPasswordWidget으로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const forgotPassword(),
                                    ),
                                  );
                                },
                                text: '비밀번호를 잊으셨나요?',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: theme.backgroundColor,
                                  textStyle: theme.titleSmall.copyWith(
                                    color: theme.primaryText,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: theme.primaryBackground,
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
