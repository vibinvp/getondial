import 'package:getondial/controller/item_controller.dart';
import 'package:getondial/controller/splash_controller.dart';
import 'package:getondial/util/dimensions.dart';
import 'package:getondial/view/base/custom_app_bar.dart';
import 'package:getondial/view/base/footer_view.dart';
import 'package:getondial/view/base/item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getondial/view/base/menu_drawer.dart';

class PopularItemScreen extends StatefulWidget {
  final bool isPopular;
  const PopularItemScreen({Key? key, required this.isPopular})
      : super(key: key);

  @override
  State<PopularItemScreen> createState() => _PopularItemScreenState();
}

class _PopularItemScreenState extends State<PopularItemScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    if (widget.isPopular) {
      Get.find<ItemController>().getPopularItemList(
          true, Get.find<ItemController>().popularType, false);
    } else {
      Get.find<ItemController>().getReviewedItemList(
          true, Get.find<ItemController>().reviewType, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemController>(builder: (itemController) {
      return Scaffold(
        appBar: CustomAppBar(
          key: scaffoldKey,
          title: Get.find<SplashController>().module!.id == 3
              ? widget.isPopular
                  ? 'Popular Service Nearby'
                  : 'Best Reviewed Service'
              : Get.find<SplashController>().module!.id == 2
                  ? widget.isPopular
                      ? 'Popular Doctor Nearby'
                      : 'Best Reviewed Doctor'
                  : widget.isPopular
                      ? 'popular_items_nearby'.tr
                      : 'best_reviewed_item'.tr,
          showCart: true,
          type: widget.isPopular
              ? itemController.popularType
              : itemController.reviewType,
          onVegFilterTap: (String type) {
            if (widget.isPopular) {
              itemController.getPopularItemList(true, type, true);
            } else {
              itemController.getReviewedItemList(true, type, true);
            }
          },
        ),
        endDrawer: const MenuDrawer(),
        endDrawerEnableOpenDragGesture: false,
        body: Scrollbar(
            child: SingleChildScrollView(
                child: FooterView(
                    child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: ItemsView(
            isStore: false,
            stores: null,
            items: widget.isPopular
                ? itemController.popularItemList
                : itemController.reviewedItemList,
          ),
        )))),
      );
    });
  }
}
