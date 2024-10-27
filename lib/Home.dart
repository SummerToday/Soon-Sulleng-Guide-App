import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MenuDetailInfo.dart';
import 'ReviewDetailPage.dart';
import 'Favoritelist.dart';
import 'ReviewList.dart';
import 'WriteReview.dart';
import '../AccountInfo.dart';

class Loby extends StatefulWidget {
  @override
  _LobyState createState() => _LobyState();
}

class _LobyState extends State<Loby> {
  List<Map<String, dynamic>> _foodList = [];
  List<Map<String, dynamic>> _dessertList = [];
  Map<int, bool> favoriteStatus = {};
  bool _isLoading = true;

  int _selectedIndex = 0;
  DateTime? _lastBackPressed;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _fetchReviewData();
    _fetchFavoriteStatus(); // 초기 화면 진입 시 찜 상태 확인
  }

  Future<void> _fetchReviewData() async {
    setState(() {
      _isLoading = true; // 데이터를 가져오기 전에 로딩 상태를 true로 설정
    });

    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("Access Token이 없습니다.");
        setState(() {
          _isLoading = false; // 액세스 토큰이 없을 때 로딩 상태를 false로 설정
        });
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/reviews/getReviews'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${utf8.decode(response.bodyBytes)}');

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));

        setState(() {
          _foodList = List<Map<String, dynamic>>.from(data["식당"] ?? []);
          _dessertList = List<Map<String, dynamic>>.from(data["카페"] ?? []);
          _isLoading = false; // 로딩 완료
          _pages = [
            LobyPage(
              foodList: _foodList,
              dessertList: _dessertList,
              favoriteStatus: favoriteStatus,
              onToggleFavorite: _toggleFavorite,
              isLoading: _isLoading,
            ),
            ReviewList(reviews: _foodList + _dessertList), // 여기서 리뷰 데이터 전달
            WriteReview(),
            FavoriteList(),
            AccountInfo(),
          ];

        });
      } else {
        print('Failed to load data. 상태 코드: ${response.statusCode}');
        setState(() {
          _isLoading = false; // 상태 코드가 200이 아닐 때 로딩 상태를 false로 설정
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _isLoading = false; // 오류 발생 시 로딩 상태를 false로 설정
      });
    }
  }

  Future<void> _fetchFavoriteStatus() async {
    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("Access Token이 없습니다.");
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/favorites/status'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

        setState(() {
          favoriteStatus = data.map((key, value) => MapEntry(int.parse(key), value));
        });

        print('찜 상태 가져오기 성공: $data');
      } else {
        print('찜 상태 가져오기 실패. 상태 코드: ${response.statusCode}');
        print('응답 내용: ${response.body}');
      }
    } catch (error, stackTrace) {
      print('Error fetching favorite status: $error');
      print('Stack trace: $stackTrace');
    }
  }

  void _toggleFavorite(int itemId, bool isFavorite) async {
    String endpoint = isFavorite ? '/remove' : '/add';
    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("Access Token이 없습니다.");
        return;
      }

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/favorites$endpoint'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({'reviewId': itemId}),
      );

      if (response.statusCode == 200) {
        setState(() {
          favoriteStatus[itemId] = !isFavorite;
        });
        print(isFavorite ? '찜 삭제 성공' : '찜 추가 성공');
      } else {
        print('찜 처리 실패. 상태 코드: ${response.statusCode}');
      }
    } catch (error) {
      print('Error toggling favorite: $error');
    }
  }

  void _onItemTapped(int index) async {
    if (index == 0) {
      // 홈 화면일 경우 기존 데이터 재조회
      await _fetchReviewData();
      await _fetchFavoriteStatus();
    } else if (index == 1) {
      // 리뷰 목록 탭을 클릭한 경우 리뷰 목록 데이터를 가져옴
      await _fetchAllReviews();
    } else {
      // 나머지 탭 클릭 시 찜 상태 재조회
      await _fetchFavoriteStatus();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _fetchAllReviews() async {
    setState(() {
      _isLoading = true; // 데이터를 가져오기 전에 로딩 상태를 true로 설정
    });

    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("Access Token이 없습니다.");
        setState(() {
          _isLoading = false; // 액세스 토큰이 없을 때 로딩 상태를 false로 설정
        });
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/reviews/allReviews'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

        setState(() {
          _pages[1] = ReviewList(reviews: List<Map<String, dynamic>>.from(data)); // 최신 리뷰 데이터를 ReviewList 페이지에 전달
          _isLoading = false; // 로딩 완료
        });
      } else {
        print('리뷰 목록을 가져오는 데 실패했습니다. 상태 코드: ${response.statusCode}');
        setState(() {
          _isLoading = false; // 상태 코드가 200이 아닐 때 로딩 상태를 false로 설정
        });
      }
    } catch (error) {
      print('리뷰 목록을 가져오는 중 오류 발생: $error');
      setState(() {
        _isLoading = false; // 오류 발생 시 로딩 상태를 false로 설정
      });
    }
  }



  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    final maxDuration = Duration(seconds: 2);
    final isWarning = _lastBackPressed == null || now.difference(_lastBackPressed!) > maxDuration;

    if (isWarning) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('한 번 더 누르면 앱이 종료됩니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    } else {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages.isNotEmpty ? _pages : [Center(child: CircularProgressIndicator())],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 40, color: _selectedIndex == 0 ? Color(0xFF0367A6) : Colors.grey),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list, size: 40, color: _selectedIndex == 1 ? Color(0xFF0367A6) : Colors.grey),
                label: '리뷰 목록',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.border_color_outlined, size: 40, color: _selectedIndex == 2 ? Color(0xFF0367A6) : Colors.grey),
                label: '리뷰 작성',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded, size: 40, color: _selectedIndex == 3 ? Color(0xFF0367A6) : Colors.grey),
                label: '저장',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 40, color: _selectedIndex == 4 ? Color(0xFF0367A6) : Colors.grey),
                label: '계정 정보',
              ),
            ],
            selectedLabelStyle: TextStyle(fontFamily: 'Yangjin', fontSize: 14),
            unselectedLabelStyle: TextStyle(fontFamily: 'Yangjin', fontSize: 14),
            selectedItemColor: Color(0xFF0367A6),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class LobyPage extends StatefulWidget {
  final List<Map<String, dynamic>> foodList;
  final List<Map<String, dynamic>> dessertList;
  final Map<int, bool> favoriteStatus;
  final bool isLoading;
  final Function(int, bool) onToggleFavorite;

  LobyPage(
      {required this.foodList,
        required this.dessertList,
        required this.favoriteStatus,
        required this.isLoading,
        required this.onToggleFavorite});

  @override
  _LobyPageState createState() => _LobyPageState();
}

class _LobyPageState extends State<LobyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.grey),
                        onPressed: () {
                          print('검색 버튼 클릭됨');
                        },
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          style: TextStyle(fontFamily: 'Yangjin', color: Colors.grey),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '오늘 점심 뭐 먹지',
                            hintStyle: TextStyle(fontFamily: 'Yangjin', color: Colors.grey),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.tune, color: Colors.grey),
                        onPressed: () {
                          print('설정 버튼 클릭됨');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          widget.isLoading
              ? CircularProgressIndicator()
              : Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(context, '식당', widget.foodList),
                  SizedBox(height: 50),
                  _buildSection(context, '카페', widget.dessertList),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Map<String, dynamic>> itemList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(title, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Yangjin')),
        ),
        SizedBox(height: 10),
        Container(
          height: 270,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: itemList.map((item) => _buildItemCard(context, item)).toList(),
          ),
        ),
      ],
    );
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

  Widget _buildItemCard(BuildContext context, Map<String, dynamic> item) {
    int itemId = item['id'];
    bool isFavorite = widget.favoriteStatus[itemId] ?? false;

    return GestureDetector(
      onTap: () {
        _fetchReviewDetail(itemId); // 클릭 시 리뷰 상세 정보를 가져오는 함수 호출
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 16.0),
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    child: Image.network(
                      item['thumbnail'] ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    item['menuName'] ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    '${item['price']} / ${item['storeName']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 80,
              left: 8,
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: List.generate(
                    item['stars'] ?? 0,
                        (index) => Icon(
                      Icons.star,
                      color: Color(0xFFDAA520),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onToggleFavorite(itemId, isFavorite);
                    widget.favoriteStatus[itemId] = !isFavorite; // 바로 반영되도록 수정
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 30,
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
