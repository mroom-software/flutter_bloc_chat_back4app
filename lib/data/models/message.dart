
import 'package:parse_server_sdk/parse_server_sdk.dart';

const String _keyTableName = 'Messages';
const String keyMessage = 'message';
const String keyUser = 'user';

class Message extends ParseObject implements ParseCloneable {

  Message() : super(_keyTableName);
  Message.clone(): this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override clone(Map map) => Message.clone()..fromJson(map);
  
  String get message => get<String>(keyMessage);
  set message(String message) => set<String>(keyMessage, message);

  ParseUser get user => get<ParseUser>(keyUser);
  set user(ParseUser user) => set<ParseUser>(keyUser, user);
}