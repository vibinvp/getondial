import 'package:getondial/view/screens/jobs/jobs_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:getondial/controller/auth_controller.dart';
import 'package:getondial/controller/location_controller.dart';
import 'package:getondial/controller/splash_controller.dart';
import 'package:getondial/data/model/response/address_model.dart';
import 'package:getondial/helper/responsive_helper.dart';
import 'package:getondial/util/app_constants.dart';
import 'package:getondial/util/dimensions.dart';
import 'package:getondial/util/images.dart';
import 'package:getondial/util/styles.dart';
import 'package:getondial/view/base/custom_image.dart';
import 'package:getondial/view/base/custom_loader.dart';
import 'package:getondial/view/base/title_widget.dart';
import 'package:getondial/view/screens/address/widget/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getondial/view/screens/home/widget/popular_store_view.dart';
import 'package:html/parser.dart';

class ModuleView extends StatelessWidget {
  final SplashController splashController;
  const ModuleView({Key? key, required this.splashController})
      : super(key: key);

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // GetBuilder<BannerController>(builder: (bannerController) {
      //   return const BannerView(isFeatured: true);
      // }),
      const SizedBox(height: 12),
      Container(
        width: MediaQuery.of(context).size.width,
        // height: 80,
        child: Center(
          child: Column(
            children: [
              Image.asset(Images.logo, width: 100),
              Text(
                'Welcome ${AppConstants.appName}',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: robotoMedium.copyWith(
                    fontSize: 25, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),

      splashController.moduleList != null
          ? splashController.moduleList!.isNotEmpty
              ? 
              
             GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1,
    mainAxisSpacing: Dimensions.paddingSizeSmall,
    crossAxisSpacing: Dimensions.paddingSizeSmall,
    mainAxisExtent: 110,
  ),
  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
  itemCount: splashController.moduleList!.length + 1, // Increase the item count by 1
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemBuilder: (context, index) {
    if (index == 1) {
      // Add content for the job category at the second position (index 1)
      return InkWell(
        onTap: () {
       Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return JobScreen();
       }));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        "JOBS",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                 height: 80,
                    width:80,
                  child: Image.asset("assets/image/job.png")),
              )
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              //   child: CustomImage(
              //     image: "assets/image/job.png",
              //     height: 100,
              //     width: 100,
              //   ),
              // ),
            ],
          ),
        ),
        
        //  Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
        //     color: Theme.of(context).canvasColor,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Theme.of(context).primaryColor.withOpacity(0.1),
        //         spreadRadius: 1,
        //         blurRadius: 3,
        //       )
        //     ],
        //   ),
        //   child: Center(
        //     child: Text(
        //       'Job Category',
        //       style: robotoMedium.copyWith(
        //         fontSize: Dimensions.fontSizeLarge,
        //         fontWeight: FontWeight.w900,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),

      );
    } else {
      // Adjust the index for the original module list items
      int adjustedIndex = index > 1 ? index - 1 : index;
      return InkWell(
        onTap: () => splashController.switchModule(adjustedIndex, true),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        splashController.moduleList![adjustedIndex].moduleName!.toUpperCase(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: CustomImage(
                  image: '${splashController.configModel!.baseUrls!.moduleImageUrl}/${splashController.moduleList![adjustedIndex].icon}',
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
        ),
      );
    }
  },
)


                
              // GridView.builder(
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       mainAxisSpacing: Dimensions.paddingSizeSmall,
              //       crossAxisSpacing: Dimensions.paddingSizeSmall,
              //       // childAspectRatio: (1 / 1),
              //       mainAxisExtent: 145,
              //     ),
              //     padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              //     itemCount: splashController.moduleList!.length,
              //     // itemCount: 1,
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return InkWell(
              //         onTap: () => splashController.switchModule(index, true),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius:
              //                 BorderRadius.circular(Dimensions.radiusDefault),
              //             color: Theme.of(context).cardColor,
              //             border: Border.all(
              //                 color: Theme.of(context).primaryColor,
              //                 width: 0.15),
              //             boxShadow: [
              //               BoxShadow(
              //                   color: Theme.of(context)
              //                       .primaryColor
              //                       .withOpacity(0.1),
              //                   spreadRadius: 1,
              //                   blurRadius: 3)
              //             ],
              //           ),
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.stretch,
              //               // mainAxisSize: MainAxisSize.max,
              //               children: [
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(
              //                       Dimensions.radiusSmall),
              //                   child: CustomImage(
              //                     image:
              //                         '${splashController.configModel!.baseUrls!.moduleImageUrl}/${splashController.moduleList![index].icon}',
              //                     height: 144.5,
              //                     // width: 10,
              //                     fit: BoxFit.fill,
              //                   ),
              //                 ),
              //                 // const SizedBox(height: Dimensions.paddingSizeSmall),

              //                 // Center(child: Text(
              //                 //   splashController.moduleList![index].moduleName!,
              //                 //   textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
              //                 //   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
              //                 // )),
              //               ]),
              //         ),
              //       );
              //     },
              //   )

              : Center(
                  child: Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Text('no_module_found'.tr),
                ))
          : ModuleShimmer(isEnabled: splashController.moduleList == null),
      GetBuilder<LocationController>(builder: (locationController) {
        List<AddressModel?> addressList = [];
        if (Get.find<AuthController>().isLoggedIn() &&
            locationController.addressList != null) {
          addressList = [];
          bool contain = false;
          if (locationController.getUserAddress()!.id != null) {
            for (int index = 0;
                index < locationController.addressList!.length;
                index++) {
              if (locationController.addressList![index].id ==
                  locationController.getUserAddress()!.id) {
                contain = true;
                break;
              }
            }
          }
          if (contain) {
            addressList.add(Get.find<LocationController>().getUserAddress());
          }
          addressList.addAll(locationController.addressList!);
        }
        return (!Get.find<AuthController>().isLoggedIn() ||
                locationController.addressList != null)
            ? addressList.isNotEmpty
                ? Column(
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall),
                        child: TitleWidget(title: 'deliver_to'.tr),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      SizedBox(
                        height: 75,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: addressList.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 300,
                              padding: const EdgeInsets.only(
                                  right: Dimensions.paddingSizeSmall),
                              child: AddressWidget(
                                address: addressList[index],
                                fromAddress: false,
                                onTap: () {
                                  if (locationController.getUserAddress()!.id !=
                                      addressList[index]!.id) {
                                    Get.dialog(const CustomLoader(),
                                        barrierDismissible: false);
                                    locationController.saveAddressAndNavigate(
                                      addressList[index],
                                      false,
                                      null,
                                      false,
                                      ResponsiveHelper.isDesktop(context),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox()
            : AddressShimmer(
                isEnabled: Get.find<AuthController>().isLoggedIn() &&
                    locationController.addressList == null);
      }),
      const PopularStoreView(isPopular: false, isFeatured: true),
      // Static banner
      const SizedBox(height: 10),
      Container(
        height: 200,
        child: Image.asset(
          'assets/image/static_banner.png',
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
      const SizedBox(height: 30),
    ]);
  }
}

class ModuleShimmer extends StatelessWidget {
  final bool isEnabled;
  const ModuleShimmer({Key? key, required this.isEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: Dimensions.paddingSizeSmall,
          crossAxisSpacing: Dimensions.paddingSizeSmall,
          mainAxisExtent: 110
          // childAspectRatio: (1 / 1),
          ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemCount: 3,
      // itemCount: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer(
          duration: const Duration(seconds: 2),
          enabled: isEnabled,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSmall),
                          color: Colors.grey[300]),
                      child: Container(
                        height: 50,
                        width: 400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: Container(
                    height: 80, width: 100, color: Colors.grey[300])),
          ]),
        );
      },
    );
  }
}

class AddressShimmer extends StatelessWidget {
  final bool isEnabled;
  const AddressShimmer({Key? key, required this.isEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: Container(
              padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)
                  ? Dimensions.paddingSizeDefault
                  : Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                      blurRadius: 5,
                      spreadRadius: 1)
                ],
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(
                  Icons.location_on,
                  size: ResponsiveHelper.isDesktop(context) ? 50 : 40,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    enabled: isEnabled,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 15, width: 100, color: Colors.grey[300]),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Container(
                              height: 10, width: 150, color: Colors.grey[300]),
                        ]),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
