import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn gSignIn = GoogleSignIn();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    gSignIn.onCurrentUserChanged.listen((event) {
      handleSignIn(event);
      print(event);
    }, onError: (gError) {
      print('Error Message in 1st Stage : $gError');
    });

    gSignIn
        .signInSilently(suppressErrors: false)
        .then((value) => {handleSignIn(value!)})
        .catchError((gError) {
      print('Error Message 2nd Stage: $gError');
    });
  }

  handleSignIn(GoogleSignInAccount? signInAccount) async {
    if (signInAccount != null) {
      setState(
        () {
          isSignedIn = true;
        },
      );
      print(isSignedIn);
    } else {
      setState(
        () {
          isSignedIn = false;
        },
      );
      print(isSignedIn);
    }
  }

  loginUser() {
    gSignIn.signIn();
  }

  logoutUser() {
    gSignIn.signOut();
  }

  Widget buildHomeScreen() {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: logoutUser,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
          Text(
            'Hello ${gSignIn.currentUser!.displayName}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ],
      )),
    );
  }

  Widget buildSignInScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).hintColor
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "BuddiesGram",
              style: TextStyle(
                fontSize: 90,
                color: Colors.white,
                fontFamily: "Signatra",
              ),
            ),
            GestureDetector(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildSignInScreen();
    }
  }
}
