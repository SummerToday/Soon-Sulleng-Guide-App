import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Account/Login.dart';  // 로그인 페이지로 이동하기 위한 import

class AccountInfo extends StatefulWidget {
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  // 로그아웃 처리 함수
  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      // 로그아웃 후 로그인 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginWidget()),  // 로그인 화면으로 이동
      );
    } catch (error) {
      print('로그아웃 에러: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('계정 정보'),
        backgroundColor: Color(0xFF0367A6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '순슐랭가이드 계정 정보',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0367A6),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '사용자 이름: [사용자 이름]',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '이메일: [사용자 이메일]',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _handleSignOut,  // 로그아웃 버튼 누르면 실행
                child: Text('로그아웃'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,  // 로그아웃 버튼 색상 (primary -> backgroundColor로 수정)
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
