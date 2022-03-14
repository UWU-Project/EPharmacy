import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:pill_pal/screens/auth/login_screen.dart';
import 'package:pill_pal/screens/auth/signup_screen.dart';
import 'package:pill_pal/services/global_methods.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = '/landing-screen';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;

  void _signInAnon() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInAnonymously().then(
          (value) => Navigator.canPop(context) ? Navigator.pop(context) : null);
    } catch (error) {
      _globalMethods.authDialog(context, error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          var date = DateTime.now().toString();
          var parsedDate = DateTime.parse(date);
          var formattedDate =
              '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
          final authResult =
              await _auth.signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ));
          FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user!.uid)
              .set({
            'id': authResult.user!.uid,
            'name': authResult.user!.displayName,
            'email': authResult.user!.email,
            'phoneNumber': authResult.user!.phoneNumber,
            'imageUrl': authResult.user!.photoURL,
            'joinedDate': formattedDate,
            // 'createdAt': TimeStamp.now()
          });
        } catch (error) {
          _globalMethods.authDialog(context, error.toString());
        }
      }
    }
  }

  final List<String> _images = [
    'assets/images/shopping1.png',
    'assets/images/shopping2.png',
  ];

  @override
  void initState() {
    _images.shuffle();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });

    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              _images[0],
              fit: BoxFit.cover,
              alignment: FractionalOffset(_animation.value, 0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 75),
              Center(
                child: Text(
                  'E-PHARMA',
                  style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  'YOUR MEDICAL PARTNER',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: Lottie.asset('assets/epicon.json'),
              ),
            ],
          ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const SizedBox(height: 50),
          //     Center(
          //       child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_jcsfwbvi.json'),
          //     ),
          //   ],
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(width: 10),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.of(context)
                  //           .push(MaterialPageRoute(builder: (_) => const SignupScreen()));
                  //     },
                  //     child: const Text(
                  //       'Signup',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const SignupScreen()));
                        },
                        child: const Text(
                          'Signup',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Image.asset('assets/3.png'),
                      tooltip: 'GOOGLE SIGN IN',
                      onPressed: _googleSignIn,
                    ),

                    // child: ElevatedButton(
                    //   onPressed: _googleSignIn,
                    //   child: const Text(
                    //     'Google',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ),

                  // const SizedBox(width: 10),
                  // Expanded(
                  //   child: _isLoading
                  //       ? Center(child: CircularProgressIndicator())
                  //       : ElevatedButton(
                  //           onPressed: () {
                  //             _signInAnon();
                  //           },
                  //           child: const Text(
                  //             'Guest',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ),
                  // ),
                  const SizedBox(width: 10),
                ],
              ),
              Text(
                'Signin with Google',
                style: TextStyle(color: Colors.blueAccent),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
