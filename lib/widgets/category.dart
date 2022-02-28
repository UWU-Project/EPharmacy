import 'package:flutter/material.dart';
import 'package:pill_pal/screens/inner_screens/categories_feed_screen.dart';

class Category extends StatefulWidget {
  late int i;

  Category({
    required this.i,
    Key? key,
  }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List<Map<String, Object>> _categories = [
    {
      'catName': 'Hair care',
      'catImage': 'assets/images/CatHaircare.jpg',
    },
    {
      'catName': 'Face Wash',
      'catImage': 'assets/images/CatFacewash.jpg',
    },
    {
      'catName': 'Baby Care',
      'catImage': 'assets/images/Catbaby.jpg',
    },
    {
      'catName': 'First Aid',
      'catImage': 'assets/images/Catfirstaid.jpg',
    },
    {
      'catName': 'Pain & Fever',
      'catImage': 'assets/images/Catpain.jpg',
    },
    {
      'catName': 'Womens Care',
      'catImage': 'assets/images/Catwomes.jpg',
    },
    {
      'catName': 'Health Devices',
      'catImage': 'assets/images/Cathealthdevices.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          CategoriesFeedScreen.routeName,
          arguments: _categories[widget.i]['catName'],
        );
        // print('${_categories[widget.i]['catName']}');
      },
      child: Container(
        height: 200,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  (_categories[widget.i]['catImage']).toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ' ${(_categories[widget.i]['catName']).toString()}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
