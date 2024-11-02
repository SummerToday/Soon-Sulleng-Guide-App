import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ReviewDetailPage.dart'; // ReviewDetailPage로 이동하기 위해 import

class SearchPage extends StatefulWidget {
  final String searchKeyword; // 검색 키워드를 전달받음

  SearchPage({required this.searchKeyword});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  List<Map<String, dynamic>> reviews = [];
  bool _isLoading = true; // 로딩 상태 추가

  @override
  void initState() {
    super.initState();
    _fetchSearchResults(); // 검색 결과를 불러옴
  }

  // API 호출을 통해 검색 결과를 가져오는 함수
  Future<void> _fetchSearchResults() async {
    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("Access Token이 없습니다.");
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/search/list?keyword=${widget.searchKeyword}'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          reviews = List<Map<String, dynamic>>.from(
              json.decode(utf8.decode(response.bodyBytes)) // utf8 디코딩 적용
          );
          _isLoading = false; // 로딩 완료
        });
      } else {
        print('검색 결과 가져오기 실패. 상태 코드: ${response.statusCode}');
        setState(() {
          _isLoading = false; // 오류 시 로딩 상태 해제
        });
      }
    } catch (error) {
      print('검색 결과 가져오는 중 오류 발생: $error');
      setState(() {
        _isLoading = false; // 오류 시 로딩 상태 해제
      });
    }
  }

  // API 호출을 통해 선택한 리뷰의 상세 정보를 가져오는 함수
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

        // 상세 페이지로 데이터 전달하여 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewDetailPage(
              storeName: data['storeName'] ?? 'N/A',
              reviewTitle: data['reviewTitle'] ?? 'N/A',
              menuName: data['menuName'] ?? 'N/A',
              reviewContent: data['reviewContent'] ?? 'No description available',
              reviewDateTime: data['reviewDateTime'] ?? 'N/A',
              price: data['price'] ?? 'N/A',
              stars: data['stars'] ?? 0,
              images: List<String>.from(data['images'] ?? []), // 모든 이미지 목록 전달
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
      appBar: AppBar(
        title: Text(
          '검색 결과',
          style: TextStyle(fontFamily: 'Yangjin', fontSize: 22),
        ),
        backgroundColor: Color(0xFF0367A6),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator()) // 로딩 중인 경우 로딩 표시
            : reviews.isEmpty
            ? Center(child: Text('검색 결과가 없습니다.')) // 검색 결과가 없을 때 메시지 표시
            : ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return GestureDetector(
              onTap: () => _fetchReviewDetail(review['id']), // 클릭 시 상세 정보 API 호출
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
    );
  }
}
