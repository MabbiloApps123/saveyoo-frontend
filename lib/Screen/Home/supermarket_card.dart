import 'package:flutter/material.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:sizer/sizer.dart';

class SupermarketCard extends StatelessWidget {
  const SupermarketCard({
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
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: mBorder, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none, // Allows the CircleAvatar to overflow
              children: [
                // Background Image
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    'assets/dummyy.jpg',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 70,
                  ),
                ),
                // Positioned Logo
                Positioned(
                  top: 30, // Adjust this value to control vertical position
                  left: MediaQuery.of(context).size.width *
                      0.12, // Adjust this value to center horizontally
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
                    ),
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            // Title
            Text(
              "Store Name",
              style: TextStyle(
                  fontFamily: 'PlusJakartaSansSemiBold',
                  fontSize: 13.sp,
                  color: mTextColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // Subtitle
            Text(
              "Chennai",
              style: TextStyle(
                  fontFamily: 'PlusJakartaSansRegular',
                  fontSize: 11.sp,
                  color: mGrey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // Distance
            Text(
              "4 KM",
              style: TextStyle(
                  fontFamily: 'PlusJakartaSansRegular',
                  fontSize: 10.sp,
                  color: mTextColor),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
