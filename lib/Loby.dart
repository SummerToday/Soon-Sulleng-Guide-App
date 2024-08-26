import 'package:flutter/material.dart';

class Loby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0367A6),
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
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Yangjin',
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/dishes-297268_1280.png',
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
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '궁금한 음식점·카페 검색',
                              hintStyle: TextStyle(
                                fontFamily: 'Yangjin',
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
                          color: Color(0xFFF4F2BB),
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
                              '김밥천국',
                              'https://cdn.pixabay.com/photo/2020/09/26/02/06/kimbap-5602613_1280.jpg',
                              '₩5,000 / 김밥'),
                          _buildFoodItem(
                              context,
                              '한식당',
                              'https://cdn.pixabay.com/photo/2016/03/05/19/02/kimchi-1238616_1280.jpg',
                              '₩12,000 / 불고기'),
                          _buildFoodItem(
                              context,
                              '중식당',
                              'https://cdn.pixabay.com/photo/2016/11/29/02/05/eggplant-1869691_1280.jpg',
                              '₩15,000 / 짜장면'),
                          _buildFoodItem(
                              context,
                              '이탈리안 레스토랑',
                              'https://cdn.pixabay.com/photo/2017/05/07/08/56/pasta-2298358_1280.jpg',
                              '₩20,000 / 파스타'),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Dessert Section Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '디저트',
                        style: TextStyle(
                          color: Color(0xFFF4F2BB),
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
                              '카페',
                              'https://cdn.pixabay.com/photo/2016/11/18/15/07/coffee-1838702_1280.jpg',
                              '₩7,000 / 아메리카노'),
                          _buildDessertItem(
                              context,
                              '베이커리',
                              'https://cdn.pixabay.com/photo/2014/11/08/00/39/bread-522866_1280.jpg',
                              '₩3,000 / 크루아상'),
                          _buildDessertItem(
                              context,
                              '아이스크림 가게',
                              'https://cdn.pixabay.com/photo/2017/05/23/22/40/ice-cream-2336623_1280.jpg',
                              '₩4,000 / 아이스크림'),
                          _buildDessertItem(
                              context,
                              '케이크 전문점',
                              'https://cdn.pixabay.com/photo/2017/03/27/13/27/cake-2178831_1280.jpg',
                              '₩6,000 / 치즈케이크'),
                        ],
                      ),
                    ),
                    SizedBox(height: 80), // Space for Bottom Navigation Bar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF0367A6),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  print('저장 목록 클릭됨');
                },
                borderRadius: BorderRadius.circular(50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        color: Color(0xFFF25592),
                        size: 40,
                      ),
                    ),
                    Text(
                      '저장 목록',
                      style: TextStyle(
                        fontFamily: 'Yangjin',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('평가 작성 클릭됨');
                },
                borderRadius: BorderRadius.circular(50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.border_color_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Text(
                      '평가 작성',
                      style: TextStyle(
                        fontFamily: 'Yangjin',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('계정 정보 클릭됨');
                },
                borderRadius: BorderRadius.circular(50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_circle,
                        color: Color(0xFF90F86D),
                        size: 40,
                      ),
                    ),
                    Text(
                      '계정 정보',
                      style: TextStyle(
                        fontFamily: 'Yangjin',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildFoodItem(
      BuildContext context, String name, String imagePath, String price) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Image.network(
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
      ),
    );
  }

  Widget _buildDessertItem(
      BuildContext context, String name, String imagePath, String price) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Image.network(
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
      ),
    );
  }
}
