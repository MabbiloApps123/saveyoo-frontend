import 'package:flutter/material.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Widgets/primary_button.dart';

class FilterScreen extends StatelessWidget {
  final VoidCallback onpressed;
  const FilterScreen({
    super.key,
    required this.onpressed,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Filters'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, "No filters selected");
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price range', style: TextStyle(fontSize: 18)),
            RangeSlider(
              values: RangeValues(78, 143),
              min: 0,
              max: 200,
              onChanged: (values) {},
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            PrimaryButton(
                mButtonname: "Apply",
                onpressed: () {
                  Navigator.pop(context, "Price Range: \$20 - \$100");
                },
                mSelectcolor: mPrimaryColor,
                mTextColor: Colors.white),
          ],
        ),
      ),
    );
  }
}

// Reusable Widgets for Filter Options
class ColorOption extends StatelessWidget {
  final Color color;

  const ColorOption(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String size;

  const SizeOption(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(size, style: TextStyle(fontSize: 16)),
    );
  }
}

class CategoryOption extends StatelessWidget {
  final String category;

  const CategoryOption(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(category, style: TextStyle(fontSize: 16)),
    );
  }
}
