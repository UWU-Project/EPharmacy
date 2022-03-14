import 'package:flutter/material.dart';

class CategoryN extends StatelessWidget {
  const CategoryN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          color: Colors.pinkAccent,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.category_outlined),
                  color: Colors.white,
                  onPressed: () {}),
            ],
          ),
        ),
        Card(
          color: Colors.green,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Column(
            children: [
              IconButton(
                  icon: Icon(Icons.addchart_sharp),
                  color: Colors.white,
                  onPressed: () {}),
            ],
          ),
        ),
        Card(
          color: Colors.redAccent,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Column(
            children: [
              IconButton(
                  icon: Icon(Icons.child_care),
                  color: Colors.white,
                  onPressed: () {}),
            ],
          ),
        ),
        Card(
          color: Colors.lightBlue,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Column(
            children: [
              IconButton(
                  icon: Icon(Icons.fingerprint),
                  color: Colors.white,
                  onPressed: () {}),
            ],
          ),
        ),
        Card(
          color: Colors.deepOrange,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Column(
            children: [
              IconButton(
                  icon: Icon(Icons.food_bank_outlined),
                  color: Colors.white,
                  onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class Name extends StatelessWidget {
  const Name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: const [
            Text(
              " Categories",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.black),
            ),
          ],
        ),
        Column(
          children: const [
            Text(
              " Wellness",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.black),
            ),
          ],
        ),
        Column(
          children: const [
            Text(
              "  Baby Care",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.black),
            ),
          ],
        ),
        Column(
          children: const [
            Text(
              "  Diabetes",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.black),
            ),
          ],
        ),
        Column(
          children: const [
            Text(
              "Personal Care",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
