import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_pal/models%20&%20providers/order.dart';
import 'package:pill_pal/pillreminder/dao/medicine_dao.dart';
import 'package:pill_pal/pillreminder/dao/reminder_check_dao.dart';
import 'package:pill_pal/pillreminder/dao/reminder_dao.dart';
import 'package:pill_pal/pillreminder/entities/medicine.dart';
import 'package:pill_pal/login/models/user_model.dart';
import 'package:pill_pal/pillreminder/pages/Home/home.dart';
import 'package:pill_pal/pillreminder/pages/cabinet/cabinet.dart';
import 'package:pill_pal/pillreminder/pages/calender/calender.dart';
import 'package:pill_pal/pillreminder/pages/medicineAddPage/medicineAddPage.dart';
import 'package:pill_pal/pillreminder/pages/medicineEditPage/medicineEditPage.dart';
import 'package:pill_pal/pillreminder/pages/medicineItemPage/medicineItemPage.dart';
import 'package:pill_pal/pillreminder/pages/reminderAddPage/reminderAddPage.dart';
import 'package:pill_pal/screens/auth/auth_stream.dart';
import 'package:pill_pal/screens/auth/signup_screen.dart';
import 'package:pill_pal/screens/landing_screen.dart';
import 'package:pill_pal/screens/orders/orders_screen.dart';
import 'package:pill_pal/view/home_page.dart';
import 'package:pill_pal/view/prescription_upload.dart';

import 'package:pill_pal/models%20&%20providers/cart.dart';
import 'package:pill_pal/models%20&%20providers/product.dart';
import 'package:pill_pal/models%20&%20providers/wishlist.dart';
import 'package:pill_pal/screens/bottom_nav_screen.dart';
import 'package:pill_pal/screens/cart/cart_screen.dart';
import 'package:pill_pal/screens/feeds_screen.dart';
import 'package:pill_pal/screens/home_screen.dart';
import 'package:pill_pal/screens/inner_screens/brands_nav_rail.dart';
import 'package:pill_pal/screens/inner_screens/categories_feed_screen.dart';
import 'package:pill_pal/screens/inner_screens/product_details_screen.dart';
import 'package:pill_pal/screens/search_screen.dart';
import 'package:pill_pal/screens/user_scren.dart';
import 'package:pill_pal/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import '/models & providers/my_theme.dart';

import '../../screens/auth/login_screen.dart';


class HomeNew extends StatelessWidget {
  const HomeNew(
      {Key? key,
        required this.medicineDao,
        required this.reminderDao,
        required this.reminderCheckDao})
      : super(key: key);

  final MedicineDao medicineDao;
  final ReminderDao reminderDao;
  final ReminderCheckDao reminderCheckDao;

  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeNotifier()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => WishlistProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderProvider()),
      ],
      child: Consumer<ThemeNotifier>(builder: (context, notifier, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyAppTheme.myThemes(notifier.isDark, context),
          home: const AuthStateScreen(),

          navigatorKey: navigatorKey,


          routes: {
            // BottomNavScreen.routeName: (ctx) => const BottomNavScreen(),
            // HomeScreenNew.routeName: (ctx) => const HomeScreenNew(),
            '/home': (context) => Home(
              reminderDao: reminderDao,
              reminderCheckDao: reminderCheckDao,
            ),

            '/cabinet': (context) => Cabinet(
              medicineDao: medicineDao,
            ),
            '/medicine_add': (context) => MedicineAddPage(
              medicineDao: medicineDao,
            ),
            '/reminder_add': (context) => ReminderAddPage(
              medicineDao: medicineDao,
              reminderDao: reminderDao,
            ),
            '/calender': (context) => Calender(
              medicineDao: medicineDao,
              reminderDao: reminderDao,
              reminderCheckDao: reminderCheckDao,
            ),

            BottomNavScreen.routeName: (ctx) => const BottomNavScreen(),
            FeedsScreen.routeName: (ctx) => FeedsScreen(),
            SearchScreen.routeName: (ctx) => const SearchScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            UserScreen.routeName: (ctx) => const UserScreen(),
            BrandsNavRailScreen.routeName: (ctx) => const BrandsNavRailScreen(),
            WishlistScreen.routeName: (ctx) => const WishlistScreen(),
            OrderScreen.routeName: (ctx) => const OrderScreen(),
            ProductDetailsScreen.routeName: (ctx) =>
            const ProductDetailsScreen(),
            CategoriesFeedScreen.routeName: (ctx) =>
            const CategoriesFeedScreen(),

            // LandingScreen.routeName: (ctx) => const LandingScreen(),
            // LoginScreen.routeName: (ctx) => LoginScreen(),
            // SignupScreen.routeName: (ctx) => SignupScreen(),

          },
            onGenerateRoute: (settings) {
              if (settings.name == '/calender') {
                final passedDay = settings.arguments as DateTime;
                return MaterialPageRoute(
                  builder: (context) {
                    return Calender(
                      medicineDao: medicineDao,
                      reminderDao: reminderDao,
                      reminderCheckDao: reminderCheckDao,
                      passedDay: passedDay,
                    );
                  },
                );
              } else if (settings.name == '/medicine_edit') {
                final med = settings.arguments as Medicine;
                return MaterialPageRoute(
                  builder: (context) {
                    return MedicineEditPage(medicineDao: medicineDao, med: med);
                  },
                );
              } else if (settings.name == '/medicine_item') {
                final med = settings.arguments as Medicine;
                return MaterialPageRoute(
                  builder: (context) {
                    return MedicineItemPage(
                        medicineDao: medicineDao,
                        reminderDao: reminderDao,
                        med: med);
                  },
                );
              } else if (settings.name == '/reminder_add') {
                final med = settings.arguments as Medicine;
                return MaterialPageRoute(
                  builder: (context) {
                    return ReminderAddPage(
                        medicineDao: medicineDao,
                        reminderDao: reminderDao,
                        savedSelectedMedicine: med);
                  },
                );
              }
              //print('Need to implement ${settings.name}');
              return null;
            }
        );
      }),
    );
  }
}

// moved to HomeScreen New
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel loggedInUser = UserModel();
//
//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(user!.uid)
//         .get()
//         .then((value) {
//       this.loggedInUser = UserModel.fromMap(value.data());
//       setState(() {});
//     });
//   }
//
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("WELCOME"),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 150,
//                 child: Image.asset("assets/logo.png", fit: BoxFit.contain),
//               ),
//               Text(
//                 "WELCOME BACK",
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight:
//                     FontWeight.bold),
//               ),
//               SizedBox(height: 10,),
//               Text("${loggedInUser.firstName} ${loggedInUser.lastName}",
//                   style:TextStyle(
//                     color: Colors.black54,
//                     fontWeight: FontWeight.w500,
//                   )
//               ),
//               Text("${loggedInUser.email}",
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontWeight: FontWeight.w500,
//                   )
//               ),
//               SizedBox(height: 15),
//
//               ActionChip(
//                   label: Text("Logout"),
//                   onPressed: () {
//                     logout(context);
//                   }),
//               SizedBox(height: 15),
//               ActionChip(
//                   label: Text("Pill Reminder"),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/home');
//                   }),
//               ActionChip(
//                   label: Text("Prescription OCR Reader"),
//                   onPressed: () {
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (_) => const HomePage()));
//                   }),
//               ActionChip(
//                   label: Text("Prescription Upload"),
//                   onPressed: () {
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (_) => const PrescUpload()));
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   // the logout function
//   Future<void> logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => LoginScreen()));
//   }
//
//
// }
