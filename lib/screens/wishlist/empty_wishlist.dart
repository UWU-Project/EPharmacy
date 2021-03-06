import 'package:flutter/material.dart';
import 'package:pill_pal/screens/bottom_nav_screen.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/empty-wishlist.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Text(
            'Your Wishlist is Empty',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Looks Like You Didn\'t \n Add Anything Yet.',
            style: TextStyle(
              fontSize: 26,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
          const SizedBox(height: 120),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(BottomNavScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              child: const Text(
                'Shop Now',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
