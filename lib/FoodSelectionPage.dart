import 'package:flutter/material.dart';


class ProductGroup {
  final String name;
  final String imagePath;

  ProductGroup({required this.name, required this.imagePath});
}

class Product {
  final String name;

  Product({required this.name});
}
class SelectedProductsPlate extends StatefulWidget {
  final List<Product> selectedProducts;

  SelectedProductsPlate({required this.selectedProducts});

  @override
  _SelectedProductsPlateState createState() => _SelectedProductsPlateState();
}
class _SelectedProductsPlateState extends State<SelectedProductsPlate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: widget.selectedProducts.map((product) {
          return Chip(
            label: Text(product.name),
            onDeleted: () {
              setState(() {
                // Pašaliname produktą iš sąrašo
                widget.selectedProducts.removeWhere((p) => p.name == product.name);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}



class FoodSelectionPage extends StatefulWidget {
  @override
  _FoodSelectionPageState createState() => _FoodSelectionPageState();
}

class _FoodSelectionPageState extends State<FoodSelectionPage> {
  bool fruitsEaten = false;
bool veggiesEaten = false;
    static const int _MAX_PRODUCT_COUNT = 5; // Pavyzdys, galite nustatyti bet kokį skaičių

  DateTime selectedDate = DateTime.now();
  List<ProductGroup> productGroups = [
    ProductGroup(name: 'Vaisiai', imagePath: 'assets/images/fruits.png'),
    ProductGroup(name: 'Grūdai', imagePath: 'assets/images/grains.png'),
    ProductGroup(name: 'PIENO PRODUKTAI', imagePath: 'assets/images/milk.png'),
    ProductGroup(name: 'MĖSOS PRODUKTAI', imagePath: 'assets/images/meat.png'),
    ProductGroup(name: 'ŽUVIES PRODUKTAI', imagePath: 'assets/images/fish.png'),
    ProductGroup(name: 'DUONOS GAMINIAI', imagePath: 'assets/images/bread.png'),
    ProductGroup(name: 'DARŽOVĖS', imagePath: 'assets/images/vegetable.png'),
    ProductGroup(name: 'SALDUMYNAi', imagePath: 'assets/images/sweets.png'),
    ProductGroup(name: 'Vanduo', imagePath: 'assets/images/water.png'),
    ProductGroup(name: 'Gėrimai', imagePath: 'assets/images/drink.png'),
    // Pridėti kitas produktų grupes čia
  ];
  List<Product> selectedProducts = [];
  // Define the fruit and vegetable names
  final List<String> _fruitNames = [
    'Apelsinas', 'Obuolys', 'Citrina', // Add more fruit names here
  ];

  final List<String> _veggieNames = [
    'Morka', 'Bulvė', 'Pomidoras', // Add more vegetable names here
  ];

  // Use these lists in the _containsProduct method
  bool _containsProduct(ProductGroup group, Product product) {
    return group.name == 'Vaisiai' && _fruitNames.contains(product.name) ||
           group.name == 'Daržovės' && _veggieNames.contains(product.name);
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Pasirink šiandienos maistą'),
    ),
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverToBoxAdapter(
          child: TextButton(
            onPressed: () => _selectDate(context),
            child: Text(
              'Pasirinkite datą: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100, // Aukštis vienai eilutei
            child: ListView(
  scrollDirection: Axis.horizontal,
  children: List.generate(
    (productGroups.length / 5).ceil(), // Skaičiuojame, kiek eilučių reikės
    (rowIndex) {
      return Row(
        children: List.generate(
          5, // Kiekvienoje eilutėje rodomi 5 produktai
          (index) {
            final productIndex = (rowIndex * 5) + index;
            if (productIndex < productGroups.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4), // Tarpas tarp produktų
                child: ElevatedButton(
                  onPressed: () {
                    _showProductDialog(context, productGroups[productIndex]);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        productGroups[productIndex].imagePath,
                        width: 50,
                        height: 50,
                      ),
                      Text(productGroups[productIndex].name),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(width: 50); // Tarpas, jei produktų nėra pakankamai
            }
          },
        ),
      );
    },
  ),
),

          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverToBoxAdapter(
          child: Text('Šiandien valgiau šiuos produktus:'),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: selectedProducts.map((product) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        setState(() {
          selectedProducts.remove(product);
        });
      },
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(product.name),
            Icon(Icons.close),
          ],
        ),
      ),
    ),
  );
}).toList(),

            ),
          ),
        ),
      ],
    ),
     bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Įvykdo veiksmus, kai paspaudžiamas mygtukas "Baigta"
            _finishSelection();
            _showSelectedProductsDialog();
          },
          child: Text('Baigta'),
        ),
      ),
    );
  
}


  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showProductDialog(BuildContext context, ProductGroup productGroup) {
  List<Product> productGroupProducts = _getProductGroupProducts(productGroup);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Pasirinkite ${productGroup.name} produktus'),
        content: SingleChildScrollView(
          child: Column(
            children: productGroupProducts.map((product) {
              int selectedProductCount = selectedProducts.where((p) => p.name == product.name).length;

              return ListTile(
                title: Text(product.name),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      // Patikriname, ar produktas jau yra sąraše
                      if (selectedProductCount < _MAX_PRODUCT_COUNT) {
                        selectedProducts.add(product); // Pridedame produktą į sąrašą
                      } else {
                        // Jei per daug kartų pridėta, pašaliname produktą
                        selectedProducts.remove(product);
                      }
                      print(selectedProducts); // Patikrinkime, kaip keičiasi sąrašas
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Uždaryti'),
          ),
        ],
      );
    },
  );
}


  List<Product> _getProductGroupProducts(ProductGroup productGroup) {
    List<Product> products = [];

    if (productGroup.name == 'Vaisiai') {
      products = [
        Product(name: 'Apelsinas'),
        Product(name: 'Obuolys'),
        Product(name: 'Citrina'),
        // Čia galite pridėti daugiau vaisių
      ];
    } else if (productGroup.name == 'Grūdai') {
      products = [
        Product(name: 'Pilno grūdo duona'),
        Product(name: 'Kviečių košė'),
        Product(name: 'Riestainiai'),
        // Čia galite pridėti daugiau grūdų produktų
      ];
    }
    else if (productGroup.name == 'PIENO PRODUKTAI') {
    products = [
      Product(name: 'Pienas'),
      Product(name: 'Varškė'),
      Product(name: 'Jogurtas'),
      Product(name: 'Sūris'),
      Product(name: 'PIK NIk lazdelė'),
      Product(name: 'Kefyras'),
      // Čia galite pridėti daugiau pieno produktų
    ];
  } else if (productGroup.name == 'MĖSOS PRODUKTAI') {
    products = [
      Product(name: 'Višta'),
      Product(name: 'Kiaulė'),
      // Čia galite pridėti daugiau mėsos produktų
    ];
  } else if (productGroup.name == 'ŽUVIES PRODUKTAI') {
    products = [
      Product(name: 'Lašiša'),
      Product(name: 'Žuvies piršteliai'),
      Product(name: 'Lydeka'),
      // Čia galite pridėti daugiau žuvies produktų
    ];
  }
   else if (productGroup.name == 'DUONOS GAMINIAI') {
  products = [
    Product(name: 'Duonos kepalėlis'),
    Product(name: 'Bandelė'),
    // Čia galite pridėti daugiau duonos gaminių
  ];
} else if (productGroup.name == 'DARŽOVĖS') {
  products = [
    Product(name: 'Morka'),
    Product(name: 'Bulvė'),
    Product(name: 'Pomidoras'),
    // Čia galite pridėti daugiau daržovių
  ];
} else if (productGroup.name == 'SALDUMYNŲ') {
  products = [
    Product(name: 'Guminukai'),
    Product(name: 'Sausainiai'),
    Product(name: 'Saldainiai'),
    Product(name: 'Šokoladas'),
    Product(name: 'Čipsai'),
    // Čia galite pridėti daugiau saldumynų
  ];
} else if (productGroup.name == 'Vanduo') {
  products = [
    Product(name: 'Vandens stiklinė'),
    // Čia galite pridėti daugiau vandens produktų
  ];
} else if (productGroup.name == 'Gėrimai') {
  products = [
    Product(name: 'Gėrimų stiklinė'),
    // Čia galite pridėti daugiau gėrimų produktų
  ];
}


    return products;
  }
void _finishSelection() {
  setState(() {
    fruitsEaten = selectedProducts.any((product) =>
        productGroups.where((group) => group.name == 'Vaisiai').expand((group) => _getProductGroupProducts(group)).any((p) => p.name == product.name));
    
    veggiesEaten = selectedProducts.any((product) =>
        productGroups.where((group) => group.name == 'Daržovės').expand((group) => _getProductGroupProducts(group)).any((p) => p.name == product.name));
  });
}



void _showSelectedProductsDialog() {
  List<Product> fruits = selectedProducts
      .where((product) => productGroups.any((group) => group.name == 'Vaisiai' && _containsProduct(group, product)))
      .toList();
  List<Product> veggies = selectedProducts
      .where((product) => productGroups.any((group) => group.name == 'Daržovės' && _containsProduct(group, product)))
      .toList();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Šiandien valgiau šiuos produktus:'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ŠIANDIEN valgiau šiuos vaisius:'),
            Wrap(
              children: fruits.map((product) => Chip(label: Text(product.name))).toList(),
            ),
            Text('ŠIANDIEN valgiau šias daržoves:'),
            Wrap(
              children: veggies.map((product) => Chip(label: Text(product.name))).toList(),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Uždaryti'),
          ),
        ],
      );
    },
  );
}


  void _showMissingProductsDialog(BuildContext context) {
    // Toliau jūsų pamiršto produktų dialogo langas kodas
  }
}
