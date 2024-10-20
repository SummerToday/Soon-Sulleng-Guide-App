import 'package:flutter/material.dart';
import 'ReviewDetailPage.dart'; // 리뷰 상세 페이지 import

class ReviewList extends StatelessWidget {
  final List<Map<String, String>> _reviews = [
    {
      'title': '양념치킨 리뷰',
      'description': '정말 맛있어요! 추천드립니다.',
      'image': 'assets/images/seasoned_chicken.jpg'
    },
    {
      'title': '매콤쟁반짜장 리뷰',
      'description': '약간 매콤하지만 맛있어요.',
      'image': 'assets/images/platter_jjajangmyeon.jpg'
    },
    {
      'title': '딸기 눈꽃빙수 리뷰',
      'description': '달콤하고 시원해요!',
      'image': 'assets/images/딸기 눈꽃빙수.jpg'
    },
    {
      'title': '딸기 쥬얼리 벨벳 밀크티 리뷰',
      'description': '부드럽고 맛있는 밀크티!',
      'image': 'assets/images/딸기 쥬얼리 벨벳 밀크티.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          final review = _reviews[index];
          return GestureDetector(
            onTap: () {
              // 리뷰 항목을 클릭했을 때 상세 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewDetailPage(
                    itemName: review['title']!,
                    imagePath: review['image']!,
                    description: review['description']!,
                    price: '', // 가격 정보를 전달하지 않음 (리뷰에는 필요 없다고 가정)
                  ),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ListTile(
                leading: Image.asset(
                  review['image']!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  review['title']!,
                  style: TextStyle(
                    fontFamily: 'Yangjin',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  review['description']!,
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
    );
  }
}
