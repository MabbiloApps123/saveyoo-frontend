import 'package:flutter/material.dart';
import 'package:saveyoo/Model/HomePageResponse.dart';
import 'package:saveyoo/Screen/Home/restaurant_preview_card.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Widgets/section_title.dart';
import 'package:saveyoo/localization/language/languages.dart';

class Restaurants extends StatelessWidget {
  final List<AvailableNow> mProduct;
  final String title;
  final String seeall;
  final String latitude;
  final String longitude;
  final String range;

  const Restaurants({
    required this.mProduct,
    required this.title,
    required this.seeall,
    required this.latitude,
    required this.longitude,
    required this.range,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.34;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: title,
            action: seeall,
            onPressed: () => {
              Navigator.pushReplacementNamed(context, seeallRoute, arguments: [
                latitude,
                longitude,
                range,
                _getSectionType(context),
              ])
            },
          ),

          // Fixed height container with safe boundaries
          SizedBox(
            height: _calculateDynamicHeight(context),
            //height: height,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mProduct.length,
              itemBuilder: (context, index) {
                final restaurant = mProduct[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: size.width * 0.85,
                    child: RestaurantPreviewCard(restaurant: restaurant),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  double _calculateDynamicHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Adjust these ratios based on your needs
    if (screenHeight < 600) return 200; // Small devices
    if (screenHeight < 800) return 260; // Medium devices
    return 265; // Large devices
  }

  String _getSectionType(BuildContext context) {
    final lang = Languages.of(context)!;
    if (title == lang.JustforYou) return "just_for_you";
    if (title == lang.latechange) return "last_chance_deals";
    if (title == lang.availablenow) return "available_now";
    if (title == lang.DinnertimeDeals) return "dinnertime_deals";
    return "just_for_you";
  }
}
