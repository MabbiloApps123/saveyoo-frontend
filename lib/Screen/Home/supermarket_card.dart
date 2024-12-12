import 'package:flutter/material.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Utils/MyColor.dart';

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
                    height: 100,
                  ),
                ),
                // Positioned Logo
                Positioned(
                  top: 70, // Adjust this value to control vertical position
                  left: MediaQuery.of(context).size.width *
                      0.13, // Adjust this value to center horizontally
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

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            // Title
            const Text(
              "Store Name",
              style: TextStyle(
                  fontFamily: 'PlusJakartaSansSemiBold',
                  fontSize: 16,
                  color: mTextColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // Subtitle
            Text(
              "Chennai",
              style: TextStyle(
                  fontFamily: 'PlusJakartaSansMedium',
                  fontSize: 14,
                  color: mGrey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Distance
            const Text(
              "4 KM",
              style: TextStyle(
                  fontFamily: 'PlusJakartaSansRegular',
                  fontSize: 14,
                  color: mTextColor),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
