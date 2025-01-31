import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final VoidCallback onpressed;

  const FilterScreen({super.key, required this.onpressed});
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool showSoldOut = false;
  int selectedDay = 0; // 0 for Today, 1 for Tomorrow
  double collectionTime = 24.0; // Slider value
  List<String> selectedFoodTypes = [];
  List<String> selectedDietPreferences = [];

  final List<String> foodTypes = [
    "Meals",
    "Bread & pastries",
    "Groceries",
    "Other"
  ];
  final List<String> dietPreferences = ["Vegetarian", "Vegan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Filters'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, "No filters selected");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show Sold Out
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Show sold out", style: TextStyle(fontSize: 16)),
                Switch(
                  value: showSoldOut,
                  onChanged: (value) {
                    setState(() {
                      showSoldOut = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Collection Day
            Text("Collection day",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDayButton("Today", 0),
                _buildDayButton("Tomorrow", 1),
              ],
            ),
            SizedBox(height: 16),

            // Collection Time
            Text("Collection time",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("All day", style: TextStyle(fontSize: 14)),
            Slider(
              value: collectionTime,
              min: 0,
              max: 24,
              divisions: 24,
              label: "${collectionTime.toInt()} hours",
              onChanged: (value) {
                setState(() {
                  collectionTime = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Food Types
            Text("Food types",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: foodTypes.map((type) {
                return _buildChip(
                  type,
                  selectedFoodTypes.contains(type),
                  () {
                    setState(() {
                      if (selectedFoodTypes.contains(type)) {
                        selectedFoodTypes.remove(type);
                      } else {
                        selectedFoodTypes.add(type);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Diet Preferences
            Text("Diet preferences",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: dietPreferences.map((preference) {
                return _buildChip(
                  preference,
                  selectedDietPreferences.contains(preference),
                  () {
                    setState(() {
                      if (selectedDietPreferences.contains(preference)) {
                        selectedDietPreferences.remove(preference);
                      } else {
                        selectedDietPreferences.add(preference);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            Spacer(),

            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      // Reset all filters
                      showSoldOut = false;
                      selectedDay = 0;
                      collectionTime = 24.0;
                      selectedFoodTypes.clear();
                      selectedDietPreferences.clear();
                    });
                  },
                  child: Text("Clear all"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filters logic here
                    Navigator.pop(context);
                  },
                  child: Text("Apply"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayButton(String text, int index) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedDay = index;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedDay == index ? Colors.green : Colors.white,
          foregroundColor: selectedDay == index ? Colors.white : Colors.black,
          side: BorderSide(color: Colors.green),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: Colors.green.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Colors.green : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
