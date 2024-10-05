import 'package:flutter/material.dart';

class WriteReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header 없이 리뷰 작성 폼 시작
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '리뷰 작성',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Yangjin',
                ),
              ),
            ),
            SizedBox(height: 10),
            // Review Form Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: '음식 이름',
                        labelStyle: TextStyle(
                          fontFamily: 'Yangjin',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: '리뷰 내용을 입력하세요',
                        labelStyle: TextStyle(
                          fontFamily: 'Yangjin',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '별점',
                          style: TextStyle(
                            fontFamily: 'Yangjin',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.star_border, size: 30, color: Colors.amber),
                        Icon(Icons.star_border, size: 30, color: Colors.amber),
                        Icon(Icons.star_border, size: 30, color: Colors.amber),
                        Icon(Icons.star_border, size: 30, color: Colors.amber),
                        Icon(Icons.star_border, size: 30, color: Colors.amber),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        print('리뷰 작성 완료');
                      },
                      child: Text(
                        '리뷰 작성하기',
                        style: TextStyle(
                          fontFamily: 'Yangjin',
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0367A6), // 버튼 배경색
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
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
}
