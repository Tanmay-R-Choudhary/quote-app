import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/screens/favourite/controller/favourite_controller.dart';
import 'package:quotes/utils/database_controller.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    FavouriteController controller = Get.put(FavouriteController());
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 30.0,
                  bottom: 30.0,
                  right: 15.0,
                ),
                child: TextField(
                  controller: controller.favQuote,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 5)),
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10.0)),
              child: IconButton(
                onPressed: () {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  //TODO: IMPLEMENT METHOD TO SEARCH QUOTE
                  if (controller.filtersApplied.value) {
                    controller.clearFilters();
                  } else {
                    controller.search();
                  }
                },
                icon: Obx(
                  () => Icon(
                    controller.filtersApplied.value
                        ? FontAwesomeIcons.xmark
                        : FontAwesomeIcons.magnifyingGlass,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
        Obx(
          () => Expanded(
            child: SizedBox(
              height: Get.mediaQuery.size.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.quoteData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Container(
                          width: Get.mediaQuery.size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller
                                  .deleteQuote(controller.quoteData[index].id);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.trashCan,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: Get.mediaQuery.size.height * 0.4,
                          width: Get.mediaQuery.size.width - 40,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 5.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Text(
                                controller.quoteData[index].content,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          controller.quoteData[index].author,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              controller.deleteAll();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              "Delete all",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
