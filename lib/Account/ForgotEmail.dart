import 'package:flutter/material.dart';

class ForgotEmail extends StatefulWidget {
  const ForgotEmail({super.key});

  @override
  State<ForgotEmail> createState() => _ForgotEmailState();
}

class _ForgotEmailState extends State<ForgotEmail> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  String recoveredEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0367A6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 동작
          },
        ),
      ),
      backgroundColor: const Color(0xFF0367A6),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '이메일 찾기',
                style: TextStyle(
                  fontFamily: 'Yangjin',
                  color: Colors.white, // 제목을 흰색으로 설정
                  fontSize: 40,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 60), // 제목과 박스 사이의 간격
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(
                  maxWidth: 570,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: '이름',
                        labelStyle: const TextStyle(
                          fontFamily: 'Yangjin',
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                        Theme.of(context).inputDecorationTheme.fillColor,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Yangjin',
                        letterSpacing: 0,
                      ),
                      cursorColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: birthDateController,
                      decoration: InputDecoration(
                        labelText: '생년월일',
                        labelStyle: const TextStyle(
                          fontFamily: 'Yangjin',
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                        Theme.of(context).inputDecorationTheme.fillColor,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Yangjin',
                        letterSpacing: 0,
                      ),
                      cursorColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // 이메일 복구 로직 추가
                            recoveredEmail = 'example@example.com';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF787DEA), // primary 대신 backgroundColor
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          '이메일 힌트 얻기',
                          style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontFamily: 'Yangjin',
                            letterSpacing: 0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    if (recoveredEmail.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          '이메일 힌트: $recoveredEmail',
                          style: TextStyle(
                            fontFamily: 'Yangjin',
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
