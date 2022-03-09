import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddressScreen extends StatelessWidget {
  static const routeName = '/Address-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black54, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Address",
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.add_location_alt_outlined,
              size: 50,
            ),
            const SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        labelText: 'Address Line 01',
                        suffixIcon: Icon(
                          Icons.error,
                        ),
                        hintText: 'Address Line 01',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        labelText: 'Address Line 02',
                        suffixIcon: Icon(
                          Icons.error,
                        ),
                        hintText: 'Address Line 02',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        labelText: 'City',
                        suffixIcon: Icon(
                          Icons.error,
                        ),
                        hintText: 'City',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        labelText: 'Postal Code',
                        suffixIcon: Icon(
                          Icons.error,
                        ),
                        hintText: 'Postal Code',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        labelText: 'Mobile',
                        suffixIcon: Icon(
                          Icons.error,
                        ),
                        hintText: 'Mobile',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          primary: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
