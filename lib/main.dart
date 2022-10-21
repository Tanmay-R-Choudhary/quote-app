import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/screens/root/binding/root_binding.dart';
import 'package:quotes/screens/root/view/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Root(),
      initialBinding: RootBinding(),
    );
  }
}
