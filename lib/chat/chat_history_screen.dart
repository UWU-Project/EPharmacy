import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pill_pal/chat/chat__screen.dart';
import 'package:pill_pal/screens/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  _ChatHistoryScreenState createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  List<types.User> users = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('uid', '');
                final route =
                    MaterialPageRoute(builder: (_) => LandingScreen());
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () {
              _showDialog();
            },
          ),
          bottom: TabBar(
            onTap: (index) {
              // Tab index when user select it, it start from zero
            },
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.chat)),
            ],
          ),
        ),
        body: _getBody(),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (_) {
        final controller = TextEditingController();
        return _SystemPadding(
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text('CREATE'),
                  onPressed: () async {
                    final halfLength = (users.length / 2).ceil();

                    final leftSide = users.sublist(0, halfLength);

                    final room =
                        await FirebaseChatCore.instance.createGroupRoom(
                      imageUrl: '',
                      name: controller.text,
                      users: users,
                    );
                    final route = MaterialPageRoute(
                      builder: (_) => ChatScreen(roomId: room.id),
                    );
                    Navigator.pop(context);
                    Navigator.push(context, route);
                  })
            ],
          ),
        );
      },
    );
  }

  Widget _getBody() {
    return TabBarView(
      children: [
        _getUserList(),
        _getChatList(),
      ],
    );
  }

  Widget _getUserList() {
    return StreamBuilder<List<types.User>>(
      stream: FirebaseChatCore.instance.users(),
      initialData: [],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error occurred'));
        }

        this.users = snapshot.data as List<types.User>;

        final selfUid = FirebaseAuth.instance.currentUser!.uid;
        users = users.where((u) => selfUid != u.id).toList();

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, index) {
            final user = users[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
              ),
              padding: EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                ),
                title: Text(user.firstName! + ' ' + user.lastName!),
                onTap: () async {
                  final room =
                      await FirebaseChatCore.instance.createRoom(users[index]);
                  final route = MaterialPageRoute(
                    builder: (_) => ChatScreen(roomId: room.id),
                  );
                  Navigator.push(context, route);
                },
              ),
            );
          },
        );
      },
    );
  }

  _getChatList() {
    return StreamBuilder<List<types.Room>>(
      stream: FirebaseChatCore.instance.rooms(),
      initialData: const [],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error occurred'));
        }

        final data = snapshot.data as List<types.Room>;

        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              final room = data[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
                padding: EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                  ),
                  title: Text(room.name ?? 'no name'),
                  onTap: () async {
                    final route = MaterialPageRoute(
                      builder: (_) => ChatScreen(roomId: room.id),
                    );
                    Navigator.push(context, route);
                  },
                ),
              );
            });
      },
    );
  }

  /// _fetchUsers() async {
  ///   CollectionReference users = FirebaseFirestore.instance.collection('users');
  ///
  ///   final selfUid = FirebaseAuth.instance.currentUser!.uid;
  ///
  ///   users.get().then((querySnapshot) {
  ///     final users = querySnapshot.docs.map((result) {
  ///       return ChatListUser(
  ///         uid: result.id,
  ///         firstName: result['firstName'],
  ///         lastName: result['lastName'],
  ///       );
  ///     }).toList();
  ///
  ///     this.users = users.where((element) => selfUid != element.uid).toList();
  ///     setState(() {
  ///       _isLoading = false;
  ///     });
  ///   });
  /// }

}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
