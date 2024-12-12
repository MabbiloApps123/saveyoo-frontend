import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/screens.dart';

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
        margin: const EdgeInsets.only(bottom: 5, right: 8.0),
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
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/dummy.jpeg',
                      fit: BoxFit.cover,
                      width: size.width,
                      height: 150,
                    )

                    // Image.network(
                    //   restaurant.imageUrl!,
                    //   height: 150,
                    //   width: size.width,
                    //   fit: BoxFit.cover,
                    // ),
                    ),
                const Positioned(
                  left: 8.0,
                  child: Chip(
                    backgroundColor: mPrimaryColor,
                    side: BorderSide.none,
                    labelPadding: EdgeInsets.zero,
                    label: Text(
                      '2 offers available',
                      style: TextStyle(
                          fontFamily: 'PlusJakartaSansRegular',
                          fontSize: 12,
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
                      width: 24,
                      height: 24,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 16,
                              color: mGrey),
                        ),
                        Text(
                          "Collect today 4.30 PM - 5.30 PM",
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSansMedium',
                              fontSize: 14,
                              color: mGreyDisable),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
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
                            const Text(
                              "4.5",
                              style: TextStyle(
                                  fontFamily: 'PlusJakartaSansSemiBold',
                                  fontSize: 14,
                                  color: mGrey),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              color: mBorder,
                              width: 2,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "100 KM",
                              style: TextStyle(
                                  fontFamily: 'PlusJakartaSansSemiBold',
                                  fontSize: 14,
                                  color: mGrey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Text("₹1000",
                      style: TextStyle(
                          fontFamily: 'PlusJakartaSansBold',
                          fontSize: 18,
                          color: mPrimaryColor))
                ],
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
