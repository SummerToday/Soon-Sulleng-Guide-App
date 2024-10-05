import 'package:flutter/material.dart';

class Loby extends StatefulWidget {
  @override
  _LobyState createState() => _LobyState();
}

class _LobyState extends State<Loby> {
  List<bool> _isLikedFood = [false, false, false, false];
  List<bool> _isLikedDessert = [false, false, false, false];

  int _selectedIndex = 0; // 선택된 탭의 인덱스를 저장하는 변수, 기본은 홈(0)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                        '음식',
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
                            isLiked: _isLikedFood[0],
                            onLikeToggle: () {
                              setState(() {
                                _isLikedFood[0] = !_isLikedFood[0];
                              });
                            },
                          ),
                          _buildFoodItem(
                            context,
                            '매콤쟁반짜장(2인)',
                            'assets/images/platter_jjajangmyeon.jpg',
                            '₩20,000 / 중국집',
                            starCount: 1,
                            isLiked: _isLikedFood[1],
                            onLikeToggle: () {
                              setState(() {
                                _isLikedFood[1] = !_isLikedFood[1];
                              });
                            },
                          ),
                          _buildFoodItem(
                            context,
                            '중식당',
                            'https://cdn.pixabay.com/photo/2016/11/29/02/05/eggplant-1869691_1280.jpg',
                            '₩15,000 / 짜장면',
                            starCount: 0,
                            isLiked: _isLikedFood[2],
                            onLikeToggle: () {
                              setState(() {
                                _isLikedFood[2] = !_isLikedFood[2];
                              });
                            },
                          ),
                          _buildFoodItem(
                            context,
                            '이탈리안 레스토랑',
                            'https://cdn.pixabay.com/photo/2017/05/07/08/56/pasta-2298358_1280.jpg',
                            '₩20,000 / 파스타',
                            starCount: 0,
                            isLiked: _isLikedFood[3],
                            onLikeToggle: () {
                              setState(() {
                                _isLikedFood[3] = !_isLikedFood[3];
                              });
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
                        '디저트',
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
                            isLiked: _isLikedDessert[0],
                            onLikeToggle: () {
                              setState(() {
                                _isLikedDessert[0] = !_isLikedDessert[0];
                              });
                            },
                          ),
                          _buildDessertItem(
                            context,
                            '딸기 쥬얼리 벨벳 밀크티',
                            'assets/images/딸기 쥬얼리 벨벳 밀크티.jpg',
                            '₩5,500 / 공차 아산순천향대점',
                            starCount: 1,
                            isLiked: _isLikedDessert[1],
                            onLikeToggle: () {
                              setState(() {
                                _isLikedDessert[1] = !_isLikedDessert[1];
                              });
                            },
                          ),
                          _buildDessertItem(
                            context,
                            '아이스크림 가게',
                            'https://cdn.pixabay.com/photo/2017/05/23/22/40/ice-cream-2336623_1280.jpg',
                            '₩4,000 / 아이스크림',
                            starCount: 0,
                            isLiked: _isLikedDessert[2],
                            onLikeToggle: () {
                              setState(() {
                                _isLikedDessert[2] = !_isLikedDessert[2];
                              });
                            },
                          ),
                          _buildDessertItem(
                            context,
                            '케이크 전문점',
                            'https://cdn.pixabay.com/photo/2017/03/27/13/27/cake-2178831_1280.jpg',
                            '₩6,000 / 치즈케이크',
                            starCount: 0,
                            isLiked: _isLikedDessert[3],
                            onLikeToggle: () {
                              setState(() {
                                _isLikedDessert[3] = !_isLikedDessert[3];
                              });
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
              icon: Icon(Icons.favorite_rounded, size: 40, color: _selectedIndex == 1 ? Color(0xFF0367A6) : Colors.grey),
              label: '찜',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.border_color_outlined, size: 40, color: _selectedIndex == 2 ? Color(0xFF0367A6) : Colors.grey),
              label: '평가하기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 40, color: _selectedIndex == 3 ? Color(0xFF0367A6) : Colors.grey),
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
    );
  }

  Widget _buildFoodItem(BuildContext context, String name, String imagePath, String price,
      {bool isNetwork = false, int starCount = 0, bool isLiked = false, required VoidCallback onLikeToggle}) {
    return GestureDetector(
      onTap: () {
        print('$name 클릭됨');
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
            // 사진 위 좌하단 별 표시
            Positioned(
              bottom: 80,
              left: 8,
              child: Row(
                children: List.generate(
                  starCount,
                      (index) => Container(
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
            // 우상단 하트 버튼
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
                  onPressed: onLikeToggle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDessertItem(BuildContext context, String name, String imagePath, String price,
      {bool isNetwork = false, int starCount = 0, bool isLiked = false, required VoidCallback onLikeToggle}) {
    return GestureDetector(
      onTap: () {
        print('$name 클릭됨');
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
            // 사진 위 좌하단 별 표시
            Positioned(
              bottom: 100,
              left: 8,
              child: Row(
                children: List.generate(
                  starCount,
                      (index) => Container(
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
            // 우상단 하트 버튼
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.zero, // 패딩 크기 줄임
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
                  onPressed: onLikeToggle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
