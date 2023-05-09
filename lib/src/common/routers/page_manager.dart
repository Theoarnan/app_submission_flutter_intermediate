import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PageManager extends ChangeNotifier {
  late Completer<XFile?> _completerImage;
  late Completer<LatLng?> _completerLocation;

  Future<XFile?> waitForResultImage() async {
    _completerImage = Completer<XFile?>();
    return _completerImage.future;
  }

  Future<LatLng?> waitForResultLocation() async {
    _completerLocation = Completer<LatLng?>();
    return _completerLocation.future;
  }

  void returnDataImage(XFile? value) {
    _completerImage.complete(value);
  }

  void returnDataLocation(LatLng? value) {
    _completerLocation.complete(value);
  }
}
