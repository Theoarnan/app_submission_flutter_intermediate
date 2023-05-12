import 'dart:convert';
import 'dart:io';

import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/shared_preference_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/detail_stories_response_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/post_stories_response_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class StoriesRepository {
  /// Endpoint
  final String storiesEndpoint = '${ConstantsName.baseUrl}/stories';
  final String getDetailStoriesEndpoint = '${ConstantsName.baseUrl}/stories';
  Map<String, String> header({required String token}) => {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };

  Future<StoriesResponseModel> getAllStory([
    int page = 1,
    int size = 10,
  ]) async {
    final withLocation = UtilHelper.getIsPaidApp() ? 1 : 0;
    final url = Uri.parse(
      '$storiesEndpoint?page=$page&size=$size&location=$withLocation',
    );
    final token = await getToken();
    final response = await http.get(
      url,
      headers: header(
        token: token,
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      final data = StoriesResponseModel.fromJson(json.decode(response.body));
      return data;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      final data = StoriesResponseModel(
        error: true,
        message: HttpStatus.unauthorized.toString(),
        dataStory: [],
      );
      return data;
    } else {
      throw Exception('Failed to get all data stories');
    }
  }

  Future<DetailStoriesResponseModel> getDetailStory({
    required String id,
  }) async {
    final token = await getToken();
    final url = Uri.encodeFull('$getDetailStoriesEndpoint/$id');
    final response = await http.get(
      Uri.parse(url),
      headers: header(
        token: token,
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      final data = DetailStoriesResponseModel.fromJson(
        json.decode(response.body),
      );
      return data;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      final data = DetailStoriesResponseModel(
        error: true,
        message: HttpStatus.unauthorized.toString(),
        dataStory: const StoriesModel(
          id: '',
          name: '',
          description: '',
          photoUrl: '',
          createdAt: '',
          lat: null,
          lon: null,
        ),
      );
      return data;
    } else {
      throw Exception('Failed to get detail data stories');
    }
  }

  Future<PostStoriesResponseModel> postStory({
    required List<int> bytes,
    required String fileName,
    required String description,
    LatLng? latLng,
  }) async {
    final token = await getToken();
    final url = Uri.parse(storiesEndpoint);
    var request = http.MultipartRequest('POST', url);
    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      bytes,
      filename: fileName,
    );
    final isAvailaleLocation = latLng != null;
    Map<String, String> fields;
    if (isAvailaleLocation && UtilHelper.getIsPaidApp()) {
      fields = {
        "description": description,
        "lat": latLng.latitude.toString(),
        "lon": latLng.longitude.toString(),
      };
    } else {
      fields = {
        "description": description,
      };
    }
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $token',
    };
    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);
    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;
    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);
    if (statusCode == HttpStatus.created) {
      final PostStoriesResponseModel uploadResponse =
          PostStoriesResponseModel.fromMap(
        responseData,
      );
      return uploadResponse;
    } else if (statusCode == HttpStatus.unauthorized) {
      return PostStoriesResponseModel(
        error: true,
        message: HttpStatus.unauthorized.toString(),
      );
    } else {
      throw Exception('Failed to post stories');
    }
  }

  Future<String> getToken() async {
    return SharedPreferencesHelper().token;
  }
}
