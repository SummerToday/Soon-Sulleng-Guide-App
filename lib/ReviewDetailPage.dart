import 'package:flutter/material.dart';

class ReviewDetailPage extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final String description;
  final String price;

  // 생성자에서 필수 파라미터로 값을 전달받도록 함.
  const ReviewDetailPage({
    Key? key,
    required this.itemName,
    required this.imagePath,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          itemName, // 앱바에 음식 이름 표시
          style: TextStyle(fontFamily: 'Yangjin',
          color: Colors.white)// Yangjin 폰트 적용
        ),
        backgroundColor: Color(0xFF0367A6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Yangjin', // Yangjin 폰트 적용
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Price: $price',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Yangjin', // Yangjin 폰트 적용
              ),
            ),
          ],
        ),
      ),
    );
  }
}
