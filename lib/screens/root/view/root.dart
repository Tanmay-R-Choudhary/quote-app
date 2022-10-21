import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/screens/favourite/controller/favourite_controller.dart';
import 'package:quotes/screens/root/controller/root_controller.dart';

class Root extends GetView<RootController> {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() => controller.pages[controller.pageIndex.value]),
        bottomNavigationBar: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            border: Border.all(
              color: Colors.black,
              width: 5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () => IconButton(
                  onPressed: () {
                    Get.delete<FavouriteController>();
                    controller.updatePageIndex(0);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 30,
                  ),
                  color: controller.pageIndex.value == 0
                      ? Colors.pink
                      : Colors.black,
                ),
              ),
              Obx(
                () => IconButton(
                  onPressed: () {
                    Get.delete<FavouriteController>();
                    controller.updatePageIndex(1);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.list,
                    size: 30,
                  ),
                  color: controller.pageIndex.value == 1
                      ? Colors.pink
                      : Colors.black,
                ),
              ),
              Obx(
                () => IconButton(
                  onPressed: () {
                    controller.updatePageIndex(2);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.heart,
                    size: 30,
                  ),
                  color: controller.pageIndex.value == 2
                      ? Colors.pink
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
