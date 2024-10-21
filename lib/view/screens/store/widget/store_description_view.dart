import 'package:getondial/controller/auth_controller.dart';
import 'package:getondial/controller/store_controller.dart';
import 'package:getondial/controller/splash_controller.dart';
import 'package:getondial/controller/wishlist_controller.dart';
import 'package:getondial/data/model/response/address_model.dart';
import 'package:getondial/data/model/response/store_model.dart';
import 'package:getondial/helper/price_converter.dart';
import 'package:getondial/helper/responsive_helper.dart';
import 'package:getondial/helper/route_helper.dart';
import 'package:getondial/util/dimensions.dart';
import 'package:getondial/util/styles.dart';
import 'package:getondial/view/base/custom_image.dart';
import 'package:getondial/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StoreDescriptionView extends StatefulWidget {
  final Store? store;
  const StoreDescriptionView({super.key, required this.store});

  @override
  State<StoreDescriptionView> createState() => _StoreDescriptionViewState();
}

class _StoreDescriptionViewState extends State<StoreDescriptionView> {
  String? videoId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Get.find<StoreController>().getVideoUrl(1);
      print("Url:: ${Get.find<StoreController>().videoDetails?.first.url}");
      setState(() {
        videoId = YoutubePlayer.convertUrlToId(
            Get.find<StoreController>().videoDetails?.first.url ?? "");
      });
      print("videoId:: $videoId");
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAvailable = Get.find<StoreController>()
        .isStoreOpenNow(widget.store!.active!, widget.store!.schedules);
    Color? textColor =
        ResponsiveHelper.isDesktop(context) ? Colors.white : null;
    // Module? moduleData;
    // for(ZoneData zData in Get.find<LocationController>().getUserAddress()!.zoneData!) {
    //   for(Modules m in zData.modules!) {
    //     if(m.id == Get.find<SplashController>().module!.id) {
    //       moduleData = m as Module?;
    //       break;
    //     }
    //   }
    // }
    return Column(children: [
      ResponsiveHelper.isDesktop(context)
          ? Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: Stack(children: [
                  CustomImage(
                    image:
                        '${Get.find<SplashController>().configModel!.baseUrls!.storeImageUrl}/${widget.store!.logo}',
                    height: ResponsiveHelper.isDesktop(context) ? 80 : 60,
                    width: ResponsiveHelper.isDesktop(context) ? 100 : 70,
                    fit: BoxFit.cover,
                  ),
                  isAvailable
                      ? const SizedBox()
                      : Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  bottom:
                                      Radius.circular(Dimensions.radiusSmall)),
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: Text(
                              'closed_now'.tr,
                              textAlign: TextAlign.center,
                              style: robotoRegular.copyWith(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeSmall),
                            ),
                          ),
                        ),
                ]),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Expanded(
                          child: Text(
                        widget.store!.name!,
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      ResponsiveHelper.isDesktop(context)
                          ? InkWell(
                              onTap: () => Get.toNamed(
                                  RouteHelper.getSearchStoreItemRoute(
                                      widget.store!.id)),
                              child: ResponsiveHelper.isDesktop(context)
                                  ? Container(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusDefault),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: const Center(
                                          child: Icon(Icons.search,
                                              color: Colors.white)),
                                    )
                                  : Icon(Icons.search,
                                      color: Theme.of(context).primaryColor),
                            )
                          : const SizedBox(),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      GetBuilder<WishListController>(builder: (wishController) {
                        bool isWished = wishController.wishStoreIdList
                            .contains(widget.store!.id);
                        return InkWell(
                          onTap: () {
                            if (Get.find<AuthController>().isLoggedIn()) {
                              isWished
                                  ? wishController.removeFromWishList(
                                      widget.store!.id, true)
                                  : wishController.addToWishList(
                                      null, widget.store, true);
                            } else {
                              showCustomSnackBar('you_are_not_logged_in'.tr);
                            }
                          },
                          child: ResponsiveHelper.isDesktop(context)
                              ? Container(
                                  padding: const EdgeInsets.all(
                                      Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDefault),
                                      color: Theme.of(context).primaryColor),
                                  child: Center(
                                      child: Icon(
                                          isWished
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.white)),
                                )
                              : Icon(
                                  isWished
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isWished
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
                                ),
                        );
                      }),
                    ]),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(
                      widget.store!.address ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor),
                    ),
                    SizedBox(
                        height: ResponsiveHelper.isDesktop(context)
                            ? Dimensions.paddingSizeExtraSmall
                            : 0),
                    Row(children: [
                      Text('minimum_order'.tr,
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: Theme.of(context).disabledColor,
                          )),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Text(
                        PriceConverter.convertPrice(widget.store!.minimumOrder),
                        textDirection: TextDirection.ltr,
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: Theme.of(context).primaryColor),
                      ),
                    ]),
                  ])),
            ])
          : const SizedBox(),
      SizedBox(
          height: ResponsiveHelper.isDesktop(context)
              ? 30
              : Dimensions.paddingSizeSmall),
      Row(children: [
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: () =>
              Get.toNamed(RouteHelper.getStoreReviewRoute(widget.store!.id)),
          child: Column(children: [
            Row(children: [
              Icon(Icons.star, color: Theme.of(context).primaryColor, size: 20),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              Text(
                widget.store!.avgRating!.toStringAsFixed(1),
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: textColor),
              ),
            ]),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text(
              '${widget.store!.ratingCount} ${'ratings'.tr}',
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall, color: textColor),
            ),
          ]),
        ),
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: () => Get.toNamed(RouteHelper.getMapRoute(
              AddressModel(
                id: widget.store!.id,
                address: widget.store!.address,
                latitude: widget.store!.latitude,
                longitude: widget.store!.longitude,
                contactPersonNumber: '',
                contactPersonName: '',
                addressType: '',
              ),
              'store',
              Get.find<SplashController>()
                  .getModuleConfig(
                      Get.find<SplashController>().module!.moduleType!)
                  .newVariation!)),
          child: Column(children: [
            Icon(Icons.location_on,
                color: Theme.of(context).primaryColor, size: 20),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text('location'.tr,
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: textColor)),
          ]),
        ),
        // ===================================
        Get.find<SplashController>().module!.id == 3 ||
                Get.find<SplashController>().module!.id == 4
            ? const Expanded(child: SizedBox())
            : Container(),
        Get.find<SplashController>().module!.id == 3 ||
                Get.find<SplashController>().module!.id == 4
            ? GestureDetector(
                onTap: () async {
                  String url = 'tel://${widget.store!.phone}';
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url,
                        mode: LaunchMode.externalApplication);
                  } else {
                    showCustomSnackBar('Enable to call now');
                  }
                },
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.call,
                        color: Theme.of(context).primaryColor, size: 20),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    // Text(
                    //   store!.deliveryTime!,
                    //   style: robotoMedium.copyWith(
                    //       fontSize: Dimensions.fontSizeSmall, color: textColor),
                    // ),
                  ]),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Text('Contact',
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: textColor)),
                ]),
              )
            : Container(),
        Get.find<SplashController>().module!.id == 3 ||
                Get.find<SplashController>().module!.id == 4
            ? const Expanded(child: SizedBox())
            : Container(),
        Get.find<SplashController>().module!.id == 3 ||
                Get.find<SplashController>().module!.id == 4
            ? GestureDetector(
                onTap: () async {
                  String url = 'https://wa.me/${widget.store!.phone}?text=hi';
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url,
                        mode: LaunchMode.externalApplication);
                  } else {
                    showCustomSnackBar('Enable to launch whatsapp');
                  }
                },
                child: Column(children: [
                  const Row(children: [
                    FaIcon(FontAwesomeIcons.whatsapp,
                        color: Colors.green, size: 20),

                    SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    // Text(
                    //   store!.deliveryTime!,
                    //   style: robotoMedium.copyWith(
                    //       fontSize: Dimensions.fontSizeSmall, color: textColor),
                    // ),
                  ]),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Text('Whatsapp',
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: textColor)),
                ]),
              )
            : Container(),

        Get.find<SplashController>().module!.id == 3 ||
                Get.find<SplashController>().module!.id == 4
            ? const Expanded(child: SizedBox())
            : Container(),
        Get.find<SplashController>().module!.id == 3 ||
                Get.find<SplashController>().module!.id == 4
            ? GestureDetector(
                onTap: () async {
                  String url = 'mailto:${widget.store!.email}';
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url,
                        mode: LaunchMode.externalApplication);
                  } else {
                    showCustomSnackBar('Enable to launch email');
                  }
                },
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.mail,
                        color: Theme.of(context).primaryColor, size: 20),

                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    // Text(
                    //   store!.deliveryTime!,
                    //   style: robotoMedium.copyWith(
                    //       fontSize: Dimensions.fontSizeSmall, color: textColor),
                    // ),
                  ]),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Text('Email',
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: textColor)),
                ]),
              )
            : Container(),

        // =============================
        Get.find<SplashController>().module!.id == 2 ||
                Get.find<SplashController>().module!.id == 3 ||
                Get.find<SplashController>().module!.id == 4
            ? Container()
            : const Expanded(child: SizedBox()),
        Get.find<SplashController>().module!.id == 2 ||
                Get.find<SplashController>().module!.id == 3 ||
                Get.find<SplashController>().module!.id == 4
            ? Container()
            : Column(children: [
                Row(children: [
                  Icon(Icons.timer,
                      color: Theme.of(context).primaryColor, size: 20),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Text(
                    widget.store!.deliveryTime!,
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall, color: textColor),
                  ),
                ]),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Text('delivery_time'.tr,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall, color: textColor)),
              ]),
        Get.find<SplashController>().module!.id == 2 ||
                Get.find<SplashController>().module!.id == 3
            ? Container()
            : (widget.store!.delivery! && widget.store!.freeDelivery!)
                ? const Expanded(child: SizedBox())
                : const SizedBox(),
        Get.find<SplashController>().module!.id == 2 ||
                Get.find<SplashController>().module!.id == 3
            ? Container()
            : (widget.store!.delivery! && widget.store!.freeDelivery!)
                ? Column(children: [
                    Icon(Icons.money_off,
                        color: Theme.of(context).primaryColor, size: 20),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Text('free_delivery'.tr,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: textColor)),
                  ])
                : const SizedBox(),
        const Expanded(child: SizedBox()),
      ]),
      SizedBox(
        height: 10,
      ),
      (videoId == "" || videoId == null)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer(
                duration: const Duration(seconds: 2),
                enabled: videoId == "" || videoId == null,
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId ?? "",
                  flags: YoutubePlayerFlags(
                      autoPlay: true, mute: true, loop: true),
                ),
              ),
            ),
    ]);
  }
}
