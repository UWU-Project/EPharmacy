import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_pal/login/screens/home_screen.dart';
import 'package:pill_pal/pillreminder/database.dart';
import 'package:pill_pal/screens/auth/reset_password_screen.dart';
import 'package:pill_pal/screens/auth/signup_screen.dart';
import 'package:pill_pal/services/global_methods.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pill_pal/pillreminder/pages/landing/landing1.dart';
import 'package:pill_pal/widgets/header_widget.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = '/Login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  // late final database;
  // late final medicineDao;
  // late final reminderDao;
  // late final reminderCheckDao;
  double _headerHeight = 250;
  void _chanageVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  bool _isVisible = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  GlobalMethods _globalMethods = GlobalMethods();

  void _submitData() async {



    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
    }
    try {

      final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final medicineDao = database.medicineDao;
      final reminderDao = database.reminderDao;
      final reminderCheckDao = database.reminderCheckDao;

      await _auth
          .signInWithEmailAndPassword(
          email: _email.toLowerCase().trim(), password: _password)
          .then((value) async => Navigator.canPop(context) ?
      
      // Navigator.pop(context) 
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => HomeNew(medicineDao: medicineDao, reminderDao: reminderDao, reminderCheckDao: reminderCheckDao)))
          : null);

  

    } catch (error) {
      _globalMethods.authDialog(context, error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,


      body:

      Stack(
        children: [
          Container(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight, true, Icons.login_outlined), //let's create a common header widget
          ),

          // RotatedBox(
          //   quarterTurns: 2,
          //   child: WaveWidget(
          //     config: CustomConfig(
          //       colors: [
          //         Colors.orangeAccent,
          //         Colors.tealAccent,
          //         Colors.pinkAccent,
          //         Colors.deepblue Accent,
          //       ],
          //       durations: [35000, 11000, 10800, 6000],
          //       heightPercentages: [0.01, 0.02, 0.03, 0.1],
          //       blur: const MaskFilter.blur(BlurStyle.solid, 0),
          //     ),
          //     heightPercentange: 0.2,
          //     size: const Size(double.infinity, double.infinity),
          //   ),
          // ),

          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Center(
                      child: Text(
                        ' ',
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                      ),

                    ),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 130),

                    TextFormField(
                      onSaved: (value) {
                        _email = value!;
                      },
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      onSaved: (value) {
                        _password = value!;
                      },
                      onEditingComplete: _submitData,
                      obscureText: _isVisible,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be atleast 8 units';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: Icon(_isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : ElevatedButton(
                          onPressed: _submitData,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                           ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => const ResetPasswordScreen()));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const SignupScreen()));
                        // .pushReplacementNamed(SignupScreen.routeName);
                  },
                  child: Text(
                    'Create an Account',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
