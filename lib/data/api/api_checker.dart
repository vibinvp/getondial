import 'package:getondial/controller/auth_controller.dart';
import 'package:getondial/controller/wishlist_controller.dart';
import 'package:getondial/helper/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) {
    if(response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      Get.find<WishListController>().removeWishes();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    }else {
      // showCustomSnackBar(response.statusText, getXSnackBar: getXSnackBar);
    }
  }
}
