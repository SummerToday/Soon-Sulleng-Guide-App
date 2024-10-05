import 'package:flutter/material.dart';

class FavoriteListScreen extends StatelessWidget {
  // 예시로 찜한 항목 리스트
  final List<String> favoriteItems;

  FavoriteListScreen({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('찜 목록', style: TextStyle(fontFamily: 'Yangjin')),
        backgroundColor: Color(0xFF0367A6), // 상단바 색상
      ),
      body: favoriteItems.isEmpty
          ? Center(
        child: Text(
          '찜한 항목이 없습니다.',
          style: TextStyle(fontFamily: 'Yangjin', fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.favorite, color: Colors.red), // 찜 아이콘
            title: Text(
              favoriteItems[index],
              style: TextStyle(
                fontFamily: 'Yangjin',
                fontSize: 18,
              ),
            ),
            onTap: () {
              // 항목 클릭 시 동작 설정 가능
              print('${favoriteItems[index]} 선택됨');
            },
          );
        },
      ),
    );
  }
}

