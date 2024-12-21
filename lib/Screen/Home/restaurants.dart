import 'package:flutter/material.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Screen/Home/restaurant_preview_card.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Widgets/section_title.dart';

class Restaurants extends StatelessWidget {
  var mProduct = <Product>[];
  var title = "";
  var seeall = "";
  Restaurants({
    required this.mProduct,
    required this.title,
    required this.seeall,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorScheme = Theme.of(context).colorScheme;
    const height = 235.0;
    // var height = 185.sp;

    return Column(
      children: [
        SectionTitle(
          title: title,
          action: seeall,
          onPressed: () {
            Navigator.pushReplacementNamed(context, seeallRoute);
          },
        ),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mProduct.length,
            itemBuilder: (context, index) {
              final restaurant = mProduct[index];
              return SizedBox(
                width: size.width * 0.75,
                child: RestaurantPreviewCard(restaurant: restaurant),
              );
            },
          ),
        )
      ],
    );
  }
}
