import 'package:flutter/material.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Screen/Home/supermarket_card.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Widgets/section_title.dart';

class Supermarket extends StatelessWidget {
  var mProduct = <Product>[];
  var title = "";
  var seeall = "";
  Supermarket({
    required this.mProduct,
    required this.title,
    required this.seeall,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorScheme = Theme.of(context).colorScheme;
    const height = 225.0;

    return Column(
      children: [
        SectionTitle(
          title: title,
          action: seeall,
          onPressed: () {
            Navigator.pushReplacementNamed(context, supermarketseeallRoute);
            //Navigator.pushReplacementNamed(context, productdetailsRoute);
          },
        ),
        Container(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mProduct.length,
            itemBuilder: (context, index) {
              final restaurant = mProduct[index];
              return SizedBox(
                width: size.width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: SupermarketCard(restaurant: restaurant),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}