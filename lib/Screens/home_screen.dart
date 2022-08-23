import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Screens/chat_screen.dart';
import 'package:messaging_app/Screens/login_screen.dart';
import 'package:messaging_app/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      userModel = UserModel(
        uid: value.id,
        email: value['email'],
        name: value['firstName'] + ' ' + value['secondName'],
      );
      loggedInUser = userModel;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Welcome",
          style: TextStyle(
              fontSize: 28,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF2AE3B)),
        ),
        centerTitle: true,
      ),
      body: loggedInUser == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child:
                          Image.asset("assets/logo.png", fit: BoxFit.contain),
                    ),
                    const Text(
                      "Welcome Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      loggedInUser!.name,
                      style: const TextStyle(
                          color: Color(0xFFF2AE3B),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    Text(
                      loggedInUser!.email,
                      style: const TextStyle(
                          color: Color(0xFFF2AE3B),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ActionChip(
                        label: const Text("Chat with friends"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  userModel: userModel!, firebaseUser: user!)));
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    ActionChip(
                        label: const Text("LogOut"),
                        onPressed: () {
                          logout(context);
                        }),
                  ],
                ),
              ),
            ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
