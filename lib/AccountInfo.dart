import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure Storage 패키지 추가
import 'Account/Login.dart'; // 로그인 페이지로 이동하기 위한 import
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountInfo extends StatefulWidget {
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String _nickname = '...'; // 사용자 닉네임 초기값
  String _realname = '...'; // 사용자 이름 초기값
  String _email = '...'; // 사용자 이메일 초기값

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAccountInfo(); // 초기 상태에서 계정 정보를 가져옴
    });
  }

  // 계정 정보를 서버로부터 가져오는 함수
  Future<void> _fetchAccountInfo() async {
    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("로그인 정보가 없습니다.");
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/users/info'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _nickname = data['nickname'] ?? '닉네임 없음';
          _realname = data['realname'] ?? '이름 없음';
          _email = data['email'] ?? '이메일 없음';
        });
      } else if (response.statusCode == 401) {
        print('권한이 없습니다. 로그아웃 필요.');
        _handleSignOut();
      } else {
        print('계정 정보를 가져오지 못했습니다. 상태 코드: ${response.statusCode}');
      }
    } catch (error) {
      print('계정 정보를 가져오는 중 오류 발생: $error');
    }
  }

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
              '사용자 닉네임: $_nickname',
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Text(
              '사용자 이름: $_realname',
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Text(
              '이메일: $_email',
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 18,
                color: Colors.black,
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
                    color: Colors.black,
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
