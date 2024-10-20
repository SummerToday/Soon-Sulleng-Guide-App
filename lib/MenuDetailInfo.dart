import 'package:flutter/material.dart';

class MenuDetailInfo extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final String description;
  final String price;

  // 생성자를 통해 데이터를 전달받음
  MenuDetailInfo({
    required this.itemName,
    required this.imagePath,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          itemName,
          style: TextStyle(
            fontFamily: 'Yangjin',
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xFF0367A6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 메뉴 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // 메뉴 이름
            Text(
              itemName,
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // 가격 정보
            Text(
              price,
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 20,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            // 설명
            Text(
              '상세 설명',
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
