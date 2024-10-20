import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WriteReview extends StatefulWidget {
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  String _selectedCategory = '식당'; // 선택된 카테고리 (음식 or 디저트)
  String _storeName = ''; // 음식점 또는 카페 이름
  XFile? _image; // 첨부된 이미지

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
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
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '리뷰 작성',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Yangjin',
                ),
              ),
            ),
            SizedBox(height: 10),
            // Review Form Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    // 리뷰 제목
                    TextField(
                      decoration: InputDecoration(
                        labelText: '리뷰 제목',
                        labelStyle: TextStyle(
                          fontFamily: 'Yangjin',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 음식/디저트 선택
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '식당',
                          groupValue: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value as String;
                            });
                          },
                        ),
                        Text(
                          '음식',
                          style: TextStyle(
                            fontFamily: 'Yangjin',
                            fontSize: 16,
                          ),
                        ),
                        Radio(
                          value: '카페',
                          groupValue: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value as String;
                            });
                          },
                        ),
                        Text(
                          '디저트',
                          style: TextStyle(
                            fontFamily: 'Yangjin',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // 음식점 또는 카페 이름 필드
                    TextField(
                      decoration: InputDecoration(
                        labelText: _selectedCategory == '음식' ? '음식점 이름' : '카페 이름',
                        labelStyle: TextStyle(
                          fontFamily: 'Yangjin',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 메뉴 이름 필드
                    TextField(
                      decoration: InputDecoration(
                        labelText: '메뉴 이름',
                        labelStyle: TextStyle(
                          fontFamily: 'Yangjin',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 리뷰 내용 필드
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: '리뷰 내용을 입력하세요',
                        labelStyle: TextStyle(
                          fontFamily: 'Yangjin',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 사진 추가 버튼 및 미리보기
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text(
                        '사진 추가하기',
                        style: TextStyle(
                          fontFamily: 'Yangjin',
                          fontSize: 18,
                          color: Colors.white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0367A6), // 버튼 배경색
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                    SizedBox(height: 10),
                    _image != null
                        ? Image.file(
                      File(_image!.path),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                        : Text(
                      '첨부된 사진 없음',
                      style: TextStyle(
                        fontFamily: 'Yangjin',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
