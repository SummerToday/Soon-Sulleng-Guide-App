import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure Storage 패키지 추가
import 'package:graduation_project/Home.dart';
import 'package:http/http.dart' as http; // http 패키지 추가
import 'dart:convert'; // JSON 인코딩/디코딩을 위해 추가

class NicknameInputScreen extends StatefulWidget {
  @override
  _NicknameInputScreenState createState() => _NicknameInputScreenState();
}

class _NicknameInputScreenState extends State<NicknameInputScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // 닉네임 저장 함수
  Future<void> saveNickname() async {
    final nickname = _nicknameController.text;

    if (nickname.isNotEmpty) {
      try {
        // 저장된 액세스 토큰 확인
        final accessToken = await secureStorage.read(key: 'accessToken');
        print('저장된 액세스 토큰: $accessToken');

        if (accessToken == null) {
          print('액세스 토큰이 없습니다.');
          return;
        }

        // 서버에 닉네임 저장 요청
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8080/api/users/save-nickname'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',  // 액세스 토큰을 사용
          },
          body: jsonEncode({'nick': nickname}),
        );

        // 서버 응답 확인
        if (response.statusCode == 200) {
          // 닉네임이 성공적으로 저장되었으면 Loby 화면으로 전환
          print('닉네임 저장됨: $nickname');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Loby()), // 홈 화면으로 이동
          );
        } else {
          print('닉네임 저장 실패: ${response.body}');
        }
      } catch (error) {
        print('에러 발생: $error');
      }
    } else {
      print('닉네임을 입력하세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0367A6),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: 570),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 닉네임 입력 필드
                  TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      hintText: '닉네임을 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      fontFamily: 'Yangjin',  // 글씨체 적용
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // 생성 버튼
                  ElevatedButton(
                    onPressed: saveNickname,
                    child: Text(
                      '생성하기',
                      style: TextStyle(
                        fontFamily: 'Yangjin',  // 글씨체 적용
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0367A6),  // 버튼 배경색
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
