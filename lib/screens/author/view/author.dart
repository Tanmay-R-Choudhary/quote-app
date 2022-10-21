import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/screens/author/controller/author_controller.dart';
import 'package:quotes/utils/data_model.dart';
import 'package:quotes/utils/database_controller.dart';

class Author extends StatelessWidget {
  const Author({super.key});

  @override
  Widget build(BuildContext context) {
    AuthorController controller = Get.put(AuthorController());
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
                  controller: controller.authorName,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0),
                  decoration: InputDecoration(
                    hintText: "Enter an author",
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
                  controller.getAuthorQuote();
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
        const QuoteCard(),
        Obx(() => controller.displaying.value == false
            ? const SizedBox(
                width: 5.0,
              )
            : Row(
                children: const [
                  Expanded(
                    child: ChangeQuote(),
                  ),
                  FavouriteButton()
                ],
              )),
      ],
    );
  }
}

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthorController controller = Get.find();

    return Obx(
      () => controller.displaying.value == false
          ? const Center(
              child: Text(
                "Search an author to get a quote!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: Get.mediaQuery.size.height * 0.58,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Obx(
                        () => Text(
                          controller.quote.value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class ChangeQuote extends StatelessWidget {
  const ChangeQuote({super.key});

  @override
  Widget build(BuildContext context) {
    AuthorController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
      child: GestureDetector(
        onTap: () {
          controller.changeDisplayQuote();
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: Text(
              "Get another quote",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    AuthorController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.pink, borderRadius: BorderRadius.circular(10.0)),
        child: IconButton(
          onPressed: () {
            DatabaseController.instance.insert(
              Quote(
                  id: controller.id,
                  content: controller.quote.value,
                  author: controller.author),
            );
            Get.snackbar(
              "Saved",
              "The quote was saved to your phone",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderWidth: 5.0,
              borderColor: Colors.black,
              margin:
                  const EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.solidThumbsUp,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
