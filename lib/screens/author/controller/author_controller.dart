import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthorController extends GetxController {
  TextEditingController authorName = TextEditingController();

  var quote = "".obs;
  var quoteResponse = {};
  var displaying = false.obs;
  String id = "";
  String author = "";

  Random quoteIdx = Random();

  String formatAuthorName(String userInput) {
    String finalUrl = userInput.split(' ').join('-');
    return finalUrl;
  }

  Future<void> getAuthorQuote() async {
    var url = Uri.https('api.quotable.io', '/search/quotes', {
      'query': formatAuthorName(authorName.text),
      'fields': 'author',
      'limit': '10'
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonRes = convert.jsonDecode(response.body) as Map<String, dynamic>;
      quoteResponse = jsonRes;
      changeDisplayQuote();
    } else {
      Get.snackbar("Oops!", "Couldn't get a quote. Something went wrong.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderWidth: 5.0,
          borderColor: Colors.red,
          margin: const EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0));
    }
  }

  void changeDisplayQuote() {
    if (quoteResponse['results'].length != 0) {
      int idx = quoteIdx.nextInt(quoteResponse['results'].length);
      quote.value = quoteResponse['results'][idx]['content'];
      id = quoteResponse['results'][idx]['_id'];
      author = quoteResponse['results'][idx]['author'];
      displaying.value = true;
    } else {
      Get.snackbar("No quotes", "No quotes were found for this author",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderWidth: 5.0,
          borderColor: Colors.red,
          margin: const EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0));
    }
  }
}
