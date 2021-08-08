import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UnivercitiesFirebaseUser {
  UnivercitiesFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

UnivercitiesFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<UnivercitiesFirebaseUser> univercitiesFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<UnivercitiesFirebaseUser>(
            (user) => currentUser = UnivercitiesFirebaseUser(user));
