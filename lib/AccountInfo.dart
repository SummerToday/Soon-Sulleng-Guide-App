import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure Storage 패키지 추가
import 'Account/Login.dart';  // 로그인 페이지로 이동하기 위한 import
import 'package:http/http.dart' as http;

class AccountInfo extends StatefulWidget {
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // 로그아웃 처리 함수
  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'refreshToken');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginWidget()),
      );
    } catch (error) {
      print('로그아웃 에러: $error');
    }
  }

  // 계정 탈퇴 처리 함수
  Future<void> _handleAccountDeletion() async {
    try {
      final accessToken = await secureStorage.read(key: 'accessToken');

      if (accessToken == null) {
        print('로그인 정보가 없습니다.');
        return;
      }

      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8080/api/users/delete-account'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('계정 삭제 성공');
        await secureStorage.delete(key: 'accessToken');
        await secureStorage.delete(key: 'refreshToken');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginWidget()), // 탈퇴 후 로그인 화면으로 이동
        );
      } else {
        print('계정 삭제 실패: ${response.body}');
      }
    } catch (error) {
      print('에러 발생: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with "순슐랭가이드" and Icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '순슐랭가이드',
                    style: TextStyle(
                      color: Color(0xFF0367A6),
                      fontSize: 30,
                      fontFamily: 'Yangjin',
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/swapped_dishs.png',
                      width: 75,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              '사용자 닉네임: [사용자 닉네임]',
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 18,
                color: Colors.black, // 검은색 텍스트
              ),
            ),
            Text(
              '사용자 이름: [사용자 이름]',
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 18,
                color: Colors.black, // 검은색 텍스트
              ),
            ),
            Text(
              '이메일: [사용자 이메일]',
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 18,
                color: Colors.black, // 검은색 텍스트
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _handleSignOut,
                child: Text(
                  '로그아웃',
                  style: TextStyle(
                    fontFamily: 'Yangjin',
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Spacer(),
            // 계정 탈퇴 버튼 (작고 깔끔하게 하단에 배치)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: _handleAccountDeletion,
                child: Text(
                  '계정 탈퇴',
                  style: TextStyle(
                    fontFamily: 'Yangjin',
                    fontSize: 14,
                    color: Colors.black, // 검은색 텍스트
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
