import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/screens/author/view/author.dart';
import 'package:quotes/screens/favourite/view/favourite.dart';
import 'package:quotes/screens/search/view/search.dart';

class RootController extends GetxController {
  var pageIndex = 1.obs;

  final pages = const [Search(), Author(), Favourite()];

  void updatePageIndex(int idx) {
    pageIndex.value = idx;
  }
}
