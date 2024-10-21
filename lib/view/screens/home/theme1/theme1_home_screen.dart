import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getondial/controller/location_controller.dart';
import 'package:getondial/controller/notification_controller.dart';
import 'package:getondial/controller/splash_controller.dart';
import 'package:getondial/controller/store_controller.dart';
import 'package:getondial/helper/responsive_helper.dart';
import 'package:getondial/helper/route_helper.dart';
import 'package:getondial/util/dimensions.dart';
import 'package:getondial/util/styles.dart';
import 'package:getondial/view/base/item_view.dart';
import 'package:getondial/view/base/paginated_list_view.dart';
import 'package:getondial/view/screens/home/home_screen.dart';
import 'package:getondial/view/screens/home/theme1/banner_view1.dart';
import 'package:getondial/view/screens/home/theme1/best_reviewed_item_view.dart';
import 'package:getondial/view/screens/home/theme1/category_view1.dart';
import 'package:getondial/view/screens/home/theme1/item_campaign_view1.dart';
import 'package:getondial/view/screens/home/theme1/popular_item_view1.dart';
import 'package:getondial/view/screens/home/theme1/popular_store_view1.dart';
import 'package:getondial/view/screens/home/widget/filter_view.dart';
import 'package:getondial/view/screens/home/widget/module_view.dart';

class Theme1HomeScreen extends StatelessWidget {
  final ScrollController scrollController;
  final SplashController splashController;
  final bool showMobileModule;
  const Theme1HomeScreen(
      {Key? key,
      required this.scrollController,
      required this.splashController,
      required this.showMobileModule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        // App Bar
        SliverAppBar(
          titleSpacing: 0,
          floating: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: ResponsiveHelper.isDesktop(context)
              ? Colors.transparent
              : Theme.of(context).colorScheme.background,
          title: Center(
              child: Container(
            width: Dimensions.webMaxWidth,
            height: 60,
            color: Theme.of(context).primaryColor,
            child: Row(children: [
              (splashController.module != null &&
                      splashController.configModel!.module == null)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () => splashController.removeModule(),
                        child: Icon(Icons.arrow_back_ios_new_outlined,
                            color: Colors.white
                            // Theme.of(context).textTheme.bodyLarge!.color
                            ),
                        // Image.asset(Images.moduleIcon,
                        //     height: 22, width: 22),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                  width: (splashController.module != null &&
                          splashController.configModel!.module == null)
                      ? Dimensions.paddingSizeExtraSmall
                      : 0),
              Expanded(
                  child: InkWell(
                onTap: () => Get.find<LocationController>()
                    .navigateToLocationScreen('home'),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeSmall,
                    horizontal: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.paddingSizeSmall
                        : 0,
                  ),
                  child: GetBuilder<LocationController>(
                      builder: (locationController) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                            locationController.getUserAddress()!.addressType ==
                                    'home'
                                ? Icons.home_filled
                                : locationController
                                            .getUserAddress()!
                                            .addressType ==
                                        'office'
                                    ? Icons.work
                                    : Icons.location_on,
                            size: 20,
                            color: Colors.white
                            //  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            locationController.getUserAddress()!.address!,
                            style: robotoRegular.copyWith(
                              color: Colors.white,
                              // Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white
                            // Theme.of(context).textTheme.bodyLarge!.color
                            ),
                      ],
                    );
                  }),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  child: GetBuilder<NotificationController>(
                      builder: (notificationController) {
                    return Stack(children: [
                      Icon(Icons.notifications, size: 25, color: Colors.white
                          // Theme.of(context).textTheme.bodyLarge!.color
                          ),
                      notificationController.hasNotification
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ))
                          : const SizedBox(),
                    ]);
                  }),
                  onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
                ),
              ),
            ]),
          )),
          actions: const [SizedBox()],
        ),

        // Search Button
        !showMobileModule
            ? SliverPersistentHeader(
                pinned: true,
                delegate: SliverDelegate(
                    child: Container(
                  height: 50,
                  width: Dimensions.webMaxWidth,
                  color: Theme.of(context).colorScheme.background,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall),
                  child: InkWell(
                    onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                      ),
                      child: Row(children: [
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Icon(
                          Icons.search,
                          size: 25,
                          color: Theme.of(context).hintColor,
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Expanded(
                            child: Text(
                          Get.find<SplashController>().module!.id == 2
                              ? "Search your desired clinic or doctor"
                              : Get.find<SplashController>().module!.id == 3
                                  ? "Search your desired store or service"
                                  : Get.find<SplashController>()
                                          .configModel!
                                          .moduleConfig!
                                          .module!
                                          .showRestaurantText!
                                      ? 'search_food_or_restaurant'.tr
                                      : 'search_item_or_store'.tr,
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).hintColor,
                          ),
                        )),
                      ]),
                    ),
                  ),
                )),
              )
            : const SliverToBoxAdapter(),

        SliverToBoxAdapter(
          child: Center(
              child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: !showMobileModule
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const BannerView1(isFeatured: false),
                        const CategoryView1(),
                        const ItemCampaignView1(),
                        const BestReviewedItemView(),
                        const PopularStoreView1(
                            isPopular: true, isFeatured: false),
                        const PopularItemView1(isPopular: true),
                        const PopularStoreView1(
                            isPopular: false, isFeatured: false),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                          child: Row(children: [
                            Expanded(
                                child: Text(
                              Get.find<SplashController>().module!.id == 2
                                  ? "All Clinic"
                                  : Get.find<SplashController>()
                                          .configModel!
                                          .moduleConfig!
                                          .module!
                                          .showRestaurantText!
                                      ? 'all_restaurants'.tr
                                      : 'all_stores'.tr,
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge),
                            )),
                            Get.find<SplashController>().module!.id == 2 ||
                                    Get.find<SplashController>().module!.id == 3
                                ? Container()
                                : const FilterView(),
                          ]),
                        ),
                        GetBuilder<StoreController>(builder: (storeController) {
                          return PaginatedListView(
                            scrollController: scrollController,
                            totalSize: storeController.storeModel != null
                                ? storeController.storeModel!.totalSize
                                : null,
                            offset: storeController.storeModel != null
                                ? storeController.storeModel!.offset
                                : null,
                            onPaginate: (int? offset) async =>
                                await storeController.getStoreList(
                                    offset!, false),
                            itemView: ItemsView(
                              isStore: true,
                              items: null,
                              showTheme1Store: true,
                              stores: storeController.storeModel != null
                                  ? storeController.storeModel!.stores
                                  : null,
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.paddingSizeExtraSmall
                                    : Dimensions.paddingSizeSmall,
                                vertical: ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.paddingSizeExtraSmall
                                    : 0,
                              ),
                            ),
                          );
                        }),
                      ])
                : ModuleView(splashController: splashController),
          )),
        ),
      ],
    );
  }
}
