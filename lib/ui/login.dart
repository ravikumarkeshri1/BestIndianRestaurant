// import 'dart:async';

// import './listview_note.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// //import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_twitter_login/flutter_twitter_login.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = new GoogleSignIn();
// final FacebookLogin _facebookSignIn = new FacebookLogin();
// class LoginPage extends StatefulWidget {
//   LoginPage();
//   @override
//   State createState() => new LoginPageState();
// }

// class LoginPageState extends State<LoginPage> {
//   GoogleSignInAccount _currentUser;
//   String _contactText;
//   @override
//   void initState() {
//     super.initState();
//   }

//   static final TwitterLogin twitterLogin = new TwitterLogin(
//     consumerKey: 'aLndcCeul8WTHOgFdOtUuEKBi',
//     consumerSecret: 'EvJz9EKZLWj1cSKCr9anDlDefCf5ijRl76Sjihdeubn9aDcG6Y',
//   );
//   Future<Null> _fsignIn(BuildContext context) async {
//     print("--------------------------- call fsignin----------------");
//     final FacebookLoginResult result =
//         await _facebookSignIn.logInWithReadPermissions(['email']);

// print("-------------------------- Access Token --------------------");
//         print(result.accessToken.token);
//         print(result.accessToken);

//     FirebaseUser user = await _auth
//         .signInWithFacebook(accessToken: result.accessToken.token)
//         .then((result) {
//       print("??????????????????????? SUCCESS??????????????????????");
//       print(result.email);
//       print(result.displayName);
//     }).catchError((error) {
//       print("??????????????????????? FAILED??????????????????????");
//       print(error);
//     });
//   }

//   Future<FirebaseUser> _gSignin() async {
//     print("*******************************************");
//     GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//     GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;

//     FirebaseUser user = await _auth.signInWithGoogle(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken);
//     String s1 = user.photoUrl;
//     print("Photo Url: ${s1}");
//     print("User is: ${user.displayName}");
//     // final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.setString('token', googleSignInAuthentication.idToken);
//     // prefs.setString('userName', user.displayName);
//     // prefs.setString('currentImage', user.photoUrl);

//     // Navigator.pushNamed(context, '/');
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) =>
//             ListViewNote(user.displayName, user.photoUrl),
//       ),
//     );
//     return user;
//   }

// Future<Null> _tSignin(BuildContext context) async {
//   try {
//       final TwitterLoginResult result = await twitterLogin.authorize();
// print("-----------------------  ${result.errorMessage}");

//      // print("$user");
//  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${result.status}");
//  print(result.session.token);
//  print(result.session.secret);
//  print(result.session.username);
 
//       switch (result.status) {
       
//         case TwitterLoginStatus.loggedIn:
        
//         // FirebaseAuth.instance.signInWithTwitter(
//         //   authToken: result.session.token,
//         //   authTokenSecret: result.session.secret
//         // ).then((signedInUser){
//         //     print(">>>>>>>>>>>>>>>>>>>signedInUser>>>>>>>>>>>>>");
//         // }).catchError((onError){
//         //   print(">>>>>>>>>>>>>>>>>>>> login error>>>>>>>>>>>>>>>>>$onError");
//         // });
//           FirebaseUser user = await _auth.signInWithTwitter(
//               authToken: result.session.token,
//               authTokenSecret: result.session.secret);
//              print(">>>>>>>>>>>>>>>>>user>>>>>>>>>>>>>>>$user");
          
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (BuildContext context) =>
//                   ListViewNote(user.displayName, user.photoUrl),
//             ),
//           );

//           break;
//         case TwitterLoginStatus.cancelledByUser:
          
//           // Navigator.pushReplacement(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (BuildContext context) => ListViewNote('', '', ''),
//           //   ),
//           // );
//           break;
//         case TwitterLoginStatus.error:
         
//           // Navigator.pushReplacement(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (BuildContext context) => ListViewNote('', '', ''),
//           //   ),
//           // );
//           break;
//       }
//     } catch (error) {
    
//       print("**********************3********************* $error");
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (BuildContext context) => ListViewNote('', '', ''),
//       //   ),
//       // );
//     }

// }
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             //color: Colors.redAccent,
//             image: DecorationImage(
//               colorFilter: new ColorFilter.mode(
//                   Colors.black.withOpacity(0.2), BlendMode.dstOver),
//               image: AssetImage('assets/food.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: new Column(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.only(top: 150.0),
//                 child: Center(
//                   child: Image.asset(
//                     'assets/logo.png',
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               new Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin:
//                     const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
//                 alignment: Alignment.center,
//                 child: new Row(
//                   children: <Widget>[
//                     new Expanded(
//                       child: new FlatButton(
//                         shape: new RoundedRectangleBorder(
//                             side: BorderSide(
//                                 width: 0.5,
//                                 color: Color.fromARGB(255, 218, 56, 46)),
//                             borderRadius: new BorderRadius.circular(30.0)),
//                         color: Color.fromARGB(255, 218, 56, 46),
//                         onPressed: () => _gSignin(),
//                         child: new Container(
//                           // padding: const EdgeInsets.symmetric(
//                           //   vertical: 20.0,
//                           //   horizontal: 20.0,
//                           // ),
//                           child: new Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               IconButton(
//                                 icon: Icon(MdiIcons.gmail),
//                                 onPressed: () {
//                                   _gSignin();
//                                 },
//                                 color: Colors.white,
//                               ),
//                               Text(
//                                 "Login With Gmail",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               new Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin:
//                     const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
//                 alignment: Alignment.center,
//                 child: new Row(
//                   children: <Widget>[
//                     new Expanded(
//                       child: new FlatButton(
//                         shape: new RoundedRectangleBorder(
//                             side: BorderSide(
//                                 width: 0.5,
//                                 color: Color.fromARGB(255, 50, 88, 145)),
//                             borderRadius: new BorderRadius.circular(30.0)),
//                         color: Color.fromARGB(255, 50, 88, 145),
//                         onPressed: () => _fsignIn(context),
                      
//                         child: new Container(
//                           // padding: const EdgeInsets.symmetric(
//                           //   vertical: 20.0,
//                           //   horizontal: 20.0,
//                           // ),
//                           child: new Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               IconButton(
//                                 icon: Icon(MdiIcons.facebook),
//                                 onPressed: () {
//                                   _fsignIn(context);
//                                 },
//                                 color: Colors.white,
//                               ),
//                               Text(
//                                 "Login With Facebook",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//              new Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: const EdgeInsets.only(
//                           left: 40.0, right: 40.0, top: 30.0),
//                       alignment: Alignment.center,
//                       child: new Row(
//                         children: <Widget>[
//                           new Expanded(
//                             child: new FlatButton(
//                               shape: new RoundedRectangleBorder(
//                                   side: BorderSide(
//                                       width: 0.5,
//                                       color: Color.fromARGB(255, 0, 155, 238)),
//                                   borderRadius:
//                                       new BorderRadius.circular(30.0)),
//                               color: Color.fromARGB(255, 0, 155, 238),
//                               onPressed: () => _tSignin(context),
//                               child: new Container(
//                                 // padding: const EdgeInsets.symmetric(
//                                 //   vertical: 20.0,
//                                 //   horizontal: 20.0,
//                                 // ),
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     IconButton(
//                                       icon: Icon(MdiIcons.twitter),
//                                       onPressed: () {
//                                         _tSignin(context);
//                                       },
//                                       color: Colors.white,
//                                     ),
//                                     Text(
//                                       "Login With Twitter",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';

import './listview_note.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:firebase_admob/firebase_admob.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

///facebook signin
final FacebookLogin _facebookSignIn = new FacebookLogin();

//end
class LoginPage extends StatefulWidget {
  LoginPage();
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // static final TwitterLogin twitterLogin = new TwitterLogin(
  //   consumerKey: 'E5OWWZnn5COugITejON4vbM75',
  //   consumerSecret: 'xYoulhEyEDS1SSaSCl4MoRbRNJ5KUJrReoYfIMTx8GAHMwpJOV',
  // );

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: 'aLndcCeul8WTHOgFdOtUuEKBi',
    consumerSecret: 'EvJz9EKZLWj1cSKCr9anDlDefCf5ijRl76Sjihdeubn9aDcG6Y',
  );

//  GoogleSignInAccount _currentUser;
  String loginStatus = "notLoggedIn";

  AuthStatus auth = AuthStatus.notSignedIn;
  Auth authstatus = new Auth();

  // String _contactText;

 // BannerAd _bannerAd;
  //InterstitialAd _interstitialAd;
  int _coins = 0;

  

  @override
  void initState() {
    super.initState();


    authstatus.userStatus().then((value) {
      setState(() {
        auth = value == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return user.uid;
  }

  Future<bool> userStatus() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print("current user ${user.displayName}");

    if (user != null) {
      return true;
    } else
      return false;
  }

  //Future<bool> statusUser = userStatus();

  static bool _LoginButton = true;
  Future<Null> _gSignin() async {
    if (_LoginButton == true) {
      setState(() {
        _LoginButton = false;
      });
    }

    print("***********************1******************** $_LoginButton");
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      FirebaseUser user = await _auth.signInWithGoogle(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

        String s1 = user.photoUrl;
       print("Photo Url: $s1");
       print("User is>>>>>>>>>>>>>>>>>>>>: ${user.displayName}");
      setState(() {
        _LoginButton = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ListViewNote(user.displayName, user.photoUrl),
        ),
      );
    } catch (error) {
      setState(() {
        _LoginButton = true;
      });
      print("************************2******************* $error");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => ListViewNote('', '', ''),
      //   ),
      // );
    }
    //return user;
  }

  Future<Null> _tSignin(BuildContext context) async {
    if (_LoginButton == true) {
      setState(() {
        _LoginButton = false;
      });
    } //twitter login
    try {
      final TwitterLoginResult result = await twitterLogin.authorize();
print("-----------------------  ${result.errorMessage}");

     // print("$user");
 print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${result.status}");
 print(result.session.token);
 print(result.session.secret);
 print(result.session.username);
 
      switch (result.status) {
       
        case TwitterLoginStatus.loggedIn:
        
        // FirebaseAuth.instance.signInWithTwitter(
        //   authToken: result.session.token,
        //   authTokenSecret: result.session.secret
        // ).then((signedInUser){
        //     print(">>>>>>>>>>>>>>>>>>>signedInUser>>>>>>>>>>>>>");
        // }).catchError((onError){
        //   print(">>>>>>>>>>>>>>>>>>>> login error>>>>>>>>>>>>>>>>>$onError");
        // });
          FirebaseUser user = await _auth.signInWithTwitter(
              authToken: result.session.token,
              authTokenSecret: result.session.secret);
             print(">>>>>>>>>>>>>>>>>user>>>>>>>>>>>>>>>$user");
          setState(() {
            _LoginButton = true;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ListViewNote(user.displayName, user.photoUrl),
            ),
          );

          break;
        case TwitterLoginStatus.cancelledByUser:
          setState(() {
            _LoginButton = true;
          });
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => ListViewNote('', '', ''),
          //   ),
          // );
          break;
        case TwitterLoginStatus.error:
          setState(() {
            _LoginButton = true;
          });
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => ListViewNote('', '', ''),
          //   ),
          // );
          break;
      }
    } catch (error) {
      setState(() {
        _LoginButton = true;
      });
      print("**********************3********************* $error");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => ListViewNote('', '', ''),
      //   ),
      // );
    }
  }

  Future<Null> _fsignIn(BuildContext context) async {
    print("-----------------------------FMessage 1----------------------------");
    if (_LoginButton == true) {
      print("-----------------------------FMessage 2----------------------------");
      setState(() {
        _LoginButton = false;
        print("-----------------------------FMessage 3----------------------------");
      });
    }
    print("-----------------------------FMessage 4----------------------------");
    try {
      print("-----------------------------FMessage 5----------------------------");
     final FacebookLoginResult result =
        await _facebookSignIn.logInWithReadPermissions(['email']);
print("-----------------------------FMessage 6----------------------------");
print(result.status);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          //final FacebookAccessToken accessToken = result.accessToken;

          FirebaseUser user = await _auth.signInWithFacebook(
              accessToken: result.accessToken.token);
print("---------------------------------------------------------------------------");
print(user.displayName);
print(user.email);
print("---------------------------------------------------------------------------");
          setState(() {
            _LoginButton = true;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ListViewNote(user.displayName, user.photoUrl),
            ),
          );
          break;
        case FacebookLoginStatus.cancelledByUser:
          setState(() {
            _LoginButton = true;
          });

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => ListViewNote('', '', ''),
          //   ),
          // );
          break;
        case FacebookLoginStatus.error:
          setState(() {
            _LoginButton = true;
          });

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => ListViewNote('', '', ''),
          //   ),
          // );
          break;
      }

      //return user;
    } catch (error) {
      setState(() {
        _LoginButton = true;
      });
      print("***********************4******************** $error");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => ListViewNote('', '', ''),
      //   ),
      // );
    }
  }

  bool _loginButtonBool() {
    return _LoginButton;
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loginButtonBool()
          ? Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  //color: Colors.redAccent,
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstOver),
                    image: AssetImage('assets/food.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 150.0),
                      child: Center(
                        child: Image.asset(
                          'assets/logo.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 30.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 218, 56, 46)),
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Color.fromARGB(255, 218, 56, 46),
                              onPressed: () => _gSignin(),
                              child: new Container(
                                // padding: const EdgeInsets.symmetric(
                                //   vertical: 20.0,
                                //   horizontal: 20.0,
                                // ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(MdiIcons.gmail),
                                      onPressed: () {
                                        _gSignin();
                                      },
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Login With Gmail",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 30.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 50, 88, 145)),
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Color.fromARGB(255, 50, 88, 145),
                              onPressed: () => _fsignIn(context),
                              // onPressed: () {
                              //   return showDialog<Null>(
                              //     context: context,
                              //     barrierDismissible: false, // user must tap button!
                              //     builder: (BuildContext context) {
                              //       return new AlertDialog(
                              //         title: new Text('Oops!! Sorry'),
                              //         content: new SingleChildScrollView(
                              //           child: new ListBody(
                              //             children: <Widget>[
                              //               new Text('Facebook login is under'),
                              //               new Text(
                              //                   'development'),
                              //             ],
                              //           ),
                              //         ),
                              //         actions: <Widget>[
                              //           new FlatButton(
                              //             child: new Text('That\'s OK'),
                              //             onPressed: () {
                              //               Navigator.of(context).pop();
                              //             },
                              //           ),
                              //         ],
                              //       );
                              //     },
                              //   );
                              // },
                              child: new Container(
                                // padding: const EdgeInsets.symmetric(
                                //   vertical: 20.0,
                                //   horizontal: 20.0,
                                // ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(MdiIcons.facebook),
                                      onPressed: () {
                                        _fsignIn(context);
                                      },
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Login With Facebook",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 30.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 0, 155, 238)),
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Color.fromARGB(255, 0, 155, 238),
                              onPressed: () => _tSignin(context),
                              child: new Container(
                                // padding: const EdgeInsets.symmetric(
                                //   vertical: 20.0,
                                //   horizontal: 20.0,
                                // ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(MdiIcons.twitter),
                                      onPressed: () {
                                        _tSignin(context);
                                      },
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Login With Twitter",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.greenAccent.withOpacity(0.01),
              ),
            ),
    );
  }
}

class UserInfoDetails {
  UserInfoDetails(this.providerId, this.uid, this.displayName, this.photoUrl,
      this.email, this.isAnonymous, this.isEmailVerified, this.providerData);

  /// The provider identifier.
  final String providerId;

  /// The provider’s user ID for the user.
  final String uid;

  /// The name of the user.
  final String displayName;

  /// The URL of the user’s profile photo.
  final String photoUrl;

  /// The user’s email address.
  final String email;

  // Check anonymous
  final bool isAnonymous;

  //Check if email is verified
  final bool isEmailVerified;

  //Provider Data
  final List<ProviderDetails> providerData;
}

class ProviderDetails {
  final String providerId;

  final String uid;

  final String displayName;

  final String photoUrl;

  final String email;

  ProviderDetails(
      this.providerId, this.uid, this.displayName, this.photoUrl, this.email);
}
