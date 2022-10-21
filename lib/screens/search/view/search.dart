import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quotes/screens/search/controller/search_controller.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    SearchController controller = Get.put(SearchController());
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Stack(
      children: [
        Obx(
          () => ListView.builder(
            padding: const EdgeInsets.only(top: 210.0),
            itemCount: controller.displaying.value == false
                ? 0
                : controller.quotes['count'],
            itemBuilder: (context, index) {
              return QuotesListCard(
                index: index,
              );
            },
          ),
        ),
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
                  controller: controller.topic,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter a topic",
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
                  controller.getQuotesList();
                },
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 105),
          child: Container(
            height: 90.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black, width: 5.0),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                Obx(
                  () => Text(
                    "Count: ${controller.limit.value}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Obx(
                  () => Slider(
                    thumbColor: Colors.pink,
                    activeColor: Colors.blueGrey,
                    inactiveColor: Colors.pink.shade100,
                    min: 1.0,
                    max: 100.0,
                    value: controller.limit.value.toDouble(),
                    onChanged: (val) {
                      controller.updateSlider(val);
                    },
                    onChangeEnd: (val) {
                      controller.getQuotesList();
                    },
                    divisions: 100,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class QuotesListCard extends StatelessWidget {
  const QuotesListCard({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    SearchController controller = Get.find();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 40.0, bottom: 20.0),
          child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.blueGrey, width: 5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      controller.quotes['results'][index]['content'],
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "- ${controller.quotes['results'][index]['author']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              controller.addData(
                controller.quotes['results'][index]['_id'],
                controller.quotes['results'][index]['content'],
                controller.quotes['results'][index]['author'],
              );
              Get.snackbar(
                "Saved",
                "The quote was saved to your phone",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                borderWidth: 5.0,
                borderColor: Colors.black,
                margin: const EdgeInsets.only(
                    bottom: 50.0, left: 20.0, right: 20.0),
              );
            },
            icon: const Icon(
              FontAwesomeIcons.heart,
              color: Colors.black,
              size: 25.0,
            ),
          ),
        ),
      ],
    );
  }
}
