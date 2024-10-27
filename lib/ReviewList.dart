import 'package:flutter/material.dart';
import 'ReviewDetailPage.dart';

class ReviewList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  ReviewList({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
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
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '리뷰 목록',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Yangjin',
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewDetailPage(
                            storeName: review['storeName'],
                            reviewTitle: review['reviewTitle'],
                            menuName: review['menuName'],
                            reviewContent: review['reviewContent'],
                            reviewDateTime: review['reviewDateTime'],
                            price: review['price'],
                            stars: review['stars'],
                            images: [review['thumbnail']],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: ListTile(
                        leading: review['thumbnail'] != null && review['thumbnail'] != ''
                            ? Image.network(
                          review['thumbnail'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                          ),
                        ),
                        title: Text(
                          review['reviewTitle'] ?? '',
                          style: TextStyle(
                            fontFamily: 'Yangjin',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          review['reviewContent'] ?? '',
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
            ),
          ],
        ),
      ),
    );
  }
}
