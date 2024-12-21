import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:sizer/sizer.dart';

class RestaurantPreviewCard extends StatelessWidget {
  const RestaurantPreviewCard({
    super.key,
    required this.restaurant,
  });

  final Product restaurant;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, productdetailsRoute);
      },
      child: Container(
        width: size.width,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border.all(color: mBorder, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/dummy.jpeg',
                      fit: BoxFit.cover,
                      width: size.width,
                      height: 110,
                    )

                    // Image.network(
                    //   restaurant.imageUrl!,
                    //   height: 150,
                    //   width: size.width,
                    //   fit: BoxFit.cover,
                    // ),
                    ),
                Positioned(
                  left: 8.0,
                  child: Chip(
                    backgroundColor: mPrimaryColor,
                    side: BorderSide.none,
                    labelPadding: EdgeInsets.zero,
                    label: Text(
                      '2 offers available',
                      style: TextStyle(
                          fontFamily: 'PlusJakartaSansSemiBold',
                          fontSize: 10.sp,
                          color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  right: 8.0,
                  child: Chip(
                    side: BorderSide.none,
                    labelPadding: EdgeInsets.zero,
                    backgroundColor: mPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Custom radius
                    ),
                    label: SvgPicture.asset(
                      'assets/ic_unfavorite.svg',
                      width: 20,
                      height: 20,
                      //color: isSelected ? selectedColor : color,
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 10,
                //   left: 10,
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         radius: 30,
                //         child: CircleAvatar(
                //           radius: 30,
                //           child: ClipOval(
                //             child: Image.network(
                //               "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(width: 10),
                //       const Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text("Carrefour Market",
                //               maxLines: 1,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(
                //                   fontFamily: 'PlusJakartaSansMedium',
                //                   fontSize: 16,
                //                   color: Colors.black)),
                //           Text("Tervuren",
                //               maxLines: 1,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(
                //                   fontFamily: 'PlusJakartaSansMedium',
                //                   fontSize: 16,
                //                   color: Colors.black))
                //         ],
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: CircleAvatar(
                      radius: 20,
                      child: ClipOval(
                        child: Image.network(
                          "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
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
                          restaurant.name,
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 13.sp,
                              color: mGrey),
                        ),
                        Text(
                          restaurant.name,
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
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Collect today 4.30 PM - 5.30 PM",
                style: TextStyle(
                    fontFamily: 'PlusJakartaSansRegular',
                    fontSize: 10.sp,
                    color: mGreyDisable),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              "100 KM",
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
                  Column(
                    children: [
                      Text(
                        '€15.00',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: 'PlusJakartaSansRegular',
                          color: mGreyDisable,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '€4.99',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'PlusJakartaSansSemiBold',
                          color: mPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
