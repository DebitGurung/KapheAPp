import 'package:get/get.dart';
import 'package:kapheapp/network_manager/network_manager.dart';

import '../data/repositories/authentication/authentication_repository.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationRepository());

    Get.put(NetworkManager());
  }
}
