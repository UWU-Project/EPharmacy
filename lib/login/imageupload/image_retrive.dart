import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pill_pal/chat/pill_idf.dart';

class ImageRetrive extends StatefulWidget {
  final String? userId;
  const ImageRetrive({Key? key, this.userId}) : super(key: key);

  @override
  State<ImageRetrive> createState() => _ImageRetriveState();
}

class _ImageRetriveState extends State<ImageRetrive> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Prescriptions")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userId)
            .collection("images")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return (const Center(child: Text("No Images Found")));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                String url = snapshot.data!.docs[index]['downloadURL'];
                String state = snapshot.data!.docs[index]['state'];
                DateTime dt = (snapshot.data!.docs[index]['date']).toDate();
                // Timestamp date = snapshot.data!.docs[index]['date'].;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12,0,0,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(dt.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration.underline,
                                  // decorationColor: Colors.red,
                                  // decorationStyle: TextDecorationStyle.wavy,
                                ),),
                              Text(state,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration.underline,
                                  // decorationColor: Colors.red,
                                  // decorationStyle: TextDecorationStyle.wavy,
                                ),),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,8,0),
                        child: ElevatedButton(onPressed:(){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => const ChatPage()));
                        },
                          child: Text("Chat"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,8,0),
                        child: ElevatedButton(onPressed:(){
                          showAlertDialog(context);
                        },
                        child: Text("View"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),

    );

  }
}



showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

