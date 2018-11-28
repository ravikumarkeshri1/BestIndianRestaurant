// import 'dart:async';
// import 'package:firebase_database/firebase_database.dart';
// import './login.dart';
// import 'package:flutter/material.dart';
// import '../model/review.dart';
// import '../model/note.dart';
// import './note_screen.dart';
// import './listing_details.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:splashscreen/splashscreen.dart';
// import './listing_by_query.dart';
// //import 'package:shared_preferences/shared_preferences.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = new GoogleSignIn();

// class HomePage extends StatelessWidget {
//   String userName, currentImage;
//   HomePage(this.userName, this.currentImage);

//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       seconds: 5,
//       navigateAfterSeconds: new ListViewNote(userName, currentImage),
//       title: new Text(
//         '',
//       ),
//       image: new Image.asset('assets/logo.png'),
//       backgroundColor: Colors.white,
//       // styleTextUnderTheLoader: new TextStyle(),
//       photoSize: 160.0,
//       // onClick: () => print("Flutter Egypt"),
//       // loaderColor: Colors.red,
//     );
//   }
// }

// class ListViewNote extends StatefulWidget {
//   String userName, currentImage;
//   ListViewNote(this.userName, this.currentImage);

//   @override
//   _ListViewNoteState createState() => new _ListViewNoteState();
// }

// final recentlyReference = FirebaseDatabase.instance
//     .reference()
//     .child('myRestaurantListing')
//     .limitToLast(10);

// final notesReference = FirebaseDatabase.instance
//     .reference()
//     .child('myRestaurantListing')
//     .orderByChild('overAllRating');

// final reviewReference = FirebaseDatabase.instance
//     .reference()
//     .child('myReviews')
//     .orderByChild('overAllRating');

// class _ListViewNoteState extends State<ListViewNote> {
//   List<Note> items;
//   List<Note> recentlyItems;
//   List<Review> reviewItems;

//   StreamSubscription<Event> _onNoteAddedSubscription;
//   StreamSubscription<Event> _onNoteChangedSubscription;
//   StreamSubscription<Event> _onReviewAddedSubscription;

//   @override
//   void initState() {
//     super.initState();
//     getToken();
//     print("AAAAAAAAAAAAAAAAAa");
//     items = new List();
//     recentlyItems = new List();
//     reviewItems = new List();
//     _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);
//     _onNoteChangedSubscription = _onNoteAddedSubscription =
//         recentlyReference.onChildAdded.listen(_onRecentlyListAdded);
//     _onNoteChangedSubscription =
//         notesReference.onChildChanged.listen(_onNoteUpdated);
//     _onReviewAddedSubscription =
//         reviewReference.onChildAdded.listen(_onReviewAdded);
//   }

//   @override
//   void dispose() {
//     _onNoteAddedSubscription.cancel();
//     _onNoteChangedSubscription.cancel();
//     _onReviewAddedSubscription.cancel();
//     super.dispose();
//   }

//   void getToken() async {
//     // final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // final String token = prefs.getString('token');
//     // if (token != null) {
//     //   setState(() {
//     //     widget.userName = prefs.getString('userName');
//     //     widget.currentImage = prefs.getString('currentImage');
//     //   });
//     // }
//   }

//   Future<Null> _handleSignOut(BuildContext context) async {
//     _googleSignIn.signOut();
//     // final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.remove('token');
//     // prefs.remove('userName');
//     // prefs.remove('currentImage');

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => ListViewNote('Sign In', ''),
//       ),
//     );
//   }

//   Widget _buildAddRestaurant(BuildContext context) {
//     getToken();
//     if (widget.userName == 'Sign In' ||
//         widget.userName == null ||
//         widget.userName.isEmpty) {
//       return SizedBox();
//     } else {
//       return ListTile(
//         title: Text('Add Restaurant'),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => NoteScreen(
//                     Note(null, '', '', '', 0.0, 0.0, 0.0, 0.0, 0, '', 0),
//                     widget.userName,
//                     widget.currentImage)),
//           );
//         },
//       );
//     }
//   }

//   _buildMyRestaurant(BuildContext context) {
//     getToken();
//     if (widget.userName == 'Sign In' ||
//         widget.userName == null ||
//         widget.userName.isEmpty) {
//       return SizedBox();
//     } else {
//       return ListTile(
//           title: Text('My Restaurant'),
//           onTap: () {
//               List itemsRev = [];

//                 int j = items.length;

//                 for (int i = j - 1; i >= 0; i--) {
//                   if (items[i].status == 1) {
//                     itemsRev.add(items[i]);
//                   }
//                 }
//             List myReview = [];
//             itemsRev.forEach((doc) {
//               if (doc.userName.toUpperCase() == widget.userName.toUpperCase()) {
//                 myReview.add(doc);
//               }
//             });
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ListingManagerByQuery(myReview,
//                       widget.userName, widget.currentImage, 'My Restaurant')),
//             );
//           });
//     }
//   }

//   _buildMyReviews(BuildContext context) {
//     getToken();
//     if (widget.userName == 'Sign In' ||
//         widget.userName == null ||
//         widget.userName.isEmpty) {
//       return SizedBox();
//     } else {
//       return ListTile(title: Text('My Reviews'), onTap: () {});
//     }
//   }

//   _buildDivider(BuildContext context) {
//     getToken();
//     if (widget.userName == 'Sign In' ||
//         widget.userName == null ||
//         widget.userName.isEmpty) {
//       return SizedBox();
//     } else {
//       return Divider(
//         color: Colors.deepOrange,
//       );
//     }
//   }

//   _buildSignInLogo(BuildContext context) {
//     getToken();
//     if (widget.userName == 'Sign In' ||
//         widget.userName == null ||
//         widget.userName.isEmpty) {
//       return ListTile(
//         leading: Icon(Icons.account_circle),
//         title: Text('Sign In'),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => LoginPage()),
//           );
//         },
//       );
//     } else {
//       return ListTile(
//         leading: CircleAvatar(
//           backgroundImage: NetworkImage(widget.currentImage),
//         ),
//         title: Text(widget.userName),
//       );
//     }
//   }

//   Widget _buildSideDrawer(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: <Widget>[
//           AppBar(
//             automaticallyImplyLeading: false,
//             title: Image.asset('assets/logo1.png'),
//           ),
//           _buildSignInLogo(context),
//           Divider(
//             color: Colors.deepOrange,
//           ),
//           _buildAddRestaurant(context),
//           //_buildMyReviews(context),
//           _buildMyRestaurant(context),
//           _buildDivider(context),
//           ListTile(
//               title: Text('Top Restaurants in India'),
//               onTap: () {
//                   List itemsRev = [];

//                 int j = items.length;

//                 for (int i = j - 1; i >= 0; i--) {
//                   if (items[i].status == 1) {
//                     itemsRev.add(items[i]);
//                   }
//                 }
//                 List indianItems = [];
//                 itemsRev.forEach((doc) {
//                   if (doc.country.toUpperCase() == 'INDIA') {
//                     indianItems.add(doc);
//                   }
//                 });
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ListingManagerByQuery(indianItems,
//                           widget.userName, widget.currentImage, 'India')),
//                 );
//               }),
//           ListTile(
//               title: Text('Top Restaurants in Australia'),
//               onTap: () {
//                  List itemsRev = [];

//                 int j = items.length;

//                 for (int i = j - 1; i >= 0; i--) {
//                   if (items[i].status == 1) {
//                     itemsRev.add(items[i]);
//                   }
//                 }
//                 List australianItems = [];
//                 itemsRev.forEach((doc) {
//                   if (doc.country.toUpperCase() == 'AUSTRALIA') {
//                     australianItems.add(doc);
//                   }
//                 });
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ListingManagerByQuery(
//                           australianItems,
//                           widget.userName,
//                           widget.currentImage,
//                           'Australia')),
//                 );
//               }),
//           ListTile(
//               title: Text('Top Restaurants in UAE'),
//               onTap: () {
//                  List itemsRev = [];

//                 int j = items.length;

//                 for (int i = j - 1; i >= 0; i--) {
//                   if (items[i].status == 1) {
//                     itemsRev.add(items[i]);
//                   }
//                 }
//                 List dubaiItems = [];
//                 itemsRev.forEach((doc) {
//                   if (doc.country.toUpperCase() == 'UAE') {
//                     dubaiItems.add(doc);
//                   }
//                 });
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ListingManagerByQuery(dubaiItems,
//                           widget.userName, widget.currentImage, 'UAE')),
//                 );
//               }),
//           ListTile(
//               title: Text('Top Restaurants in USA'),
//               onTap: () {
//                  List itemsRev = [];

//                 int j = items.length;

//                 for (int i = j - 1; i >= 0; i--) {
//                   if (items[i].status == 1) {
//                     itemsRev.add(items[i]);
//                   }
//                 }
//                 List usaItems = [];

//                 itemsRev.forEach((doc) {
//                   if (doc.country.toUpperCase() == 'USA') {
//                     usaItems.add(doc);
//                   }
//                 });
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ListingManagerByQuery(usaItems,
//                           widget.userName, widget.currentImage, 'USA')),
//                 );
//               }),
//           Divider(
//             color: Colors.deepOrange,
//           ),
//           FlatButton(
//             child: Text(widget.userName == null ||
//                     widget.userName == 'Sign In' ||
//                     widget.userName.isEmpty
//                 ? ''
//                 : 'Logout'),
//             onPressed: () => _handleSignOut(context),
//           ),
//         ],
//       ),
//     );
//   }

//   // Icon actionIcon = new Icon(Icons.search);
//   Widget appBarTitle = new Text("Best Indian Restaurant");
//   @override
//   Widget build(BuildContext context) {
//     List itemsRev = [];

//     int j = items.length;

//     for (int i = j - 1; i >= 0; i--) {
//       if (items[i].status == 1) {
//         itemsRev.add(items[i]);
//       }
//     }

//     List recentlyitemsRev = [];
//     j = recentlyItems.length;
//     for (int i = j - 1; i >= 0; i--) {
//       if (recentlyItems[i].status == 1) {
//         recentlyitemsRev.add(recentlyItems[i]);
//       }
//     }
//     //print("----------------");
//     //print(itemsRev[0].overAllRating);
//     // print(itemsRev[0]['overAllRating']);
//     // for(int i=j-1;i>=0;i++){
//     //   print("-------------i------------");
//     //   print(items[i].overAllRating);
//     // }
//     //final notesReference = FirebaseDatabase.instance.reference().child('myRestaurantListing').limitToLast(2);
//     return MaterialApp(
//       title: 'Best Indian Restaurant',
//       theme: ThemeData(
//           brightness: Brightness.light,
//           primarySwatch: Colors.deepOrange,
//           accentColor: Colors.deepPurple),
//       home: Scaffold(
//           appBar: AppBar(title: appBarTitle, actions: <Widget>[
//             // new IconButton(
//             //   icon: actionIcon,
//             //   onPressed: () {
//             //     setState(() {
//             //       if (this.actionIcon.icon == Icons.search) {
//             //         this.actionIcon = new Icon(Icons.close);
//             //         this.appBarTitle = new TextField(
//             //           style: new TextStyle(
//             //             color: Colors.white,
//             //           ),
//             //           decoration: new InputDecoration(
//             //               prefixIcon:
//             //                   new Icon(Icons.search, color: Colors.white),
//             //               hintText: "Search By City",
//             //               hintStyle: new TextStyle(color: Colors.white)),
//             //         );
//             //       } else {
//             //         this.actionIcon = new Icon(Icons.search);
//             //         this.appBarTitle = new Text("Best Indian Restaurant");
//             //       }
//             //     });
//             //   },
//             // ),
//           ]),
//           drawer: _buildSideDrawer(context),
//           body: Container(
//             margin: EdgeInsets.all(10.0),
//             child: Column(children: <Widget>[
//               SizedBox(
//                 height: 10.0,
//               ),
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       "Recently Added",
//                       style: TextStyle(
//                           fontSize: 16.0, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.left,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               SizedBox(
//                 height: 160.0,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: recentlyitemsRev.length,
//                   itemBuilder: (context, position) {
//                     return GestureDetector(
//                       child: Column(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 80.0),
//                           ),
//                           // SizedBox(height: 20.0),
//                           Image(
//                             image: NetworkImage(recentlyitemsRev.length > 0
//                                 ? '${recentlyitemsRev[position].image}'
//                                 : ''),
//                             fit: BoxFit.cover,
//                             width: 150.0,
//                             height: 100.0,
//                           ),
//                           SizedBox(
//                             height: 10.0,
//                           ),
//                           Text(
//                             recentlyitemsRev.length > 0
//                                 ? '${recentlyitemsRev[position].name}'
//                                 : 'Loading...',
//                             textAlign: TextAlign.left,
//                           ),
//                           DecoratedBox(
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: recentlyitemsRev[position]
//                                                 .totalReviewUser >
//                                             0
//                                         ? Colors.deepOrange
//                                         : Colors.grey,
//                                     width: 1.0),
//                                 borderRadius: BorderRadius.circular(4.0)),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 6.0, vertical: 2.5),
//                               child: Text(
//                                   recentlyitemsRev.length > 0
//                                       ? recentlyitemsRev[position]
//                                                   .totalReviewUser >
//                                               0
//                                           ? (recentlyitemsRev[position]
//                                                       .overAllRating <=
//                                                   5
//                                               ? '${recentlyitemsRev[position].overAllRating}'
//                                               : '5.0')
//                                           : '0.0'
//                                       : '',
//                                   style: TextStyle(
//                                       color: recentlyitemsRev[position]
//                                                   .totalReviewUser >
//                                               0
//                                           ? Colors.deepOrange
//                                           : Colors.grey,
//                                       fontWeight: FontWeight.w500)),
//                             ),
//                           ),
//                         ],
//                       ),
//                       onTap: () => _navigateToNote(
//                             context,
//                             recentlyitemsRev[position],
//                             widget.userName,
//                             widget.currentImage,
//                           ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     "Top Rated",
//                     style:
//                         TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//                     textAlign: TextAlign.left,
//                   ),
//                   Text(''),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               new Expanded(
//                 child: ListView.builder(
//                     itemCount: itemsRev.length,
//                     itemBuilder: (context, position) {
//                       return Column(
//                         children: <Widget>[
//                           SizedBox(
//                             height: 10.0,
//                           ),
//                           Divider(height: 5.0),
//                           ListTile(
//                             title: Text(
//                               '${itemsRev[position].name}',
//                             ),
//                             subtitle: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                     '${itemsRev[position].city}, ${itemsRev[position].country}'),
//                                 DecoratedBox(
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: itemsRev[position]
//                                                       .totalReviewUser >
//                                                   0
//                                               ? Colors.deepOrange
//                                               : Colors.grey,
//                                           width: 1.0),
//                                       borderRadius: BorderRadius.circular(4.0)),
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 6.0, vertical: 2.5),
//                                     child: Text(
//                                       itemsRev[position].totalReviewUser > 0
//                                           ? (itemsRev[position].overAllRating <=
//                                                   5
//                                               ? '${itemsRev[position].overAllRating}'
//                                               : 5.0.toString())
//                                           : '0.0',
//                                       style: TextStyle(
//                                           color: itemsRev[position]
//                                                       .totalReviewUser >
//                                                   0
//                                               ? Colors.deepOrange
//                                               : Colors.grey,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             // subtitle: Text(
//                             //   '${items[position].description}',
//                             //   style: new TextStyle(
//                             //     fontSize: 18.0,
//                             //     fontStyle: FontStyle.italic,
//                             //   ),
//                             // ),

//                             leading: Container(
//                               width: 100.0,
//                               height: 80.0,
//                               decoration: new BoxDecoration(
//                                 color: const Color(0xff7c94b6),
//                                 image: new DecorationImage(
//                                   image: new NetworkImage(
//                                       '${itemsRev[position].image}'),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: new BorderRadius.all(
//                                     new Radius.circular(6.0)),
//                               ),
//                             ),
//                             onTap: () => _navigateToNote(
//                                 context,
//                                 itemsRev[position],
//                                 widget.userName,
//                                 widget.currentImage),
//                           ),
//                         ],
//                       );
//                     }),
//               ),
//             ]),
//           ) // floatingActionButton: FloatingActionButton(
//           //   child: Icon(Icons.add),
//           //   onPressed: () => _createNewNote(context),
//           // ),
//           ),
//     );
//   }

//   void _onNoteAdded(Event event) {
//     setState(() {
//       items.add(new Note.fromSnapshot(event.snapshot));
//       items.reversed;
//     });
//   }

//   void _onRecentlyListAdded(Event event) {
//     setState(() {
    
//       recentlyItems.add(new Note.fromSnapshot(event.snapshot));
//     });
//   }

//   void _onReviewAdded(Event event) {
//     setState(() {
     
//       reviewItems.add(new Review.fromSnapshot(event.snapshot));
//     });
//   }

//   void _onNoteUpdated(Event event) {
//     var oldNoteValue =
//         items.singleWhere((note) => note.id == event.snapshot.key);
//     setState(() {
//       items[items.indexOf(oldNoteValue)] =
//           new Note.fromSnapshot(event.snapshot);
//     });
//   }

//   void _deleteNote(BuildContext context, Note note, int position) async {
//     // await notesReference.child(note.id).remove().then((_) {
//     //   setState(() {
//     //     items.removeAt(position);
//     //   });
//     // });
//   }

//   void _navigateToNote(BuildContext context, Note note, String userName,
//       String currentImage) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => ListingDetail(note, userName, currentImage)),
//     );
//   }

//   void _createNewNote(BuildContext context) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => NoteScreen(
//               Note(null, '', '', '', 0.0, 0.0, 0.0, 0.0, 0, '', 0),
//               widget.userName,
//               widget.currentImage)),
//     );
//   }
// }


import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import './login.dart';
import 'package:flutter/material.dart';
// import 'package:after_layout/after_layout.dart';
import '../model/review.dart';
import '../model/note.dart';
import './note_screen.dart';
import './listing_details.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splashscreen/splashscreen.dart';
import './listing_by_query.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import './auth.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'dart:math' as math;
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();
final FacebookLogin _facebookSignIn = new FacebookLogin();

class HomePage extends StatelessWidget {
  String userName, currentImage;
  HomePage(this.userName, this.currentImage);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new ListViewNote(userName, currentImage),
      title: new Text(
        '',
      ),
      image: new Image.asset('assets/logo.png'),
      backgroundColor: Colors.white,
      // styleTextUnderTheLoader: new TextStyle(),
      photoSize: 160.0,
      // onClick: () => print("Flutter Egypt"),
      // loaderColor: Colors.red,
    );
  }
}

class ListViewNote extends StatefulWidget {
  String userName, currentImage, userEmail;
  ListViewNote(this.userName, this.currentImage);

  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}

final recentlyReference = FirebaseDatabase.instance
    .reference()
    .child('myRestaurantListing')
    .limitToLast(10);

final notesReference = FirebaseDatabase.instance
    .reference()
    .child('myRestaurantListing')
    .orderByChild('overAllRating');

final reviewReference = FirebaseDatabase.instance
    .reference()
    .child('myReviews')
    .orderByChild('overAllRating');

class _ListViewNoteState extends State<ListViewNote> {
  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: 'E5OWWZnn5COugITejON4vbM75',
    consumerSecret: 'xYoulhEyEDS1SSaSCl4MoRbRNJ5KUJrReoYfIMTx8GAHMwpJOV',
  );
  //FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  List<Note> items;
  List<Note> recentlyItems;
  List<Review> reviewItems;
  bool isLoading = false;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;
  StreamSubscription<Event> _onReviewAddedSubscription;
  dynamic currentValue;

/* Auth status */
  Auth authStatus = new Auth();
  AuthStatus loginStatus = AuthStatus.notSignedIn;

  String displayName = "";
  String photoUrl = "";
  String email = "";

  Widget loginscreen;
  @override
  void initState() {
    super.initState();
    // firebaseMessaging.configure(
    //   onLaunch: (Map<String, dynamic> msg) {
    //     print(" onLaunch called ${(msg)}");
    //   },
    //   onResume: (Map<String, dynamic> msg) {
    //     print(" onResume called ${(msg)}");
    //   },
    //   onMessage: (Map<String, dynamic> msg) {
    //     // showNotification(msg);
    //     print(" onMessage called ${(msg)}");
    //   },
    // );
    // firebaseMessaging.getToken().then((token) {
    //   update(token);
    // });
    authStatus.userStatus().then((value) {
      if (value != null) {
        print("current user exists ${value.displayName}");
        widget.userName = value.displayName;
        widget.userEmail = value.email;
      }
    });

    getToken();
    // print("AAAAAAAAAAAAAAAAAa");
    items = new List();
    recentlyItems = new List();
    reviewItems = new List();
    _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);

    _onNoteChangedSubscription = _onNoteAddedSubscription =
        recentlyReference.onChildAdded.listen(_onRecentlyListAdded);
    recentlyReference.onChildChanged.listen(_onRecentlyListChanged);

    notesReference.onChildChanged.listen(_onNoteUpdated);

    _onReviewAddedSubscription =
        reviewReference.onChildAdded.listen(_onReviewAdded);
  }

  update(String token) {
    // print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/$token').set({"token": token});
    //textValue = token;
    // setState(() {});
  }

  @override
  void dispose() {
    _onNoteAddedSubscription.cancel();
    _onNoteChangedSubscription.cancel();
    _onReviewAddedSubscription.cancel();
    super.dispose();
  }

  void getToken() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String token = prefs.getString('token');
    // if (token != null) {
    //   setState(() {
    //     widget.userName = prefs.getString('userName');
    //     widget.currentImage = prefs.getString('currentImage');
    //   });
    // }
  }

  Future<Null> _handleSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // await twitterLogin.logOut();
    await _googleSignIn.signOut();
    //await _facebookSignIn.logOut();

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('token');
    // prefs.remove('userName');
    // prefs.remove('currentImage');

    setState(() {
      loginStatus = AuthStatus.notSignedIn;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ListViewNote('Sign In', ''),
      ),
    );
  }

  Widget _buildAddRestaurant(BuildContext context) {
    getToken();
    // if (widget.userName == 'Sign In' ||
    //     widget.userName == null ||
    //     widget.userName.isEmpty) {
    //   return SizedBox();
    // }
    if (loginStatus == AuthStatus.notSignedIn) {
      return SizedBox();
    } else {
      return ListTile(
        title: Text('Add Restaurant'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteScreen(
                    Note(null, '', '', '', 0.0, 0.0, 0.0, 0.0, 0, '', 0),
                    widget.userName,
                    widget.currentImage,
                   )),
          );
        },
      );
    }
  }

  _buildMyRestaurant(BuildContext context) {
    getToken();
    // if (widget.userName == 'Sign In' ||
    //     widget.userName == null ||
    //     widget.userName.isEmpty) {
    //   return SizedBox();
    // }
    if (loginStatus == AuthStatus.notSignedIn) {
      return SizedBox();
    } else {
      return ListTile(
          title: Text('My Restaurant'),
          onTap: () {
            List myReview = [];
            items.forEach((doc) {
              print(doc.userName);
              if (doc.userName == email) {
                myReview.add(doc);
              }
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListingManagerByQuery(
                      myReview, displayName, photoUrl, 'My Restaurant')),
            );
          });
    }
  }

  _buildMyReviews(BuildContext context) {
    getToken();
    if (widget.userName == 'Sign In' ||
        widget.userName == null ||
        widget.userName.isEmpty) {
      return SizedBox();
    } else {
      return ListTile(title: Text('My Reviews'), onTap: () {});
    }
  }

  _buildDivider(BuildContext context) {
    getToken();
    if (widget.userName == 'Sign In' ||
        widget.userName == null ||
        widget.userName.isEmpty) {
      return SizedBox();
    } else {
      return Divider(
        color: Colors.deepOrange,
      );
    }
  }

  _buildSignInLogo(BuildContext context) {
    getToken();
    // if (widget.userName == 'Sign In' ||
    //     widget.userName == null ||
    //     widget.userName.isEmpty) {
    //   return ListTile(
    //     leading: Icon(Icons.account_circle),
    //     title: Text('Sign In'),
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => LoginPage()),
    //       );
    //     },
    //   );
    // } else {
    //   return ListTile(
    //     leading: CircleAvatar(
    //       backgroundImage: NetworkImage(widget.currentImage),
    //     ),
    //     title: Text(widget.userName),
    //   );
    // }

    authStatus.userStatus().then((value) {
      if (value != null) {
        setState(() {
          loginStatus = AuthStatus.signedIn;
          currentValue = value;
        });
      }
    });
    // print("value $value");
    if (loginStatus == AuthStatus.notSignedIn) {
      setState(() {
        this.loginscreen = ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Sign In'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        );
      });

      //  print("value is null");

    } else {
      setState(() {
        this.displayName = currentValue.displayName;
        this.photoUrl = currentValue.photoUrl;
        this.email = currentValue.email;

        this.loginscreen = ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(currentValue.photoUrl),
          ),
          title: Text(currentValue.displayName),
        );

        loginStatus = AuthStatus.signedIn;
      });
      //  print("value is not null");
    }

    return this.loginscreen;
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Image.asset('assets/logo1.png'),
          ),
          _buildSignInLogo(context),
          Divider(
            color: Colors.deepOrange,
          ),
          _buildAddRestaurant(context),
          //_buildMyReviews(context),
          _buildMyRestaurant(context),
          _buildDivider(context),
          ListTile(
              title: Text('Top Restaurants in India'),
              onTap: () {
                List itemsRev = [];

                int j = items.length;

                for (int i = j - 1; i >= 0; i--) {
                  if (items[i].status == 1) {
                    itemsRev.add(items[i]);
                  }
                }
                List indianItems = [];
                itemsRev.forEach((doc) {
                  if (doc.country.toUpperCase() == 'INDIA') {
                    indianItems.add(doc);
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListingManagerByQuery(
                          indianItems,
                          widget.userName,
                          widget.currentImage,
                          'India'
                         )),
                );
              }),
          ListTile(
              title: Text('Top Restaurants in Australia'),
              onTap: () {
                 List itemsRev = [];

                int j = items.length;

                for (int i = j - 1; i >= 0; i--) {
                  if (items[i].status == 1) {
                    itemsRev.add(items[i]);
                  }
                }
                List australianItems = [];
                itemsRev.forEach((doc) {
                  if (doc.country.toUpperCase() == 'AUSTRALIA') {
                    australianItems.add(doc);
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListingManagerByQuery(
                          australianItems,
                          widget.userName,
                          widget.currentImage,
                          'Australia')),
                );
              }),
          ListTile(
              title: Text('Top Restaurants in UAE'),
              onTap: () {
                List itemsRev = [];

                int j = items.length;

                for (int i = j - 1; i >= 0; i--) {
                  if (items[i].status == 1) {
                    itemsRev.add(items[i]);
                  }
                }
                List dubaiItems = [];
                itemsRev.forEach((doc) {
                  if (doc.country.toUpperCase() == 'UAE') {
                    dubaiItems.add(doc);
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListingManagerByQuery(
                          dubaiItems,
                          widget.userName,
                          widget.currentImage,
                          'UAE')),
                );
              }),
          ListTile(
              title: Text('Top Restaurants in USA'),
              onTap: () {

                 List itemsRev = [];

                int j = items.length;

                for (int i = j - 1; i >= 0; i--) {
                  if (items[i].status == 1) {
                    itemsRev.add(items[i]);
                  }
                }
                List usaItems = [];
                itemsRev.forEach((doc) {
                  if (doc.country.toUpperCase() == 'USA') {
                    usaItems.add(doc);
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListingManagerByQuery(
                          usaItems,
                          widget.userName,
                          widget.currentImage,
                          'USA')),
                );
              }),
          Divider(
            color: Colors.deepOrange,
          ),
          // FlatButton(
          //   child: Text(widget.userName == null ||
          //           widget.userName == 'Sign In' ||
          //           widget.userName.isEmpty
          //       ? ''
          //       : 'Logout'),
          //   onPressed: () => _handleSignOut(context),
          // ),
          FlatButton(
            child: Text(loginStatus == AuthStatus.notSignedIn ? '' : 'Logout'),
            onPressed: () => _handleSignOut(context),
          ),
        ],
      ),
    );
  }

  // Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Best Indian Restaurant");
  @override
  Widget build(BuildContext context) {
    List itemsRev = [];

    int j = items.length;

    for (int i = j - 1; i >= 0; i--) {
      if (items[i].status == 1) {
        itemsRev.add(items[i]);
      }
    }

    List recentlyitemsRev = [];
    j = recentlyItems.length;
    for (int i = j - 1; i >= 0; i--) {
      if (recentlyItems[i].status == 1) {
        recentlyitemsRev.add(recentlyItems[i]);
      }
    }
    //print("----------------");
    //print(itemsRev[0].overAllRating);
    // print(itemsRev[0]['overAllRating']);
    // for(int i=j-1;i>=0;i++){
    //   print("-------------i------------");
    //   print(items[i].overAllRating);
    // }
    //final notesReference = FirebaseDatabase.instance.reference().child('myRestaurantListing').limitToLast(2);
    return MaterialApp(
      title: 'Best Indian Restaurant',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(title: appBarTitle, actions: <Widget>[
          // new IconButton(
          //   icon: actionIcon,
          //   onPressed: () {
          //     setState(() {
          //       if (this.actionIcon.icon == Icons.search) {
          //         this.actionIcon = new Icon(Icons.close);
          //         this.appBarTitle = new TextField(
          //           style: new TextStyle(
          //             color: Colors.white,
          //           ),
          //           decoration: new InputDecoration(
          //               prefixIcon:
          //                   new Icon(Icons.search, color: Colors.white),
          //               hintText: "Search By City",
          //               hintStyle: new TextStyle(color: Colors.white)),
          //         );
          //       } else {
          //         this.actionIcon = new Icon(Icons.search);
          //         this.appBarTitle = new Text("Best Indian Restaurant");
          //       }
          //     });
          //   },
          // ),
        ]),
        drawer: _buildSideDrawer(context),
        body: recentlyitemsRev.length != 0
            ? Container(
                //  child: ConstrainedBox(
//                constraints: BoxConstraints(
// ///               minHeight: viewportConstraints.maxHeight,
// ///            ),

//problem no 1

                margin: EdgeInsets.all(10.0),
                child: new SingleChildScrollView(
                  child: new ConstrainedBox(
                      constraints: new BoxConstraints.expand(
                        height: itemsRev.length * 87.5 + 240.0,
                      ),
                      //  Container(
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Recently Added",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 160.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recentlyitemsRev.length,
                            itemBuilder: (context, position) {
                              return GestureDetector(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 80.0),
                                    ),
                                    // SizedBox(height: 20.0),

                                    Container(
                                      child: FadeInImage(
                                        placeholder:
                                            AssetImage('assets/fadein.png'),
                                        image: NetworkImage(recentlyitemsRev[
                                                        position]
                                                    .image !=
                                                null
                                            ? '${recentlyitemsRev[position].image}'
                                            : 'Loading...'),
                                        fit: BoxFit.cover,
                                        width: 150.0,
                                        height: 100.0,
                                      ),
                                      decoration: new BoxDecoration(
                                        color: const Color(0xff7c94b6),

                                        // image: new DecorationImage(
                                      ),
                                    ),

                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      recentlyitemsRev.length > 0
                                          ? '${recentlyitemsRev[position].name}'
                                          : 'Loading...',
                                      textAlign: TextAlign.left,
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: recentlyitemsRev[position]
                                                          .totalReviewUser >
                                                      0
                                                  ? Colors.deepOrange
                                                  : Colors.grey,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(4.0)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 2.5),
                                        child: Text(
                                            recentlyitemsRev.length > 0
                                                ? recentlyitemsRev[position]
                                                            .totalReviewUser >
                                                        0
                                                    ? (recentlyitemsRev[
                                                                    position]
                                                                .overAllRating <=
                                                            5
                                                        ? '${recentlyitemsRev[position].overAllRating.toStringAsFixed(1)}'
                                                        : '5.0')
                                                    : '0.0'
                                                : '',
                                            style: TextStyle(
                                                color: recentlyitemsRev[
                                                                position]
                                                            .totalReviewUser >
                                                        0
                                                    ? Colors.deepOrange
                                                    : Colors.grey,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () => _navigateToNote(
                                      context,
                                      recentlyitemsRev[position],
                                      widget.userName,
                                      widget.currentImage,
                                    ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // Container(

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Top Rated",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                            Text(''),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        new Expanded(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemsRev.length,
                              itemBuilder: (context, position) {
                                return Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Divider(height: 5.0),
                                    ListTile(
                                      title: Text(
                                        '${itemsRev[position].name}',
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              '${itemsRev[position].city}, ${itemsRev[position].country}'),
                                          DecoratedBox(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: itemsRev[position]
                                                                .totalReviewUser >
                                                            0
                                                        ? Colors.deepOrange
                                                        : Colors.grey,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6.0,
                                                  vertical: 2.5),
                                              child: Text(
                                                itemsRev[position]
                                                            .totalReviewUser >
                                                        0
                                                    ? (itemsRev[position]
                                                                .overAllRating <=
                                                            5
                                                        ? '${itemsRev[position].overAllRating.toStringAsFixed(1)}'
                                                        : 5.0.toString())
                                                    : '0.0',
                                                style: TextStyle(
                                                    color: itemsRev[position]
                                                                .totalReviewUser >
                                                            0
                                                        ? Colors.deepOrange
                                                        : Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      // subtitle: Text(
                                      //   '${items[position].description}',
                                      //   style: new TextStyle(
                                      //     fontSize: 18.0,
                                      //     fontStyle: FontStyle.italic,
                                      //   ),
                                      // ),

                                      leading: Container(
                                        width: 100.0,
                                        height: 80.0,
                                        child: FadeInImage(
                                          placeholder:
                                              AssetImage('assets/fadein.png'),

                                          // image:new DecorationImage(
                                          image: NetworkImage(itemsRev[position]
                                                      .image !=
                                                  null
                                              ? '${itemsRev[position].image}'
                                              : 'Loading...'),

                                          fit: BoxFit.cover,
                                          // )

                                          // width: 150.0,
                                          // height: 100.0,
                                        ),

                                        decoration: new BoxDecoration(
                                          color: const Color(0xff7c94b6),
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(6.0)),
                                          // image: new DecorationImage(
                                        ),

                                        // image: new DecorationImage(
                                        //   image: new NetworkImage(
                                        //       '${itemsRev[position].image}'),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      onTap: () => _navigateToNote(
                                          context,
                                          itemsRev[position],
                                          widget.userName,
                                          widget.currentImage),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ])),
                  //  )

                  // floatingActionButton: FloatingActionButton(
                  //   child: Icon(Icons.add),
                  //   onPressed: () => _createNewNote(context),
                  // ),
                ))
            : new Center(
                child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.deepOrange,
                    value: null,
                    strokeWidth: 7.0,
                  ),
                ),
              ),
      ),
    );
  }

  void _onNoteAdded(Event event) {
    setState(() {
      items.add(new Note.fromSnapshot(event.snapshot));
      items.reversed;
    });
  }

  void _onRecentlyListAdded(Event event) {
    // print("_onRecentlyListAdded is called");

    setState(() {
      recentlyItems.add(new Note.fromSnapshot(event.snapshot));
    });
  }

  void _onRecentlyListChanged(Event event) {
    print("note has changed");

    var oldNoteValue =
        recentlyItems.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      // print("--------------onNoteUpdate from details -------------------");
      recentlyItems[recentlyItems.indexOf(oldNoteValue)] =
          Note.fromSnapshot(event.snapshot);
    });
  }

  void _onReviewAdded(Event event) {
    setState(() {
      reviewItems.add(new Review.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    print("NOte updated");
    var oldNoteValue =
        items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] = Note.fromSnapshot(event.snapshot);
    });
  }

  void _deleteNote(BuildContext context, Note note, int position) async {
    // await notesReference.child(note.id).remove().then((_) {
    //   setState(() {
    //     items.removeAt(position);
    //   });
    // });
  }

  void _navigateToNote(BuildContext context, Note note, String userName,
      String currentImage) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListingDetail(note, userName, currentImage)),
    );
  }

  void _createNewNote(BuildContext context) async {
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => NoteScreen(
    //           Note(null, '', '', '', 0.0, 0.0, 0.0, 0.0, 0, '', 0),
    //           widget.userName,
    //           widget.currentImage,
    //           widget.userEmail)),
    // );
  }
}
