import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'api_model.dart';

class ApiUrl {
  static String baseUrl = "https://api.tvmaze.com/search/shows?q=";
}

class ApiService {
  Future<List<ApiResponse>> getMovie(String search) async {
    final Uri uri = Uri.parse("${ApiUrl.baseUrl}$search");
    log("${uri}");

    try {
      final response = await http.get(uri);
      log("${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> resData = jsonDecode(response.body);
        List<ApiResponse> apiResponse = resData
            .map<ApiResponse>((data) => ApiResponse.fromJson(data))
            .toList();

        log("Fetched ${apiResponse.length} movies/shows.");
        return apiResponse;
      } else {
        log("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      log("Server error: $e");
    }
    return [];
  }

}
