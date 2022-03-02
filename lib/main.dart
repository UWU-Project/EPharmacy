import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_pal/pillreminder/dao/medicine_dao.dart';
import 'package:pill_pal/pillreminder/dao/reminder_check_dao.dart';
import 'package:pill_pal/pillreminder/dao/reminder_dao.dart';
import 'package:pill_pal/pillreminder/database.dart';
import 'package:pill_pal/pillreminder/entities/medicine.dart';
import 'package:pill_pal/pillreminder/pages/Home/home.dart';
import 'package:pill_pal/pillreminder/pages/cabinet/cabinet.dart';
import 'package:pill_pal/pillreminder/pages/calender/calender.dart';
import 'package:pill_pal/pillreminder/pages/landing/landing1.dart';
import 'package:pill_pal/pillreminder/pages/landing/landing2.dart';
import 'package:pill_pal/pillreminder/pages/landing/landing3.dart';
import 'package:pill_pal/pillreminder/pages/medicineAddPage/medicineAddPage.dart';
import 'package:pill_pal/pillreminder/pages/medicineEditPage/medicineEditPage.dart';
import 'package:pill_pal/pillreminder/pages/medicineItemPage/medicineItemPage.dart';
import 'package:pill_pal/pillreminder/pages/reminderAddPage/reminderAddPage.dart';
import 'package:pill_pal/pillreminder/pages/splash.dart';
import 'package:pill_pal/providers/provider_setup.dart';
import 'package:pill_pal/screens/auth/auth_stream.dart';
import 'package:pill_pal/screens/home_screen.dart';
import 'package:pill_pal/screens/landing_screen.dart';


import 'package:pill_pal/theme.dart';
import 'package:pill_pal/pillreminder/util/databaseTestUtil.dart';
import 'package:pill_pal/pillreminder/util/notificationUtil.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'login/screens/home_screen.dart';
import 'screens/auth/login_screen.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

Future onSelectNotification(payload) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final route = payload.toString().split(" ")[0];
  final value = payload.toString().split(" ")[1];
  if (route == 'medicine') {
    final medicineDao = database.medicineDao;
    Medicine? med = await medicineDao.findMedicineById(int.parse(value));
    await Navigator.pushNamedAndRemoveUntil(
        MyApp.navigatorKey.currentState!.context,
        '/medicine_item',
        ModalRoute.withName('/home'),
        arguments: med);
  } else {
    DateTime? dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(value));
    await Navigator.pushNamedAndRemoveUntil(
        MyApp.navigatorKey.currentState!.context,
        '/calender', ModalRoute.withName('/home'),
        arguments: dateTime);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeNotifications();
  tz.initializeTimeZones();

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final medicineDao = database.medicineDao;
  final reminderDao = database.reminderDao;
  final reminderCheckDao = database.reminderCheckDao;

  await addDatabaseDumpData(medicineDao, reminderDao);


  runApp(MyApp(
    reminderDao: reminderDao,
    medicineDao: medicineDao,
    reminderCheckDao: reminderCheckDao,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
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
      providers: providers,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: defaultTheme,
          navigatorKey: navigatorKey,
          initialRoute: '/',
          routes: {
            '/': (context) => LandingScreen(),
            '/Login-screen': (context) => LoginScreen(),
            '/Auth-screen': (context) => AuthStateScreen(),

            '/homeScreen': (context) => HomeNew(
              medicineDao: medicineDao,
              reminderDao: reminderDao,
              reminderCheckDao: reminderCheckDao,
            ),

            '/landing1': (context) => Landing1(),
            '/landing2': (context) => Landing2(),
            '/landing3': (context) => Landing3(),

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
          ),
    );
  }
}
