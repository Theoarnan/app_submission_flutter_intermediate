import 'dart:typed_data';
import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class UtilHelper {
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
      CameraLensDirection cameraLensDirection) async {
    final cameras = await availableCameras();
    cameras[1];
    final camera = cameras
        .firstWhere((camera) => camera.lensDirection == cameraLensDirection);

    return CameraController(camera, resolutionPreset, enableAudio: false);
  }

  static Future<String> getPath() async => join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

  static Future<List<int>> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      ///
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }

  static String convertToAgo(String dateTime) {
    DateTime input = DateFormat('yyyy-MM-DDTHH:mm:ss.SSSSSSZ').parse(
      dateTime,
      true,
    );
    Duration diff = DateTime.now().difference(input);
    if (diff.inDays > 1) {
      return DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
    } else if (diff.inDays == 1) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }
}
