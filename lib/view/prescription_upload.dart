import 'dart:io';

import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pill_pal/login/imageupload/image_retrive.dart';
import 'package:pill_pal/login/imageupload/image_upload.dart';
import 'package:pill_pal/login/models/user_model.dart';



class PrescUpload extends StatefulWidget {
  const PrescUpload({Key? key}) : super(key: key);

  @override
  _PrescUploadState createState() => _PrescUploadState();
}

class _PrescUploadState extends State<PrescUpload> {
  File? image;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image != null
                  ? Image.file(
                image!,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.8,
              )
                  : Image.asset(
                'assets/prescmi.png',
                width: MediaQuery.of(context).size.width * 1,
              ),
            ),
            Column(
              children: [
                const Text(
                  'Guidance to Upload Prescription.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,decoration: TextDecoration.underline,),
                ),
                const Text(
                  'Dont crop out any part of the image.',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Include details of doctor and patient + clinic visit date',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Medicines will be dispensed as per the Prescription',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),

              ],
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageUpload(
                          userId: loggedInUser.id,
                        )));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              child: const Text("Upload Prescription"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ImageRetrive(userId: loggedInUser.id)));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              child: const Text("My Prescriptions"),
            ),
            const Text(
              '* Your uploaded prescription will be end to end encrypted. Only our pharmacists will have access to your prescription to verify it.',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                // decoration: TextDecoration.underline,
                // decorationColor: Colors.red,
                // decorationStyle: TextDecorationStyle.wavy,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
