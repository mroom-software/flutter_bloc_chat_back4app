import 'dart:async';
import 'package:flutter_bloc_back4app/repositories/user_repos.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';


class MockUserRepository extends BaseUserRepository {
  ParseUser user;
  bool isLogout;

  MockUserRepository();

  @override
  Future<ParseUser> authenticate({String username, String email, String password}) {
    var completer = new Completer<ParseUser>();

    // At some time you need to complete the future:
    completer.complete(user);
    return completer.future;
  }

  @override
  Future<ParseUser> currentUser() {
    var completer = new Completer<ParseUser>();

    // At some time you need to complete the future:
    completer.complete(user);
    return completer.future;
  }

  @override
  Future<bool> logout() {
    var completer = new Completer<bool>();

    // At some time you need to complete the future:
    completer.complete(isLogout);
    return completer.future;
  }

  @override
  Future<ParseUser> signup({String username, String email, String password}) {
    var completer = new Completer<ParseUser>();

    // At some time you need to complete the future:
    completer.complete(user);
    return completer.future;
  }

}