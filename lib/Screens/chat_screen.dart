import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Screens/chat_room.dart';
import 'package:messaging_app/Screens/search_page.dart';
import 'package:messaging_app/models/chat_room_model.dart';
import 'package:messaging_app/models/firebase_helper_model.dart';
import 'package:messaging_app/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const ChatScreen(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Chats',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 28,
                color: Color(0xFFF2AE3B)),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              color: Color(0xFFF2AE3B),
            ),
            onPressed: () {
              //passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chatrooms")
                  .where("participants.${widget.userModel.uid}",
                      isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot chatRoomSnapshot =
                        snapshot.data as QuerySnapshot;

                    return ListView.builder(
                      itemCount: chatRoomSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                            chatRoomSnapshot.docs[index].data()
                                as Map<String, dynamic>);

                        Map<String, dynamic> participants =
                            chatRoomModel.participants!;

                        List<String> participantKeys =
                            participants.keys.toList();
                        participantKeys.remove(widget.userModel.uid);

                        return FutureBuilder(
                          future: FirebaseHelper.getUserModelById(
                              participantKeys[0]),
                          builder: (context, userData) {
                            if (userData.connectionState ==
                                ConnectionState.done) {
                              if (userData.data != null) {
                                UserModel targetUser =
                                    userData.data as UserModel;

                                return ListTile(
                                  tileColor: chatRoomModel.newMessageAvailable! ? const Color(0xFFF2AE3B).withOpacity(0.25) : Colors.transparent,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return ChatRoomPage(
                                          chatroom: chatRoomModel,
                                          firebaseUser: widget.firebaseUser,
                                          userModel: widget.userModel,
                                          targetUser: targetUser,
                                        );
                                      }),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/photo.png".toString()),
                                  ),
                                  title: Text(targetUser.name.toString()),
                                  subtitle: (chatRoomModel.lastMessage
                                              .toString() !=
                                          "")
                                      ? Text(
                                          chatRoomModel.lastMessage.toString())
                                      : Text(
                                          "Say hi to your new friend!",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(
                      child: Text("No Chats"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFF2AE3B),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SearchPage(
                  userModel: widget.userModel,
                  firebaseUser: widget.firebaseUser);
            }));
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}
