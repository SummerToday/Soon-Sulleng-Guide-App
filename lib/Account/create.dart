import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'auth2_create_model.dart';
export 'auth2_create_model.dart';

class Auth2CreateWidget extends StatefulWidget {
  const Auth2CreateWidget({super.key});

  @override
  State<Auth2CreateWidget> createState() => _Auth2CreateWidgetState();
}

class _Auth2CreateWidgetState extends State<Auth2CreateWidget>
    with TickerProviderStateMixin {
  late Auth2CreateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Auth2CreateModel());

    _model.emailAddressTextController1 ??= TextEditingController();
    _model.emailAddressFocusNode1 ??= FocusNode();

    _model.passwordTextController1 ??= TextEditingController();
    _model.passwordFocusNode1 ??= FocusNode();

    _model.passwordTextController2 ??= TextEditingController();
    _model.passwordFocusNode2 ??= FocusNode();

    _model.emailAddressTextController2 ??= TextEditingController();
    _model.emailAddressFocusNode2 ??= FocusNode();

    _model.emailAddressTextController3 ??= TextEditingController();
    _model.emailAddressFocusNode3 ??= FocusNode();
    _model.emailAddressFocusNode3!.addListener(() => setState(() {}));
    _model.emailAddressTextController4 ??= TextEditingController();
    _model.emailAddressFocusNode4 ??= FocusNode();

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, -140.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.349, 0),
            end: Offset(0, 0),
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
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF0367A6),
          ),
          alignment: AlignmentDirectional(0, -1),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: AlignmentDirectional(0, -0.25),
                child: Text(
                  '회원가입',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'aa',
                    color: Color(0xFFEFF5F9),
                    fontSize: 40,
                    letterSpacing: 0,
                    useGoogleFonts: false,
                  ),
                ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    height: 600,
                    constraints: BoxConstraints(
                      maxWidth: 570,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(
                            0,
                            2,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: AlignmentDirectional(0, 0),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                        _model.emailAddressTextController1,
                                        focusNode:
                                        _model.emailAddressFocusNode1,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.email],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                            fontFamily: 'aa',
                                            letterSpacing: 0,
                                            useGoogleFonts: false,
                                          ),
                                          hintText: '~ @ ~',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                          fontFamily: 'aa',
                                          letterSpacing: 0,
                                          useGoogleFonts: false,
                                        ),
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        cursorColor:
                                        FlutterFlowTheme.of(context)
                                            .primary,
                                        validator: _model
                                            .emailAddressTextController1Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                        _model.passwordTextController1,
                                        focusNode: _model.passwordFocusNode1,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.password],
                                        obscureText:
                                        !_model.passwordVisibility1,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                            fontFamily: 'aa',
                                            letterSpacing: 0,
                                            useGoogleFonts: false,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                                  () => _model.passwordVisibility1 =
                                              !_model.passwordVisibility1,
                                            ),
                                            focusNode:
                                            FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _model.passwordVisibility1
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                  .visibility_off_outlined,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                          fontFamily: 'aa',
                                          letterSpacing: 0,
                                          useGoogleFonts: false,
                                        ),
                                        cursorColor:
                                        FlutterFlowTheme.of(context)
                                            .primary,
                                        validator: _model
                                            .passwordTextController1Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                        _model.passwordTextController2,
                                        focusNode: _model.passwordFocusNode2,
                                        autofocus: true,
                                        obscureText:
                                        !_model.passwordVisibility2,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          labelStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                            fontFamily: 'aa',
                                            letterSpacing: 0,
                                            useGoogleFonts: false,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                                  () => _model.passwordVisibility2 =
                                              !_model.passwordVisibility2,
                                            ),
                                            focusNode:
                                            FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _model.passwordVisibility2
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                  .visibility_off_outlined,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                          fontFamily: 'aa',
                                          letterSpacing: 0,
                                          useGoogleFonts: false,
                                        ),
                                        cursorColor:
                                        FlutterFlowTheme.of(context)
                                            .primary,
                                        validator: _model
                                            .passwordTextController2Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                        _model.emailAddressTextController2,
                                        focusNode:
                                        _model.emailAddressFocusNode2,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.email],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: '이름',
                                          labelStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                            fontFamily: 'aa',
                                            letterSpacing: 0,
                                            useGoogleFonts: false,
                                          ),
                                          hintText: '홍길동',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                          fontFamily: 'aa',
                                          letterSpacing: 0,
                                          useGoogleFonts: false,
                                        ),
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        cursorColor:
                                        FlutterFlowTheme.of(context)
                                            .primary,
                                        validator: _model
                                            .emailAddressTextController2Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                        _model.emailAddressTextController3,
                                        focusNode:
                                        _model.emailAddressFocusNode3,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.birthday],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: '생년월일',
                                          labelStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                            fontFamily: 'aa',
                                            letterSpacing: 0,
                                            useGoogleFonts: false,
                                          ),
                                          hintText: '00000000',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                          fontFamily: 'aa',
                                          letterSpacing: 0,
                                          useGoogleFonts: false,
                                        ),
                                        cursorColor:
                                        FlutterFlowTheme.of(context)
                                            .primary,
                                        validator: _model
                                            .emailAddressTextController3Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                        _model.emailAddressTextController4,
                                        focusNode:
                                        _model.emailAddressFocusNode4,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.email],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: '닉네임',
                                          labelStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                            fontFamily: 'aa',
                                            letterSpacing: 0,
                                            useGoogleFonts: false,
                                          ),
                                          hintText: '닉네임',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                          fontFamily: 'aa',
                                          letterSpacing: 0,
                                          useGoogleFonts: false,
                                        ),
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        cursorColor:
                                        FlutterFlowTheme.of(context)
                                            .primary,
                                        validator: _model
                                            .emailAddressTextController4Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.24, 0.81),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  GoRouter.of(context).prepareAuthEvent();

                                  final user =
                                  await authManager.createAccountWithEmail(
                                    context,
                                    _model.emailAddressTextController1.text,
                                    _model.passwordTextController2.text,
                                  );
                                  if (user == null) {
                                    return;
                                  }

                                  context.goNamedAuth(
                                      'auth_2_createProfile', context.mounted);
                                },
                                text: '계정 생성하기',
                                options: FFButtonOptions(
                                  width: 350,
                                  height: 44,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: Color(0xFF787DEA),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'aa',
                                    letterSpacing: 0,
                                    useGoogleFonts: false,
                                  ),
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
