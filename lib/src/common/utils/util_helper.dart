import 'dart:developer';
import 'dart:typed_data';
import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;

class UtilHelper {
  static Future<bool> isConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult != ConnectivityResult.none);
  }

  static bool checkUnauthorized(String message) {
    return (message == ConstantsName.missingAnthentication);
  }

  static String generateInitialText(String text) {
    String initial = '';
    String initialDash = '--';
    if (text.length > 2) {
      if (text[text.length - 1] == ' ') {
        initialDash = text.substring(0, text.length - 2);
      } else {
        initialDash = text;
      }
      initial = '';
      initialDash.split(' ').map((String text) {
        if (initial.length != 5) {
          if (text.length < 2) {
            initial += text;
          } else {
            initial += text.substring(0, 1).toUpperCase();
          }
        }
      }).toList();
    } else {
      initial = text;
    }
    return initial;
  }

  static Future<CameraController> getCameraController(
    ResolutionPreset resolutionPreset,
    CameraLensDirection cameraLensDirection,
  ) async {
    final cameras = await availableCameras();
    List<bool> isAvailable =
        cameras.map((e) => e.lensDirection == cameraLensDirection).toList();
    CameraDescription camera;
    if (isAvailable.contains(true)) {
      camera = cameras.firstWhere(
        (camera) => camera.lensDirection == cameraLensDirection,
      );
    } else {
      camera = cameras.first;
    }
    return CameraController(camera, resolutionPreset, enableAudio: false);
  }

  static Future<List<int>> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }

  static String convertToAgo(BuildContext context, String dateTime) {
    final translate = AppLocalizations.of(context)!;
    DateTime input = DateFormat('yyyy-MM-DDTHH:mm:ss.SSSSSSZ').parse(
      dateTime,
      true,
    );
    Duration diff = DateTime.now().difference(input);
    if (diff.inDays > 1) {
      return DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
    } else if (diff.inDays == 1) {
      return translate.day(diff.inDays.toString());
    } else if (diff.inHours >= 1) {
      return translate.hour(diff.inHours.toString());
    } else if (diff.inMinutes >= 1) {
      return translate.minute(diff.inMinutes.toString());
    } else if (diff.inSeconds >= 1) {
      return translate.second(diff.inSeconds.toString());
    } else {
      return translate.justNow;
    }
  }

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return "${String.fromCharCode(0x1F1FA)}${String.fromCharCode(0x1F1F8)}";
      case 'id':
      default:
        return "${String.fromCharCode(0x1F1EE)}${String.fromCharCode(0x1F1E9)}";
    }
  }

  static Future<String> getLocation({
    required double lat,
    required double lon,
  }) async {
    try {
      GeoData placeMark = await Geocoder2.getDataFromCoordinates(
          latitude: lat,
          longitude: lon,
          googleMapApiKey: 'AIzaSyAJJfTE-42dwSTG68U-XEfRTDYQKEKYYyg');
      return placeMark.address;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
