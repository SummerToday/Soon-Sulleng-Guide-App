import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth2LoginModel with ChangeNotifier {
  TextEditingController? emailAddressTextController;
  FocusNode? emailAddressFocusNode;

  TextEditingController? passwordTextController;
  FocusNode? passwordFocusNode;

  bool passwordVisibility = false;

  final unfocusNode = FocusNode();

  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;

  void dispose() {
    emailAddressTextController?.dispose();
    emailAddressFocusNode?.dispose();
    passwordTextController?.dispose();
    passwordFocusNode?.dispose();
    unfocusNode.dispose();
  }
}
