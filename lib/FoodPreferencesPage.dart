import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodItem {
  final String name;
  final String imagePath;
  bool isAssigned;

  FoodItem({required this.name, required this.imagePath, this.isAssigned = false});
}

class Basket {
  final String name;
  final Color color;
  final String imagePath;
  List<FoodItem> items;

  Basket({required this.name, required this.color, required this.imagePath, List<FoodItem>? items})
      : this.items = items ?? [];
}

class FoodPreferencesPage extends StatefulWidget {
  @override
  _FoodPreferencesPageState createState() => _FoodPreferencesPageState();
}

class _FoodPreferencesPageState extends State<FoodPreferencesPage> {
  List<Basket> baskets = [
    Basket(name: "Labai dažnai valgau", color: Colors.green, imagePath: 'assets/images/basket1.png'),
    Basket(name: "Kartais valgau", color: Colors.yellow, imagePath: 'assets/images/basket2.png'),
    Basket(name: "Retai valgau", color: Colors.purple, imagePath: 'assets/images/basket3.png'),
    Basket(name: "Niekada", color: Colors.red, imagePath: 'assets/images/basket4.png'),
  ];

  List<FoodItem> foodItems = [
    FoodItem(name: 'Pieno produktai', imagePath: 'assets/images/milk.png'),
    FoodItem(name: 'Žuvis', imagePath: 'assets/images/fish.png'),
    FoodItem(name: 'Vaisiai', imagePath: 'assets/images/fruits.png'),
    // Add more food items here
  ];

  FoodItem? selectedFoodItem;
  bool allItemsAssigned = false;

  Future<void> markAsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('foodPreferencesCompleted', true);
  }

  void assignSelectedFoodToBasket(Basket basket) {
    if (selectedFoodItem != null) {
      setState(() {
        basket.items.add(selectedFoodItem!);
        selectedFoodItem!.isAssigned = true;
        selectedFoodItem = null;
        allItemsAssigned = foodItems.every((item) => item.isAssigned);
        if (allItemsAssigned) {
          _showCompletionDialog();
        }
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Šaunu!'),
          content: Text('Visi maisto produktai sėkmingai priskirti.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                markAsCompleted();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Gerai'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maisto produktų pageidavimai'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/happy_tooth.png', width: 100, height: 100),
                Text('Dantukas', style: TextStyle(color: Colors.blue)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var basket in baskets)
                  GestureDetector(
                    onTap: () => assignSelectedFoodToBasket(basket),
                    child: Column(
                      children: [
                        Image.asset(basket.imagePath, width: 100, height: 100),
                        Text(basket.name, style: TextStyle(color: basket.color)),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var item in basket.items)
                              Text(
                                item.name,
                                style: TextStyle(color: Colors.grey),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (var item in foodItems)
                    if (!item.isAssigned)
                      GestureDetector(
                        onTap: () => setState(() {
                          selectedFoodItem = item;
                        }),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedFoodItem == item ? Colors.grey[300] : null,
                          ),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Image.asset(item.imagePath, width: 50, height: 50),
                              SizedBox(height: 4),
                              Text(item.name),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (allItemsAssigned) {
                  _showCompletionDialog();
                }
              },
              child: Text('Baigta'),
            ),
          ],
        ),
      ),
    );
  }
}
