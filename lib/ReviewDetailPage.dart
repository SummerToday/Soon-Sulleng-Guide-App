import 'package:flutter/material.dart';

class ReviewDetailPage extends StatelessWidget {
  final String storeName;
  final String reviewTitle;
  final String menuName;
  final String reviewContent;
  final String reviewDateTime;
  final String price;
  final int stars;
  final List<String> images; // 모든 이미지 경로 목록

  const ReviewDetailPage({
    Key? key,
    required this.storeName,
    required this.reviewTitle,
    required this.menuName,
    required this.reviewContent,
    required this.reviewDateTime,
    required this.price,
    required this.stars,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          reviewTitle, // 앱바에 리뷰 제목 표시
          style: TextStyle(
              fontFamily: 'Yangjin',
              color: Colors.white // Yangjin 폰트 적용
          ),
        ),
        backgroundColor: Color(0xFF0367A6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            images.isNotEmpty
                ? SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      images[index],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            )
                : Icon(
              Icons.restaurant_menu,
              size: 150,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '식당 이름: $storeName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Yangjin',
              ),
            ),
            SizedBox(height: 8),
            Text(
              '메뉴 이름: $menuName',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Yangjin',
              ),
            ),
            SizedBox(height: 8),
            Text(
              '리뷰 내용:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Yangjin',
              ),
            ),
            SizedBox(height: 4),
            Text(
              reviewContent,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Yangjin',
              ),
            ),
            SizedBox(height: 16),
            Text(
              '리뷰 날짜: $reviewDateTime',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Yangjin',
              ),
            ),
            SizedBox(height: 16),
            Text(
              '가격: $price',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Yangjin',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '별점:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Yangjin',
                  ),
                ),
                SizedBox(width: 8),
                Row(
                  children: List.generate(
                    stars,
                        (index) => Icon(
                      Icons.star,
                      color: Color(0xFFDAA520),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
