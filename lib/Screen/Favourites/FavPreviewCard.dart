import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saveyoo/Model/GetFavouriteResponse.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:sizer/sizer.dart';

import '../../localization/language/languages.dart';

class FavPreviewCard extends StatelessWidget {
  const FavPreviewCard({
    super.key,
    required this.restaurant,
  });

  final Datum restaurant;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, productdetailsRoute,
              arguments: [restaurant.storeProduct.product.id, "", "", "", ""]);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
          child: Card(
            color: mBackgroundColor,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        restaurant.storeProduct.product.productImage,
                        height: 150,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 8.0,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.all(
                            3), // Add padding inside the container
                        decoration: BoxDecoration(
                          color: mPrimaryColor, // Background color
                          borderRadius:
                              BorderRadius.circular(4), // Rounded corners
                        ),
                        child: Text(
                          '${restaurant.storeProduct.quantity} items available',
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 9.sp,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8.0,
                      child: Chip(
                        side: BorderSide.none,
                        labelPadding: EdgeInsets.zero,
                        backgroundColor:
                            (restaurant.storeProduct.product.isActive)
                                ? mWhiteColor
                                : mPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30.0), // Custom radius
                        ),
                        label: (restaurant.storeProduct.product.isActive)
                            ? SvgPicture.asset(
                                'assets/ic_favorite.svg',
                                width: 24,
                                height: 24,
                              )
                            : SvgPicture.asset(
                                'assets/ic_unfavorite.svg',
                                width: 24,
                                height: 24,
                                //color: isSelected ? selectedColor : color,
                              ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: CircleAvatar(
                          radius: 20,
                          child: ClipOval(
                            child: Image.network(
                              restaurant.storeProduct.product.productImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "restaurant.store.name",
                              style: TextStyle(
                                  fontFamily: 'PlusJakartaSansSemiBold',
                                  fontSize: 13.sp,
                                  color: mGrey),
                            ),
                            Text(
                              restaurant.storeProduct.product.name,
                              style: TextStyle(
                                  fontFamily: 'PlusJakartaSansMedium',
                                  fontSize: 11.sp,
                                  color: mGrey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 4, 0),
                    child: Row(
                      children: [
                        // First column
                        Expanded(
                          flex: 3, // Takes 3 parts of the space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Collect today ${formatDateToTime(restaurant.storeProduct.pickupStartTime)} - ${formatDateToTime(restaurant.storeProduct.pickupEndTime)}",
                                style: TextStyle(
                                    fontFamily: 'PlusJakartaSansRegular',
                                    fontSize: 12,
                                    color: mGreyDisable),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/ic_star.svg',
                                    width: 16,
                                    height: 16,
                                    //color: isSelected ? selectedColor : color,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "4.5",
                                    style: TextStyle(
                                        fontFamily: 'PlusJakartaSansMedium',
                                        fontSize: 11.sp,
                                        color: mGrey),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    width: 2,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    // "${restaurant.distance} KM",
                                    "11",
                                    style: TextStyle(
                                        fontFamily: 'PlusJakartaSansMedium',
                                        fontSize: 11.sp,
                                        color: mGrey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Second column
                        Expanded(
                          flex: 1, // Takes 1 part of the space
                          child: Column(
                            children: [
                              Text(
                                Languages.of(context)!.rupess +
                                    restaurant.storeProduct.originalPrice
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'PlusJakartaSansRegular',
                                  color: mGreyDisable,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                Languages.of(context)!.rupess +
                                    restaurant.storeProduct.discountedPrice
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'PlusJakartaSansSemiBold',
                                  color: mPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        )

        // Container(
        //   width: size.width,
        //   margin: const EdgeInsets.only(right: 16),
        //   padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: mBorder, width: 1),
        //     borderRadius: BorderRadius.circular(8.0),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Stack(
        //         children: [
        //           ClipRRect(
        //             borderRadius: BorderRadius.circular(8),
        //             child:
        //                 // Image.asset(
        //                 //   'assets/dummy.jpeg',
        //                 //   fit: BoxFit.cover,
        //                 //   width: size.width,
        //                 //   height: 110,
        //                 // )
        //
        //                 Image.network(
        //               restaurant.productImage,
        //               height: 150,
        //               width: size.width,
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //           Positioned(
        //             left: 8.0,
        //             top: 10,
        //             child: Container(
        //               padding: const EdgeInsets.all(
        //                   3), // Add padding inside the container
        //               decoration: BoxDecoration(
        //                 color: mPrimaryColor, // Background color
        //                 borderRadius: BorderRadius.circular(4), // Rounded corners
        //               ),
        //               child: Text(
        //                 '${restaurant.quantity} items available',
        //                 style: TextStyle(
        //                     fontFamily: 'PlusJakartaSansSemiBold',
        //                     fontSize: 9.sp,
        //                     color: Colors.white),
        //               ),
        //             ),
        //           ),
        //           Positioned(
        //             right: 8.0,
        //             child: Chip(
        //               side: BorderSide.none,
        //               labelPadding: EdgeInsets.zero,
        //               backgroundColor:
        //                   (restaurant.isFavourite) ? mWhiteColor : mPrimaryColor,
        //               shape: RoundedRectangleBorder(
        //                 borderRadius:
        //                     BorderRadius.circular(30.0), // Custom radius
        //               ),
        //               label:
        //                   // SvgPicture.asset(
        //                   //   'assets/ic_unfavorite.svg',
        //                   //   width: 20,
        //                   //   height: 20,
        //                   //   //color: isSelected ? selectedColor : color,
        //                   // )
        //                   (restaurant.isFavourite)
        //                       ? SvgPicture.asset(
        //                           'assets/ic_favorite.svg',
        //                           width: 24,
        //                           height: 24,
        //                         )
        //                       : SvgPicture.asset(
        //                           'assets/ic_unfavorite.svg',
        //                           width: 24,
        //                           height: 24,
        //                           //color: isSelected ? selectedColor : color,
        //                         ),
        //             ),
        //           ),
        //           // Positioned(
        //           //   bottom: 10,
        //           //   left: 10,
        //           //   child: Row(
        //           //     children: [
        //           //       CircleAvatar(
        //           //         radius: 30,
        //           //         child: CircleAvatar(
        //           //           radius: 30,
        //           //           child: ClipOval(
        //           //             child: Image.network(
        //           //               "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        //           //               fit: BoxFit.cover,
        //           //             ),
        //           //           ),
        //           //         ),
        //           //       ),
        //           //       const SizedBox(width: 10),
        //           //       const Column(
        //           //         mainAxisAlignment: MainAxisAlignment.center,
        //           //         crossAxisAlignment: CrossAxisAlignment.start,
        //           //         children: [
        //           //           Text("Carrefour Market",
        //           //               maxLines: 1,
        //           //               overflow: TextOverflow.ellipsis,
        //           //               style: TextStyle(
        //           //                   fontFamily: 'PlusJakartaSansMedium',
        //           //                   fontSize: 16,
        //           //                   color: Colors.black)),
        //           //           Text("Tervuren",
        //           //               maxLines: 1,
        //           //               overflow: TextOverflow.ellipsis,
        //           //               style: TextStyle(
        //           //                   fontFamily: 'PlusJakartaSansMedium',
        //           //                   fontSize: 16,
        //           //                   color: Colors.black))
        //           //         ],
        //           //       )
        //           //     ],
        //           //   ),
        //           // ),
        //         ],
        //       ),
        //       Padding(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             CircleAvatar(
        //               radius: 20,
        //               child: CircleAvatar(
        //                 radius: 20,
        //                 child: ClipOval(
        //                   child: Image.network(
        //                     restaurant.store.imageUrl,
        //                     fit: BoxFit.cover,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(
        //               width: 5,
        //             ),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     restaurant.store.name,
        //                     style: TextStyle(
        //                         fontFamily: 'PlusJakartaSansSemiBold',
        //                         fontSize: 13.sp,
        //                         color: mGrey),
        //                   ),
        //                   Text(
        //                     restaurant.product,
        //                     style: TextStyle(
        //                         fontFamily: 'PlusJakartaSansMedium',
        //                         fontSize: 11.sp,
        //                         color: mGrey),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 5,
        //       ),
        //       Padding(
        //           padding: EdgeInsets.fromLTRB(8, 0, 4, 0),
        //           child: Row(
        //             children: [
        //               // First column
        //               Expanded(
        //                 flex: 3, // Takes 3 parts of the space
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       "Collect today ${formatDateToTime(restaurant.pickupStartTime)} - ${formatDateToTime(restaurant.pickupEndTime)}",
        //                       style: TextStyle(
        //                           fontFamily: 'PlusJakartaSansRegular',
        //                           fontSize: 12,
        //                           color: mGreyDisable),
        //                     ),
        //                     const SizedBox(
        //                       height: 5,
        //                     ),
        //                     Row(
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       children: [
        //                         SvgPicture.asset(
        //                           'assets/ic_star.svg',
        //                           width: 16,
        //                           height: 16,
        //                           //color: isSelected ? selectedColor : color,
        //                         ),
        //                         const SizedBox(
        //                           width: 8,
        //                         ),
        //                         Text(
        //                           restaurant.ratings.toString(),
        //                           style: TextStyle(
        //                               fontFamily: 'PlusJakartaSansMedium',
        //                               fontSize: 11.sp,
        //                               color: mGrey),
        //                         ),
        //                         const SizedBox(
        //                           width: 8,
        //                         ),
        //                         Container(
        //                           color: Colors.grey,
        //                           width: 2,
        //                           height: 15,
        //                         ),
        //                         const SizedBox(
        //                           width: 8,
        //                         ),
        //                         Text(
        //                           "${restaurant.distance} KM",
        //                           style: TextStyle(
        //                               fontFamily: 'PlusJakartaSansMedium',
        //                               fontSize: 11.sp,
        //                               color: mGrey),
        //                         ),
        //                       ],
        //                     )
        //                   ],
        //                 ),
        //               ),
        //               // Second column
        //               Expanded(
        //                 flex: 1, // Takes 1 part of the space
        //                 child: Column(
        //                   children: [
        //                     Text(
        //                       Languages.of(context)!.rupess +
        //                           restaurant.originalPrice.toString(),
        //                       style: TextStyle(
        //                         fontSize: 10.sp,
        //                         fontFamily: 'PlusJakartaSansRegular',
        //                         color: mGreyDisable,
        //                         decoration: TextDecoration.lineThrough,
        //                       ),
        //                     ),
        //                     const SizedBox(width: 4),
        //                     Text(
        //                       Languages.of(context)!.rupess +
        //                           restaurant.discountedPrice.toString(),
        //                       style: TextStyle(
        //                         fontSize: 12.sp,
        //                         fontFamily: 'PlusJakartaSansSemiBold',
        //                         color: mPrimaryColor,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ))
        //     ],
        //   ),
        // ),
        );
  }
}
