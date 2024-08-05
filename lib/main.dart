import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InitalPageModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            bodyText2: TextStyle(fontFamily: 'Yangjin'),
          ),
        ),
        home: const InitalPageWidget(),
      ),
    );
  }
}

class InitalPageWidget extends StatefulWidget {
  const InitalPageWidget({super.key});

  @override
  State<InitalPageWidget> createState() => _InitalPageWidgetState();
}

class _InitalPageWidgetState extends State<InitalPageWidget>
    with TickerProviderStateMixin {
  late InitalPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<InitalPageModel>();

    // 애니메이션 설정
    Animate.defaultDuration = 600.ms;
    Animate.defaultCurve = Curves.easeInOut;
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF0367A6),
        body: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0.05),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/dishes-297268_1280.png',
                  width: 187,
                  height: 148,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 0),
                ),
              ).animate().rotate(begin: 0.0, end: 1.0),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -0.25),
              child: Text(
                '순슐랭 가이드',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Yangjin',
                  color: const Color(0xFFEFF5F9),
                  fontSize: 40,
                  letterSpacing: 0,
                ),
              ).animate().fadeIn(),
            ),
          ],
        ),
      ),
    );
  }
}

class InitalPageModel extends ChangeNotifier {
  final FocusNode unfocusNode = FocusNode();

  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }
}
