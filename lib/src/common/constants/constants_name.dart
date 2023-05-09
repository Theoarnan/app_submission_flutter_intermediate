import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConstantsName {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1';
  static const LatLng baseLocationLatLon = LatLng(-6.200000, 106.816666);

  static const String missingAnthentication = '401';

  static String baseDirImg = 'assets/img';
  static String baseDirJson = 'assets/json';
  static String baseDirImgLogo = '$baseDirImg/logo';
  static String baseDirImgIlustration = '$baseDirImg/ilustration';
  static String baseDirImgGif = '$baseDirImg/gif';

  static String imgLogo1 = '$baseDirImgLogo/logo1.png';
  static String imgLogo2 = '$baseDirImgLogo/logo2.png';
  static String imgLogo3 = '$baseDirImgLogo/logo3.png';
  static String imgLogo4 = '$baseDirImgLogo/logo4.png';

  static String gifLoadingImg = '$baseDirImgGif/loading_image.gif';
  static String gifErrorImg = '$baseDirImgGif/no_image.gif';
  static String gifNoConnectionImg = '$baseDirImgGif/no_connection.gif';
  static String gifErrorIlustrationImg = '$baseDirImgGif/error.gif';
  static String gifNotFoundIlustrationImg = '$baseDirImgGif/not_found.gif';
  static String gifNotDatalustrationImg = '$baseDirImgGif/no_data.gif';

  static String jsonMapStyle = '$baseDirJson/map_style.json';
}
