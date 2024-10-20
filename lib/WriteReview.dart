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
  List<XFile?> _images = []; // 여러 첨부된 이미지 리스트
  int _selectedStars = 0; // 선택된 별점 (0~2)

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(pickedFile); // 선택된 이미지를 리스트에 추가
      });
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
                          '식당',
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
                          '카페',
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
                        labelText: _selectedCategory == '식당' ? '식당명' : '카페명',
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
                        labelText: '메뉴명',
                        labelStyle: TextStyle(
                          fontFamily: 'Yangjin',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 별점 선택
                    Text(
                      '별점 선택',
                      style: TextStyle(
                        fontFamily: 'Yangjin',
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _selectedStars == 0 ? Icons.close : Icons.close,
                            color: _selectedStars == 0 ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedStars = 0;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            _selectedStars >= 1 ? Icons.star_rounded : Icons.star_border,
                            color: _selectedStars >= 1 ? Colors.amber : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedStars = 1;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            _selectedStars == 2 ? Icons.star_rounded : Icons.star_border,
                            color: _selectedStars == 2 ? Colors.amber : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedStars = 2;
                            });
                          },
                        ),
                      ],
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
                    // 사진 추가 버튼 및 미리보기 (여러 장 가로 스크롤)
                    OutlinedButton(
                      onPressed: _pickImage,
                      child: Text(
                        '사진 추가하기',
                        style: TextStyle(
                          fontFamily: 'Yangjin',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10), // 버튼 크기 조정
                        side: BorderSide(color: Colors.grey), // 테두리 색상
                      ),
                    ),
                    SizedBox(height: 10),
                    _images.isNotEmpty
                        ? Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, // 가로 스크롤
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.file(
                              File(_images[index]!.path),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    )
                        : Text(
                      '첨부된 사진 없음',
                      style: TextStyle(
                        fontFamily: 'Yangjin',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    // 별점 의미 설명
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('x : 또 먹으러 오지는 않겠네', style: TextStyle(fontFamily: 'Yangjin', fontSize: 14, color: Colors.grey)),
                        Text('1개: 다음에 또 먹으러 올만한데?', style: TextStyle(fontFamily: 'Yangjin', fontSize: 14, color: Colors.grey)),
                        Text('2개: 무조건 또 먹으러 와야지.', style: TextStyle(fontFamily: 'Yangjin', fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 20),
                    // 취소와 리뷰 작성 버튼
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // 취소 버튼 누르면 돌아가기
                            },
                            child: Text(
                              '취소',
                              style: TextStyle(
                                fontFamily: 'Yangjin',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey, // 취소 버튼 배경색
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('리뷰 작성 완료');
                            },
                            child: Text(
                              '리뷰 작성하기',
                              style: TextStyle(
                                fontFamily: 'Yangjin',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0367A6), // 버튼 배경색
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                      ],
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
