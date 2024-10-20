import 'package:flutter/material.dart';
import 'MenuDetailInfo.dart'; // MenuDetailInfo 페이지 import

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with "순슐랭가이드" and Icon (same as in Home screen)
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
                          'assets/images/swapped_dishs.png', // 아이콘 경로
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
                '내가 찜한 메뉴들',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Yangjin',
                ),
              ),
            ),
            SizedBox(height: 10),
            // Favorite Items List
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    _buildFavoriteItem(
                      context,
                      '양념치킨',
                      'assets/images/seasoned_chicken.jpg',
                      '₩18,000 / 멕켄치킨',
                      '정말 맛있어요! 추천드립니다.', // 상세 설명 추가
                    ),
                    _buildFavoriteItem(
                      context,
                      '딸기 눈꽃빙수',
                      'assets/images/딸기 눈꽃빙수.jpg',
                      '₩28,000 / GOGOSS COFFEE',
                      '달콤하고 시원해요!', // 상세 설명 추가
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

  Widget _buildFavoriteItem(BuildContext context, String name, String imagePath, String price, String description) {
    return GestureDetector(
      onTap: () {
        // 클릭 시 해당 메뉴의 상세 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailInfo(
              itemName: name,
              imagePath: imagePath,
              description: description,
              price: price,
            ),
          ),
        );
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
              child: Image.asset(
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
                print('$name 삭제 클릭됨');
              },
            ),
          ],
        ),
      ),
    );
  }
}
