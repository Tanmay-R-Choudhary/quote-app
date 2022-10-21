import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quotes/utils/data_model.dart';
import 'dart:convert' as convert;

import 'package:quotes/utils/database_controller.dart';

class SearchController extends GetxController {
  TextEditingController topic = TextEditingController();

  var quotes = {}.obs;
  var limit = 10.obs;
  var displaying = false.obs;

  Future<void> getQuotesList() async {
    String finalURL = topic.text.split(' ').join('+');
    var url = Uri.https('api.quotable.io', '/search/quotes',
        {'query': finalURL, 'limit': limit.toString()});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      quotes.value = convert.jsonDecode(response.body) as Map<String, dynamic>;
      displaying.value = true;
    }
  }

  void addData(String id, String content, String author) async {
    await DatabaseController.instance
        .insert(Quote(id: id, content: content, author: author));
  }

  void updateSlider(double val) {
    limit.value = val.toInt();
  }
}
