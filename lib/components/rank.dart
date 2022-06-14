import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_app/components/action_box.dart';
import 'package:my_quiz_app/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';

class RankAuth extends StatefulWidget {
  const RankAuth({Key? key}) : super(key: key);

  @override
  State<RankAuth> createState() => _RankAuthState();
}

class _RankAuthState extends State<RankAuth> {
  bool _isloggedIn = false;
  @override
  Widget build(BuildContext context) {
    if (_isloggedIn)
      return ActionButton(
        title: 'Ranking',
        onTap: () {},
      );
    return ActionButton(
      isPrimary: false,
      title: 'Sign in with Google',
      onTap: () {
        AuthService.signInWithGoogle();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        setState(() {
          _isloggedIn = false;
        });
        return;
      }
      setState(() {
        _isloggedIn = true;
      });
    });
  }
}
