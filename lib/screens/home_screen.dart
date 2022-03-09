import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:badges/badges.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_pal/login/models/user_model.dart';
import 'package:pill_pal/screens/auth/login_screen.dart';
import 'package:pill_pal/models%20&%20providers/product.dart';
import 'package:pill_pal/models%20&%20providers/wishlist.dart';
import 'package:pill_pal/pillidf/pill_id.dart';
import 'package:pill_pal/chat/pill_idf.dart';
import 'package:pill_pal/screens/feeds_screen.dart';
import 'package:pill_pal/screens/inner_screens/brands_nav_rail.dart';
import 'package:pill_pal/screens/wishlist/wishlist_screen.dart';
import 'package:pill_pal/view/home_page.dart';
import 'package:pill_pal/view/prescription_upload.dart';
import 'package:pill_pal/widgets/back_layer.dart';
import 'package:pill_pal/widgets/category.dart';
import 'package:pill_pal/widgets/popular_propducts.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

class HomeScreenNew extends StatefulWidget {
  static const routeName = '/Home-screen';

  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenNew> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final List<Widget> _carouselImages = [
    Image.asset('assets/images/carousel1.jpg'),
    Image.asset('assets/images/carousel2.jpg'),
    Image.asset('assets/images/carousel3.jpg'),
    Image.asset('assets/images/carousel4.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final popularProduct = productData.popularProducts;
    productData.fetchProducts();

    return Scaffold(
      body: BackdropScaffold(
        headerHeight: MediaQuery.of(context).size.height * 0.4,
        backLayerBackgroundColor: Colors.grey.shade900,
        appBar: BackdropAppBar(
          title: const Text('E-Pharma'),
          leading: const BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          actions: [
            Consumer<WishlistProvider>(builder: (context, wp, _) {
              return Badge(
                toAnimate: true,
                animationType: BadgeAnimationType.slide,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  wp.wishlistList.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishlistScreen.routeName);
                  },
                  icon: const Icon(Icons.favorite),
                ),
              );
            }),
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout)

            ),
          ],
        ),
        backLayer: const BackLayer(),

        frontLayer: ListView(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Carousel(
                images: _carouselImages,
                indicatorBgPadding: 7,
                dotSize: 5,
                boxFit: BoxFit.fitWidth,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "WELCOME,",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight:FontWeight.w500,
                        ),
                  ),
                  Text(" ${loggedInUser.name}",
                      style:TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                  Text("  ${loggedInUser.email}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                ],
              ),
            ),


          Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Image.asset('assets/1i.png'),
                      color: Colors.white,
                      onPressed: () {
                    Navigator.pushNamed(context, '/home');

                  }
                  ),
                  const Text("PILL REMINDER",
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.white),
                  ),

                ],

              ),
            ),
            elevation: 8,
            color: Colors.blue,
            margin: EdgeInsets.all(20),
            shape:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueAccent, width: 1)
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50,0,0,0),
                child: Card(
                  color: Colors.pinkAccent,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),

                  child: Column(
                    children: [

                      IconButton(
                          icon: Icon(Icons.graphic_eq_rounded),color: Colors.white, onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => const PrescUpload()));
                      }),

                    ],
                  ),
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
                        icon: Icon(Icons.rate_review_rounded),color: Colors.white, onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const HomePage()));
                    }),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,50,0),
                child: Card(
                  color: Colors.pinkAccent,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),

                  child: Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.message),color: Colors.white, onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => const ChatPage()));
                      }),
                    ],
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0,0,50,0),
              //   child: Card(
              //     color: Colors.redAccent,
              //     elevation: 20,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(150),
              //     ),
              //     child: Column(
              //       children: [
              //         IconButton(
              //             icon: Icon(Icons.message), color: Colors.white,onPressed: () {}),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),

            const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30,0,0,0),
                child: Column(
                  children: const [
                    Text("My Prescriptions",
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),

              Column(
                children: const [
                  Text("OCR Reader",
                    style: TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,50,0),
                child: Column(
                  children: const [
                    Text("  Messenger",
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),


            const SizedBox(height: 8),



            // // Pill Identifier Button 272 - 298
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(50,0,0,0),
            //       child: Card(
            //         color: Colors.pinkAccent,
            //         elevation: 20,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(150),
            //         ),
            //
            //         child: Column(
            //           children: [
            //             IconButton(
            //                 icon: Icon(Icons.rate_review_rounded),color: Colors.white, onPressed: () {
            //               Navigator.of(context)
            //                   .push(MaterialPageRoute(builder: (_) => const ChatPage()));
            //             }),
            //           ],
            //         ),
            //       ),
            //     ),
            //
            //
            //   ],
            //
            // ),

            // Pill Identifier Button 272 - 298

            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Card(
            //     color: Colors.lightBlueAccent,
            //     elevation: 20,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(150),
            //     ),
            //     child: Column(
            //       children: [
            //         IconButton(
            //             icon: Icon(Icons.rate_review_rounded),color: Colors.white, onPressed: () {
            //           Navigator.of(context)
            //               .push(MaterialPageRoute(builder: (_) => PillID2()));
            //         }
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Image.asset('assets/5i.png'),
                        color: Colors.white,
                        onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => PillID2()));
                    }
                    ),
                    const Text("PILL IDENTIFIER",
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.white),
                    ),

                  ],

                ),
              ),
              elevation: 8,
              color: Colors.blue,
              margin: EdgeInsets.all(20),
              shape:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1)
              ),
            ),


            const SizedBox(height: 8),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (ctx, i) {
                  return Row(
                    children: [
                      Category(
                        i: i,
                      ),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         'Popular Brands',
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            //       ),
            //       TextButton(
            //           onPressed: () {
            //             Navigator.of(context).pushNamed(
            //               BrandsNavRailScreen.routeName,
            //               arguments: 7,
            //             );
            //           },
            //           child: const Text('view all')),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 200,
            //   width: double.infinity,
            //   child: Swiper(
            //     onTap: (index) {
            //       Navigator.of(context).pushNamed(
            //         BrandsNavRailScreen.routeName,
            //         arguments: index,
            //       );
            //     },
            //     autoplay: true,
            //     viewportFraction: 0.8,
            //     scale: 0.9,
            //     itemCount: _swiperImages.length,
            //     itemBuilder: (ctx, i) {
            //       return Container(
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           border: Border.all(width: 2, color: Colors.grey),
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         child: Image.asset(
            //           _swiperImages[i],
            //           fit: BoxFit.contain,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          FeedsScreen.routeName,
                          arguments: 'popular',
                        );
                      },
                      child: const Text('view all')),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularProduct.length,
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider.value(
                    value: popularProduct[i],
                    child: const PopularProducts(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
