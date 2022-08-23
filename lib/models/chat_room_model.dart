class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastMessage;
  bool? newMessageAvailable;

  ChatRoomModel({this.chatroomid, this.participants, this.lastMessage, this.newMessageAvailable});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map["chatroomid"];
    participants = map["participants"];
    lastMessage = map["lastmessage"];
    newMessageAvailable = map ['newMessageAvailable'];

  }

  Map<String, dynamic> toMap() {
    return {
      "chatroomid": chatroomid,
      "participants": participants,
      "lastmessage": lastMessage,
      'newMessageAvailable' : newMessageAvailable
    };
  }
}
