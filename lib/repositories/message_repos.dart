
import 'package:flutter_bloc_back4app/data/models/message.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class MessageRepository {
  
  MessageRepository();

  Future<List> loadAllMessages() async {
    var apiResponse = await Message().getAll();

    List<Message> lst = new List();
    if (apiResponse.success && apiResponse.result != null) {
      for (Message m in apiResponse.result) {
        lst.add(m);
      }
    }

    return lst;
  }

  Future<bool> sendMessage({String message}) async {
    var m = Message()
              ..set('message', message)
              ..set('user', await ParseUser.currentUser());
    var apiResponse = await m.save();
    return apiResponse.success;
  }

}