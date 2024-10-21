import 'dart:async';

import 'package:getondial/controller/location_controller.dart';
import 'package:getondial/controller/order_controller.dart';
import 'package:getondial/controller/splash_controller.dart';
import 'package:getondial/controller/theme_controller.dart';
import 'package:getondial/data/model/response/zone_response_model.dart';
import 'package:getondial/helper/responsive_helper.dart';
import 'package:getondial/helper/route_helper.dart';
import 'package:getondial/util/dimensions.dart';
import 'package:getondial/util/images.dart';
import 'package:getondial/util/styles.dart';
import 'package:getondial/view/base/custom_button.dart';
import 'package:getondial/view/base/footer_view.dart';
import 'package:getondial/view/base/menu_drawer.dart';
import 'package:getondial/view/base/web_menu_bar.dart';
import 'package:getondial/view/screens/checkout/widget/payment_failed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSuccessfulScreen extends StatefulWidget {
  final String? orderID;
  const OrderSuccessfulScreen({Key? key, required this.orderID})
      : super(key: key);

  @override
  State<OrderSuccessfulScreen> createState() => _OrderSuccessfulScreenState();
}

class _OrderSuccessfulScreenState extends State<OrderSuccessfulScreen> {
  bool? _isCashOnDeliveryActive = false;

  @override
  void initState() {
    super.initState();

    Get.find<OrderController>()
        .trackOrder(widget.orderID.toString(), null, false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          await Get.offAllNamed(RouteHelper.getInitialRoute());
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
        endDrawer: const MenuDrawer(),
        endDrawerEnableOpenDragGesture: false,
        body: GetBuilder<OrderController>(builder: (orderController) {
          double total = 0;
          bool success = true;
          bool parcel = false;
          double? maximumCodOrderAmount;
          if (orderController.trackModel != null) {
            total = ((orderController.trackModel!.orderAmount! / 100) *
                Get.find<SplashController>()
                    .configModel!
                    .loyaltyPointItemPurchasePoint!);
            success = orderController.trackModel!.paymentStatus == 'paid' ||
                orderController.trackModel!.paymentMethod == 'cash_on_delivery';
            parcel = orderController.trackModel!.paymentMethod == 'parcel';
            for (ZoneData zData
                in Get.find<LocationController>().getUserAddress()!.zoneData!) {
              for (Modules m in zData.modules!) {
                if (m.id == Get.find<SplashController>().module!.id) {
                  maximumCodOrderAmount = m.pivot!.maximumCodOrderAmount;
                  break;
                }
              }
              if (zData.id ==
                  Get.find<LocationController>().getUserAddress()!.zoneId) {
                _isCashOnDeliveryActive = zData.cashOnDelivery;
              }
            }

            if (!success &&
                !Get.isDialogOpen! &&
                orderController.trackModel!.orderStatus != 'canceled') {
              Future.delayed(const Duration(seconds: 1), () {
                Get.dialog(
                    PaymentFailedDialog(
                        orderID: widget.orderID,
                        isCashOnDelivery: _isCashOnDeliveryActive,
                        orderAmount: total,
                        maxCodOrderAmount: maximumCodOrderAmount,
                        orderType: parcel ? 'parcel' : 'delivery'),
                    barrierDismissible: false);
              });
            }
          }

          return orderController.trackModel != null
              ? Center(
                  child: SingleChildScrollView(
                    child: FooterView(
                        child: SizedBox(
                            width: Dimensions.webMaxWidth,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      success ? Images.checked : Images.warning,
                                      width: 100,
                                      height: 100),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeLarge),
                                  Text(
                                    success
                                        ? parcel
                                            ? Get.find<SplashController>()
                                                        .module!
                                                        .id ==
                                                    2
                                                ? 'Appointment Is Booked Successfully'
                                                : Get.find<SplashController>()
                                                            .module!
                                                            .id ==
                                                        3
                                                    ? 'Service Is Booked Successfully'
                                                    : 'you_placed_the_parcel_request_successfully'
                                                        .tr
                                            : Get.find<SplashController>()
                                                        .module!
                                                        .id ==
                                                    2
                                                ? 'Appointment Is Booked Successfully'
                                                : Get.find<SplashController>()
                                                            .module!
                                                            .id ==
                                                        3
                                                    ? 'Service Is Booked Successfully'
                                                    : 'you_placed_the_order_successfully'
                                                        .tr
                                        : Get.find<SplashController>()
                                                    .module!
                                                    .id ==
                                                2
                                            ? 'Appointment Is Failed To Book'
                                            : Get.find<SplashController>()
                                                        .module!
                                                        .id ==
                                                    3
                                                ? 'Service Is Failed To Book'
                                                : 'your_order_is_failed_to_place'
                                                    .tr,
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeLarge),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeLarge,
                                        vertical: Dimensions.paddingSizeSmall),
                                    child: Text(
                                      success
                                          ? parcel
                                              ? Get.find<SplashController>()
                                                          .module!
                                                          .id ==
                                                      2
                                                  ? 'Your appointment request is placed successfully'
                                                  : Get.find<SplashController>()
                                                              .module!
                                                              .id ==
                                                          3
                                                      ? 'Your service request is placed successfully'
                                                      : 'your_parcel_request_is_placed_successfully'
                                                          .tr
                                              : Get.find<SplashController>()
                                                          .module!
                                                          .id ==
                                                      2
                                                  ? 'Your appointment request is placed successfully'
                                                  : Get.find<SplashController>()
                                                              .module!
                                                              .id ==
                                                          3
                                                      ? 'Your service request is placed successfully'
                                                      : 'your_order_is_placed_successfully'
                                                          .tr
                                          : Get.find<SplashController>()
                                                      .module!
                                                      .id ==
                                                  2
                                              ? 'Your appointment request is Failed because your payment got failed. Please make sure a successful payment to place an appointment. '
                                              : Get.find<SplashController>()
                                                          .module!
                                                          .id ==
                                                      3
                                                  ? 'Your service request is Failed because your payment got failed. Please make sure a successful payment to place an service.'
                                                  : 'your_order_is_failed_to_place_because'
                                                      .tr,
                                      style: robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color:
                                              Theme.of(context).disabledColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ResponsiveHelper.isDesktop(context) &&
                                          (success &&
                                              Get.find<SplashController>()
                                                      .configModel!
                                                      .loyaltyPointStatus ==
                                                  1 &&
                                              total.floor() > 0)
                                      ? Column(children: [
                                          Image.asset(
                                              Get.find<ThemeController>()
                                                      .darkTheme
                                                  ? Images.congratulationDark
                                                  : Images.congratulationLight,
                                              width: 150,
                                              height: 150),
                                          Text('congratulations'.tr,
                                              style: robotoMedium.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeLarge)),
                                          const SizedBox(
                                              height:
                                                  Dimensions.paddingSizeSmall),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeLarge),
                                            child: Text(
                                              '${'you_have_earned'.tr} ${total.floor().toString()} ${'points_it_will_add_to'.tr}',
                                              style: robotoRegular.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                  color: Theme.of(context)
                                                      .disabledColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ])
                                      : const SizedBox.shrink(),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    child: CustomButton(
                                        buttonText: 'back_to_home'.tr,
                                        onPressed: () => Get.offAllNamed(
                                            RouteHelper.getInitialRoute())),
                                  ),
                                ]))),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
