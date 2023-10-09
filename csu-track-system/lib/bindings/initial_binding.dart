import 'package:get/get.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/services/services.dart';

//THIS CODE USED FOR BINDING THE AUTH CONTROLLER TO MAKE IT FUNCTIONAL

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);

    Get.put(NotificationService());
    Get.lazyPut(() => FireBaseStorageService());
  }
}
