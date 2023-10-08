import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran/model/model.dart';
import 'package:http/http.dart' as http;

class services {
  Future<List<Result>> fetchData(int surahnum) async {
    List<Result> _dataList = [];
    try {
      final response = await http.get(
        Uri.parse(
            'https://quranenc.com/api/v1/translation/sura/urdu_junagarhi/$surahnum'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final dataList = jsonData['result'] as List<dynamic>;
        final parsedData =
            dataList.map((json) => Result.fromJson(json)).toList();

        _dataList = parsedData;
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger(child: SnackBar(content: Text(error.toString())));
      rethrow;
    }
    return _dataList;
  }
}
