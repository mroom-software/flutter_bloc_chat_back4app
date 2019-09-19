
import 'package:meta/meta.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class BaseUserRepository {
  Future<ParseUser> authenticate({@required String username, @required String email, @required String password,});
  Future<ParseUser> signup({@required String username, @required String email, @required String password, });
  Future<ParseUser> currentUser();
  Future<bool> logout();
}

class UserRepository extends BaseUserRepository {
  
  UserRepository();

  /// Auth [email], [password]
  /// 
  /// Return [ParseUser]
  Future<ParseUser> authenticate({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    var user = ParseUser(username, password, email);
    var response = await user.login();
    if (response.success)
      return response.result;
    return null;
  }

  /// Signup [username], [email], [password]
  /// 
  /// Return [ParseUser]
  Future<ParseUser> signup({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    var user = ParseUser(username, password, email);
    var result = await user.save();
    if (result.success) {
      return user;
    }
    return null;
  }

  /// Select current [ParseUser].
  ///
  Future<ParseUser> currentUser() async {
    return await ParseUser.currentUser();
  }

  Future<bool> logout() async {
    ParseUser user = await ParseUser.currentUser();
    var result = await user.logout();
    return result.success;
  }

}