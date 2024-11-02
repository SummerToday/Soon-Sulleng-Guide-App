import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ReviewDetailPage.dart';

class ReviewList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  ReviewList({required this.reviews});

  Future<void> _fetchReviewDetail(BuildContext context, int itemId) async {
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
                '리뷰 목록',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Yangjin',
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return GestureDetector(
                    onTap: () {
                      _fetchReviewDetail(context, review['id']); // 클릭 시 리뷰 상세 정보를 가져오는 함수 호출
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: ListTile(
                        leading: review['thumbnail'] != null && review['thumbnail'] != ''
                            ? Image.network(
                          review['thumbnail'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                          ),
                        ),
                        title: Text(
                          review['reviewTitle'] ?? '', // 메뉴 이름을 제목으로 표시
                          style: TextStyle(
                            fontFamily: 'Yangjin',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          review['reviewContent'] ?? '',
                          style: TextStyle(
                            fontFamily: 'Yangjin',
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
