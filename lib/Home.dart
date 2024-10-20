import 'package:flutter/material.dart';
import 'dart:io'; // iOS용 종료 메서드 사용을 위해 추가
import 'package:flutter/services.dart'; // 안드로이드 앱 종료를 위해 추가
import 'package:http/http.dart' as http; // HTTP 패키지 추가
import 'dart:convert'; // JSON 인코딩을 위해 필요
import 'ReviewDetailPage.dart';
import 'Favoritelist.dart'; // FavoriteList 화면 임포트
import 'ReviewList.dart';
import 'WriteReview.dart';
import '../AccountInfo.dart';

class Loby extends StatefulWidget {
  @override
  _LobyState createState() => _LobyState();
}

class _LobyState extends State<Loby> {
  List<bool> _isLikedFood = [false, false, false, false];
  List<bool> _isLikedDessert = [false, false, false, false];

  int _selectedIndex = 0; // 선택된 탭의 인덱스를 저장하는 변수, 기본은 홈(0)
  DateTime? _lastBackPressed; // 마지막으로 뒤로가기 버튼을 누른 시간을 저장하는 변수

  List<Widget> _pages = []; // 페이지 리스트를 여기에 저장

  @override
  void initState() {
    super.initState();
    _pages = [
      LobyPage(
        isLikedFood: _isLikedFood, // 음식 찜 상태 전달
        toggleFavorite: _toggleFavorite, // 찜 상태 변경 함수 전달
      ), // 홈 화면
      ReviewList(), // 리뷰 목록 화면
      WriteReview(), // 평가하기 화면
      FavoriteList(), // 찜 화면
      AccountInfo(), // 계정 정보 화면
    ];
  }

  // 찜 API 호출 함수 (찜 상태 변경)
  Future<void> _toggleFavorite(int index, String itemId, bool isLiked, bool isFood) async {
    setState(() {
      // 먼저 찜 상태를 즉시 업데이트하여 UI 반영
      if (isFood) {
        _isLikedFood[index] = !isLiked;
      } else {
        _isLikedDessert[index] = !isLiked;
      }
    });
    try {
      // API URL 설정
      final url = isLiked ? 'https://api.example.com/unfavorite' : 'https://api.example.com/favorite';

      // HTTP POST 요청
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': 'example_user', // 실제 사용자 ID로 변경 필요
          'itemId': itemId,         // 찜할 아이템 ID
        }),
      );

      // 응답 상태 확인
      if (response.statusCode == 200) {
        setState(() {
          if (isFood) {
            _isLikedFood[index] = !isLiked; // 음식의 찜 상태 업데이트
          } else {
            _isLikedDessert[index] = !isLiked; // 디저트의 찜 상태 업데이트
          }
        });
        print('찜 상태가 서버에 반영되었습니다.');
      } else {
        // 오류 발생 시 응답 상태 코드 및 본문 출력
        print('찜 API 호출 실패: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      // 네트워크 요청 중 오류 발생 시 처리
      print('API 호출 중 오류 발생: $error');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트
    });
  }

  // 뒤로가기 버튼 두 번 클릭 시 앱 종료
  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    final maxDuration = Duration(seconds: 2); // 2초 내에 다시 뒤로가기를 눌러야 종료
    final isWarning = _lastBackPressed == null || now.difference(_lastBackPressed!) > maxDuration;

    if (isWarning) {
      _lastBackPressed = now;
      // Snackbar로 경고 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('한 번 더 누르면 앱이 종료됩니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false); // 앱을 종료하지 않음
    } else {
      // 2초 이내에 두 번째로 뒤로가기를 누르면 앱 종료
      if (Platform.isAndroid) {
        SystemNavigator.pop(); // 안드로이드 앱 종료
      } else if (Platform.isIOS) {
        exit(0); // iOS 앱 종료
      }
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // 뒤로가기 시 경고 메시지 표시
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _selectedIndex, // 현재 선택된 페이지 인덱스
          children: _pages,      // 페이지 리스트
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white, // 흰색 경계선
                width: 1.0, // 경계선 두께를 얇게 설정
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex, // 선택된 탭 인덱스
            onTap: _onItemTapped, // 클릭 시 호출되는 함수
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
                label: '찜',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 40, color: _selectedIndex == 4 ? Color(0xFF0367A6) : Colors.grey),
                label: '계정 정보',
              ),
            ],
            selectedLabelStyle: TextStyle(
              fontFamily: 'Yangjin', // 글씨체 변경
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Yangjin', // 글씨체 변경
              fontSize: 14,
            ),
            selectedItemColor: Color(0xFF0367A6), // 선택된 아이템 색상
            unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
            backgroundColor: Colors.white, // 배경은 Container에서 처리
          ),
        ),
      ),
    );
  }
}

class LobyPage extends StatelessWidget {
  final List<bool> isLikedFood; // 음식 찜 상태 리스트
  final Function(int, String, bool, bool) toggleFavorite; // 찜 상태 변경 함수

  // 생성자에서 상태와 함수를 받음
  LobyPage({required this.isLikedFood, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header with Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Image
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
                        height: 57,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Search Bar with Button Icons
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
                          style: TextStyle(
                            fontFamily: 'Yangjin',
                            color: Colors.grey,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '오늘 점심 뭐 먹지',
                            hintStyle: TextStyle(
                              fontFamily: 'Yangjin',
                              color: Colors.grey,
                            ),
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
          // Food Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Section Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '식당',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Yangjin',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Horizontal Scroll Food Items
                  Container(
                    height: 270,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      children: [
                        _buildFoodItem(
                          context,
                          '양념치킨',
                          'assets/images/seasoned_chicken.jpg',
                          '₩18,000 / 멕켄치킨',
                          starCount: 2,
                          isLiked: isLikedFood[0],
                          onLikeToggle: () {
                            toggleFavorite(
                                0, 'food_1', isLikedFood[0], true); // 찜 API 호출
                          },
                        ),
                        _buildFoodItem(
                          context,
                          '매콤쟁반짜장(2인)',
                          'assets/images/platter_jjajangmyeon.jpg',
                          '₩20,000 / 중국집',
                          starCount: 1,
                          isLiked: isLikedFood[1],
                          onLikeToggle: () {
                            toggleFavorite(
                                1, 'food_2', isLikedFood[1], true); // 찜 API 호출
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  // Dessert Section Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '카페',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Yangjin',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Horizontal Scroll Dessert Items
                  Container(
                    height: 270,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      children: [
                        _buildDessertItem(
                          context,
                          '딸기 눈꽃빙수',
                          'assets/images/딸기 눈꽃빙수.jpg',
                          '₩28,000 / GOGOSS COFFEE',
                          starCount: 2,
                          isLiked: isLikedFood[2],
                          onLikeToggle: () {
                            toggleFavorite(2, 'dessert_1', isLikedFood[2],
                                false); // 찜 API 호출
                          },
                        ),
                        _buildDessertItem(
                          context,
                          '딸기 쥬얼리 벨벳 밀크티',
                          'assets/images/딸기 쥬얼리 벨벳 밀크티.jpg',
                          '₩5,500 / 공차 아산순천향대점',
                          starCount: 1,
                          isLiked: isLikedFood[3],
                          onLikeToggle: () {
                            toggleFavorite(3, 'dessert_2', isLikedFood[3],
                                false); // 찜 API 호출
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(BuildContext context, String name, String imagePath,
      String price,
      {bool isNetwork = false, int starCount = 0, bool isLiked = false, required VoidCallback onLikeToggle}) {
    return GestureDetector(
      onTap: () {
        // 클릭 시 상세 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ReviewDetailPage(
                  itemName: name,
                  imagePath: imagePath,
                  description: '이 음식은 정말 맛있습니다! 추천드려요.', // 상세 설명
                  price: price,
                ),
          ),
        );
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: isNetwork
                        ? Image.network(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Yangjin',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    price,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Yangjin',
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 80,
              left: 8,
              child: Row(
                children: List.generate(
                  starCount,
                      (index) =>
                      Container(
                        padding: EdgeInsets.all(1), // 패딩 크기 줄임
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star,
                          color: Color(0xFFDAA520),
                          size: 20, // 아이콘 크기 줄임
                        ),
                      ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.all(0), // 패딩 크기 줄임
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 22, // 아이콘 크기 줄임
                  ),
                  onPressed: onLikeToggle, // 찜 상태 변경 함수 호출
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDessertItem(BuildContext context, String name, String imagePath,
      String price,
      {bool isNetwork = false, int starCount = 0, bool isLiked = false, required VoidCallback onLikeToggle}) {
    return GestureDetector(
      onTap: () {
        // 클릭 시 상세 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ReviewDetailPage(
                  itemName: name,
                  imagePath: imagePath,
                  description: '이 디저트는 정말 달콤합니다! 추천드려요.', // 상세 설명
                  price: price,
                ),
          ),
        );
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: isNetwork
                        ? Image.network(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Yangjin',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    price,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Yangjin',
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 80,
              left: 8,
              child: Row(
                children: List.generate(
                  starCount,
                      (index) =>
                      Container(
                        padding: EdgeInsets.all(1), // 패딩 크기 줄임
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star,
                          color: Color(0xFFDAA520),
                          size: 20, // 아이콘 크기 줄임
                        ),
                      ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.all(0), // 패딩 크기 줄임
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 22, // 아이콘 크기 줄임
                  ),
                  onPressed: onLikeToggle, // 찜 상태 변경 함수 호출
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('계정 정보 화면'),
    );
  }
}
