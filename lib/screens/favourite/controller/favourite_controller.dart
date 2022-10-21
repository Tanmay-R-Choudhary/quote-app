import 'package:get/get.dart';
import 'package:quotes/utils/data_model.dart';
import 'package:flutter/material.dart';
import 'package:quotes/utils/database_controller.dart';

class FavouriteController extends GetxController {
  TextEditingController favQuote = TextEditingController();
  var quoteData = <Quote>[].obs;
  var filtersApplied = false.obs;
  @override
  void onInit() {
    _getData();
    super.onInit();
  }

  void _getData() {
    DatabaseController.instance.getAllRows().then((value) {
      value.forEach((element) {
        quoteData.add(Quote(
            id: element['id'],
            content: element['content'],
            author: element['author']));
      });
    });
  }

  void search() {
    quoteData.value.clear();
    DatabaseController.instance.searchFilter(favQuote.text).then((value) {
      value.forEach((element) {
        quoteData.add(Quote(
            id: element['id'],
            content: element['content'],
            author: element['author']));
      });
    });
    filtersApplied.value = true;
  }

  void clearFilters() {
    quoteData.value.clear();
    _getData();
    filtersApplied.value = false;
    favQuote.text = "";
  }

  void addData(String id, String content, String author) async {
    var search = await DatabaseController.instance.queryAllRows(id);
    if (search.isEmpty) {
      await DatabaseController.instance
          .insert(Quote(id: id, content: content, author: author));
      quoteData.insert(0, Quote(id: id, content: content, author: author));
    } else {
      Get.snackbar(
        "Error",
        "You have already added this to your favourites",
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void deleteAll() async {
    for (int i = 0; i < quoteData.length; i++) {
      await DatabaseController.instance.delete(quoteData[i].id);
    }

    quoteData.clear();
  }

  void deleteQuote(String id) async {
    await DatabaseController.instance.delete(id);
    quoteData.removeWhere((element) => element.id == id);
  }
}
