import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageManager extends ChangeNotifier {
  late Completer<XFile?> _completerImage;

  Future<XFile?> waitForResultImage() async {
    _completerImage = Completer<XFile?>();
    return _completerImage.future;
  }

  void returnDataImage(XFile? value) {
    _completerImage.complete(value);
  }
}
