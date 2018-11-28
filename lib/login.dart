import 'dart:async';

import './home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();
final FacebookLogin _facebookSignIn = new FacebookLogin();
class LoginPage extends StatefulWidget {
  final List<Map<dynamic, dynamic>> fetchedProductList;
  final List<Map<dynamic, dynamic>> fetchListingId;
  String userName;
  LoginPage(this.fetchedProductList, this.fetchListingId, this.userName);
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GoogleSignInAccount _currentUser;
  String _contactText;
  @override
  void initState() {
    super.initState();
  }

Future<Null> _fsignIn(BuildContext context) async {
    final FacebookLoginResult result =
        await _facebookSignIn.logInWithReadPermissions(['email']);

    FirebaseUser user = await _auth
        .signInWithFacebook(accessToken: result.accessToken.token)
        .then((result) {
      print("??????????????????????? SUCCESS??????????????????????");
      print(result.email);
      print(result.displayName);

     
    }).catchError((error) {
      print("??????????????????????? FAILED??????????????????????");
      //print(error);
    });

    //return user;
  }
  Future<FirebaseUser> _gSignin() async {
    print("*******************************************");
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    String s1 = user.photoUrl;
    print("Photo Url: ${s1}");
    print("User is: ${user.displayName}");
    
    // Navigator.pushNamed(context, '/');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
            widget.fetchedProductList, widget.fetchListingId, user.displayName,s1,user.email),
      ),
    );
    return user;
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
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
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.white,
                        onPressed: () => _gSignin(),
                        child: new Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "Login With Gmail",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),
                                ),
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
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:convert' show json;

// import "package:http/http.dart" as http;
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// GoogleSignIn _googleSignIn = new GoogleSignIn(
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

// class LoginPage extends StatefulWidget {
//   @override
//   State createState() => new LoginPageState();
// }

// class LoginPageState extends State<LoginPage> {
//   GoogleSignInAccount _currentUser;
//   String _contactText;

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact();
//       }
//     });
//     _googleSignIn.signInSilently();
//   }

//   Future<Null> _handleGetContact() async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//     final http.Response response = await http.get(
//       'https://people.googleapis.com/v1/people/me/connections'
//           '?requestMask.includeField=person.names',
//       headers: await _currentUser.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = "People API gave a ${response.statusCode} "
//             "response. Check logs for details.";
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = "I see you know $namedContact!";
//       } else {
//         _contactText = "No contacts to display.";
//       }
//     });
//   }

//   String _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic> connections = data['connections'];
//     final Map<String, dynamic> contact = connections?.firstWhere(
//       (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     );
//     if (contact != null) {
//       final Map<String, dynamic> name = contact['names'].firstWhere(
//         (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       );
//       if (name != null) {
//         return name['displayName'];
//       }
//     }
//     return null;
//   }

//   Future<Null> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<Null> _handleSignOut() async {
//     _googleSignIn.disconnect();
//   }

//   Widget _buildBody() {
//     if (_currentUser != null) {
//       return new Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           new ListTile(
//             leading: new GoogleUserCircleAvatar(
//               identity: _currentUser,
//             ),
//             title: new Text(_currentUser.displayName),
//             subtitle: new Text(_currentUser.email),
//           ),
//           const Text("Signed in successfully."),
//           new Text(_contactText),
//           new RaisedButton(
//             child: const Text('SIGN OUT'),
//             onPressed: _handleSignOut,
//           ),
//           new RaisedButton(
//             child: const Text('REFRESH'),
//             onPressed: _handleGetContact,
//           ),
//         ],
//       );
//     } else {
//       return new Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text("You are not currently signed in."),
//           new RaisedButton(
//             child: const Text('SIGN IN'),
//             onPressed: _handleSignIn,
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: new ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }
