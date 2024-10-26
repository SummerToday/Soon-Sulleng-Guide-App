import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Home.dart';
import 'ReviewList.dart';

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

class WriteReview extends StatefulWidget {
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  String _selectedCategory = '식당';
  String _storeName = '';
  String _reviewTitle = '';
  String _menuName = '';
  String _reviewContent = '';
  String _price = ''; // 가격 정보를 저장하는 변수 추가
  List<XFile?> _images = [];
  int _selectedStars = 0;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(pickedFile);
      });
    }
  }

  // 리뷰 작성 API 호출 함수
  Future<void> _submitReview(BuildContext context) async {
    final DateTime now = DateTime.now();
    final String formattedDateTime = now.toIso8601String();

    // SecureStorage에서 accessToken 가져오기
    String? accessToken = await secureStorage.read(key: 'accessToken');
    if (accessToken == null) {
      print("Access Token이 없습니다.");
      return;
    }

    var uri = Uri.parse('http://10.0.2.2:8080/api/reviews');
    var request = http.MultipartRequest('POST', uri);

    // 헤더에 액세스 토큰 추가
    request.headers['Authorization'] = 'Bearer $accessToken';

    // 텍스트 데이터를 멀티파트 요청에 추가
    request.fields['category'] = _selectedCategory;
    request.fields['storeName'] = _storeName;
    request.fields['reviewTitle'] = _reviewTitle;
    request.fields['menuName'] = _menuName;
    request.fields['reviewContent'] = _reviewContent;
    request.fields['stars'] = _selectedStars.toString();
    request.fields['reviewDateTime'] = formattedDateTime;
    request.fields['price'] = _price; // 가격 정보 추가

    // 이미지 파일을 멀티파트 요청에 추가
    for (var image in _images) {
      if (image != null) {
        var imageFile = File(image.path);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        request.files.add(
          http.MultipartFile(
            'images',
            stream,
            length,
            filename: basename(image.path),
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "리뷰 작성 완료",
                style: TextStyle(fontFamily: 'Yangjin'),
              ),
              content: Text(
                "리뷰를 성공적으로 작성했습니다!",
                style: TextStyle(fontFamily: 'Yangjin'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetFields();
                  },
                  child: Text(
                    "확인",
                    style: TextStyle(fontFamily: 'Yangjin'),
                  ),
                ),
              ],
            );
          },
        );
        _resetFields();
      } else {
        print('리뷰 작성 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('리뷰 작성 중 오류 발생: $error');
    }
  }

  void _resetFields() {
    setState(() {
      _selectedCategory = '식당';
      _storeName = '';
      _reviewTitle = '';
      _menuName = '';
      _reviewContent = '';
      _price = ''; // 가격 정보 초기화
      _images = [];
      _selectedStars = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    TextField(
                      onChanged: (value) {
                        _reviewTitle = value;
                      },
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
                    TextField(
                      onChanged: (value) {
                        _storeName = value;
                      },
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
                    TextField(
                      onChanged: (value) {
                        _menuName = value;
                      },
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
                    TextField(
                      onChanged: (value) {
                        _price = value;
                      },
                      decoration: InputDecoration(
                        labelText: '가격: ex. 10000원',
                        labelStyle: TextStyle(
                          fontFamily: 'Yangjin',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
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
                    TextField(
                      maxLines: 5,
                      onChanged: (value) {
                        _reviewContent = value;
                      },
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
                        padding: EdgeInsets.symmetric(vertical: 10),
                        side: BorderSide(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 10),
                    _images.isNotEmpty
                        ? Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
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
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Loby()),
                                    (Route<dynamic> route) => false,
                              );
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
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _submitReview(context);
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
                              backgroundColor: Color(0xFF0367A6),
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
