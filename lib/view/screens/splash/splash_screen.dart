import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:getondial/controller/auth_controller.dart';
import 'package:getondial/controller/cart_controller.dart';
import 'package:getondial/controller/location_controller.dart';
import 'package:getondial/controller/splash_controller.dart';
import 'package:getondial/controller/wishlist_controller.dart';
import 'package:getondial/data/model/body/notification_body.dart';
import 'package:getondial/helper/route_helper.dart';
import 'package:getondial/util/app_constants.dart';
import 'package:getondial/util/dimensions.dart';
import 'package:getondial/util/images.dart';
import 'package:getondial/view/base/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({Key? key, required this.body}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  initState() {
    super.initState();

    bool firstTime = true;
    // _onConnectivityChanged = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   if (!firstTime) {
    //     bool isNotConnected = result != ConnectivityResult.wifi &&
    //         result != ConnectivityResult.mobile;
    //     isNotConnected
    //         ? const SizedBox()
    //         : ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: isNotConnected ? Colors.red : Colors.green,
    //       duration: Duration(seconds: isNotConnected ? 6000 : 3),
    //       content: Text(
    //         isNotConnected ? 'no_connection'.tr : 'connected'.tr,
    //         textAlign: TextAlign.center,
    //       ),
    //     ));
    //     if (!isNotConnected) {
    //       _route();
    //     }
    //   }
    //   firstTime = false;
    // });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   final PendingDynamicLinkData? data =
    //       await FirebaseDynamicLinks.instance.getInitialLink();
    //   handleSuccessfulLinking(data);
    // });
    Get.find<SplashController>().initSharedData();
    Get.find<CartController>().getCartData();
    _route();
  }

  // handleSuccessfulLinking(PendingDynamicLinkData? data) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   final Uri? deepLink = data?.link;
  //   print(deepLink.toString());
  //   if (deepLink != null) {
  //     var isRefer = deepLink.toString().contains('referralCode');
  //     if (isRefer) {
  //       dynamic code = deepLink.toString().split('referralCode=')[1];
  //       print("code ::: $code");
  //       if (code != null) {
  //         await sharedPreferences.setString(
  //             AppConstants.referralCode, code.toString());
  //       }
  //     }
  //   }
  // }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if (isSuccess) {
        Timer(const Duration(seconds: 1), () async {
          double? minimumVersion = 0;
          if (GetPlatform.isAndroid) {
            minimumVersion = Get.find<SplashController>()
                .configModel!
                .appMinimumVersionAndroid;
          } else if (GetPlatform.isIOS) {
            minimumVersion =
                Get.find<SplashController>().configModel!.appMinimumVersionIos;
          }
          if (AppConstants.appVersion < minimumVersion! ||
              Get.find<SplashController>().configModel!.maintenanceMode!) {
            Get.offNamed(RouteHelper.getUpdateRoute(
                AppConstants.appVersion < minimumVersion));
          } else {
            if (widget.body != null) {
              if (widget.body!.notificationType == NotificationType.order) {
                Get.offNamed(RouteHelper.getOrderDetailsRoute(
                    widget.body!.orderId,
                    fromNotification: true));
              } else if (widget.body!.notificationType ==
                  NotificationType.general) {
                Get.offNamed(
                    RouteHelper.getNotificationRoute(fromNotification: true));
              } else {
                Get.offNamed(RouteHelper.getChatRoute(
                    notificationBody: widget.body,
                    conversationID: widget.body!.conversationId,
                    fromNotification: true));
              }
            } else {
              if (Get.find<AuthController>().isLoggedIn()) {
                Get.find<AuthController>().updateToken();
                if (Get.find<LocationController>().getUserAddress() != null) {
                  await Get.find<WishListController>().getWishList();
                  Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
                } else {
                  Get.find<LocationController>()
                      .navigateToLocationScreen('splash', offNamed: true);
                }
              } else {
                if (Get.find<SplashController>().showIntro()!) {
                  // if(AppConstants.languages.length > 1) {
                  //   Get.offNamed(RouteHelper.getLanguageRoute('splash'));
                  // }
                  {
                    Get.offNamed(RouteHelper.getOnBoardingRoute());
                  }
                } else {
                  Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                }
              }
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>().initSharedData();
    if (Get.find<LocationController>().getUserAddress() != null &&
        Get.find<LocationController>().getUserAddress()!.zoneIds == null) {
      Get.find<AuthController>().clearSharedAddress();
    }

    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
          child: splashController.hasConnection
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Images.logo, width: 200),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    // Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25)),
                  ],
                )
              : NoInternetScreen(child: SplashScreen(body: widget.body)),
        );
      }),
    );
  }
}
