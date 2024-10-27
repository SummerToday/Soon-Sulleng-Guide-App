import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ReviewDetailPage.dart';

class FavoriteList extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteItems;

  FavoriteList({required this.favoriteItems});

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  List<Map<String, dynamic>> _favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _favoriteItems = widget.favoriteItems; // 초기 전달된 데이터를 먼저 적용
    _fetchFavoriteList(); // 서버에서 최신 데이터 가져오기
  }

  @override
  void didUpdateWidget(covariant FavoriteList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.favoriteItems != widget.favoriteItems) {
      setState(() {
        _favoriteItems = widget.favoriteItems; // 새로운 데이터로 업데이트
      });
    }
  }

  Future<void> _fetchFavoriteList() async {
    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("Access Token이 없습니다.");
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/favorites/list'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _favoriteItems = List<Map<String, dynamic>>.from(data);
        });
        print("찜 목록 데이터 불러오기 성공: $_favoriteItems");
      } else {
        print('찜 목록 가져오기 실패. 상태 코드: ${response.statusCode}');
      }
    } catch (error) {
      print('찜 목록 데이터를 가져오는 중 오류 발생: $error');
    }
  }

  Future<void> _fetchReviewDetail(int itemId) async {
    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("Access Token이 없습니다.");
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/reviews/$itemId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewDetailPage(
              storeName: data['storeName'],
              reviewTitle: data['reviewTitle'],
              menuName: data['menuName'],
              reviewContent: data['reviewContent'],
              reviewDateTime: data['reviewDateTime'],
              price: data['price'],
              stars: data['stars'],
              images: List<String>.from(data['images']),
            ),
          ),
        );
      } else {
        print('리뷰 상세 정보 가져오기 실패. 상태 코드: ${response.statusCode}');
      }
    } catch (error) {
      print('리뷰 상세 정보 가져오는 중 오류 발생: $error');
    }
  }

  Future<void> _removeFavoriteItem(int itemId) async {
    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("Access Token이 없습니다.");
        return;
      }

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/favorites/remove'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({'reviewId': itemId}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _favoriteItems.removeWhere((item) => item['id'] == itemId);
        });
        print('찜 항목 삭제 성공: $itemId');
      } else {
        print('찜 항목 삭제 실패. 상태 코드: ${response.statusCode}');
      }
    } catch (error) {
      print('찜 항목 삭제 중 오류 발생: $error');
    }
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '내가 저장한 리뷰들',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Yangjin',
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _favoriteItems.isEmpty
                  ? Center(
                child: Text(
                  "저장된 리뷰가 없습니다.",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: _favoriteItems.length,
                  itemBuilder: (context, index) {
                    final item = _favoriteItems[index];
                    return _buildFavoriteItem(
                      context,
                      item['reviewTitle'] ?? '리뷰 제목',
                      item['thumbnail'] ?? '',
                      item['price']?.toString() ?? '₩0',
                      item['reviewContent'] ?? '내용 없음',
                      item['id'],
                      item['storeName'] ?? '식당 이름',
                      item['menuName'] ?? '메뉴 이름',
                      item['reviewDateTime'] ?? '',
                      item['stars'] ?? 0,
                      List<String>.from(item['images'] ?? []), // 여러 이미지 경로 추가
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(
      BuildContext context,
      String name,
      String imagePath,
      String price,
      String description,
      int itemId,
      String storeName,
      String menuName,
      String reviewDateTime,
      int stars,
      List<String> images,
      ) {
    return GestureDetector(
      onTap: () {
        _fetchReviewDetail(itemId); // 클릭 시 상세 정보를 서버에서 가져오는 함수 호출
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: imagePath.startsWith('http')
                  ? Image.network(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[600],
                    ),
                  );
                },
              )
                  : Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Yangjin',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Yangjin',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                _removeFavoriteItem(itemId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
