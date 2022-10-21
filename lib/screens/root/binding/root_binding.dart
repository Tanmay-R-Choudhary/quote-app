import 'package:get/get.dart';
import 'package:quotes/screens/root/controller/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController());
  }

}