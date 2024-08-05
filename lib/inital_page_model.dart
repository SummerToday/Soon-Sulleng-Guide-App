import 'package:flutter/material.dart';

class InitalPageModel with ChangeNotifier {
  final FocusNode unfocusNode = FocusNode();

  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }
}
