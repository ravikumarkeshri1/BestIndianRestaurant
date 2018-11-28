import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './listing_manager.dart';
import './listing_by_query.dart';
import './my_Reviews.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class HomePage extends StatelessWidget {
  final List<Map<dynamic, dynamic>> fetchedProductList;
  final List<Map<dynamic, dynamic>> fetchListingId;
  String userName, currentImage, email;
  HomePage(this.fetchedProductList, this.fetchListingId, this.userName,
      this.currentImage, this.email);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new AfterSplash(
          fetchedProductList, fetchListingId, userName, currentImage, email),
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

class AfterSplash extends StatefulWidget {
  final List<Map<dynamic, dynamic>> fetchedProductList;
  final List<Map<dynamic, dynamic>> fetchListingId;
  final String userName, currentImage, email;
  AfterSplash(this.fetchedProductList, this.fetchListingId, this.userName,
      this.currentImage, this.email);
  @override
  _AfterSplashState createState() => new _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  // Future<Null> _handleSignOut(BuildContext context) async {
  //   _googleSignIn.signOut();

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (BuildContext context) => HomePage(widget.fetchedProductList,
  //           widget.fetchListingId, 'Sign In', 'currentImage', 'email'),
  //     ),
  //   );
  // }

  final List<Map<dynamic, dynamic>> fetchedProductList = [];
  final List<Map<dynamic, dynamic>> fetchListingId = [];
  // final List fetchedMyReviewtList = [];
  var fetchedMyReviewtList = new List();
   final List<Map<dynamic, dynamic>> fetchedMyListingDatatList = [];
    final List<Map<dynamic, dynamic>> fetchedMyReviewDatatList = [];
 // var fetchedMyListingDatatList = new List();
  void getMyReviewData(String email) {
    print("country ${email}");
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var listingRef = ref.child('listing');
    var reviewRef = ref.child('reviews');
    reviewRef
        .orderByChild('email')
        .equalTo(email.toString())
        .once()
        .then((DataSnapshot snapreview) {
      final Map<dynamic, dynamic> myReviewListData = snapreview.value;

      myReviewListData.forEach((dynamic listingId, dynamic reviewData) {
        fetchedMyReviewtList.add(reviewData['listing_id'].toString());
         fetchedMyReviewDatatList.add(reviewData);
      });
    });

    //print("my review data out${fetchedMyReviewtList}");

    for (int i = 0; i < fetchedMyReviewtList.length; i++) {
      listingRef
          .orderByKey()
          .equalTo(fetchedMyReviewtList[i].toString())
          .once()
          .then((DataSnapshot snaplisting) {
        final Map<dynamic, dynamic> myListingData = snaplisting.value;
         print("my listing data in ${myListingData}");
        myListingData.forEach((dynamic listingdataId, dynamic listingData) {
          print('listingdata'+listingData.toString());
          fetchedMyListingDatatList.add(listingData);
        });
      });
    }
      // print("my review data ${fetchedMyReviewDatatList}");
      // print("my listing data out ${fetchedMyListingDatatList}");
     
  }

  void getData(String country) {
    print("country ${country}");
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var userRef = ref.child('listing');
    var reviewRef = ref.child('reviews');
    userRef.orderByKey().limitToFirst(15).once().then((DataSnapshot snap) {
      final Map<dynamic, dynamic> productListData = snap.value;
      double costRating = 0.0,
          foodRating = 0.0,
          serviceRating = 0.0,
          overAllRating = 0.0;
      productListData.forEach((dynamic listingId, dynamic productData) {
        if (productData['location']['country'] == country) {
          // fetchedProductList.add(productData);
          int sumCost = 0, sumFood = 0, sumService = 0;
          int count = 0;
          reviewRef
              .orderByChild('listing_id')
              .equalTo(listingId.toString())
              .once()
              .then((DataSnapshot snapreview) {
            final Map<dynamic, dynamic> reviewListData = snapreview.value;

            reviewListData.forEach((dynamic reviewid, dynamic reviewData) {
              sumCost = sumCost + reviewData['cost'];
              sumFood = sumFood + reviewData['food'];
              sumService = sumService + reviewData['service'];
              count = count + 1;

              fetchListingId.add(reviewData);
            });
            costRating = sumCost / count;
            costRating = num.parse(costRating.toStringAsFixed(1));
            foodRating = sumFood / count;
            foodRating = num.parse(foodRating.toStringAsFixed(1));
            serviceRating = sumService / count;
            serviceRating = num.parse(serviceRating.toStringAsFixed(1));
            overAllRating = (costRating + foodRating + foodRating) / 3;
            overAllRating = num.parse(overAllRating.toStringAsFixed(1));
            productData['costRating'] = costRating;
            productData['foodRating'] = foodRating;
            productData['serviceRating'] = serviceRating;
            productData['overAllRating'] = overAllRating;
          });
          fetchedProductList.add(productData);
        }
      });
    });
  }

  Widget _buildSideDrawer(BuildContext context) {
    print('curret image${widget.currentImage}');
    if (widget.userName == 'Sign In' ||
        widget.userName == null ||
        widget.userName.isEmpty) {
      return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Image.asset('assets/logo1.png'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Sign In'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            Divider(
              color: Colors.deepOrange,
            ),
            ListTile(
                title: Text('Top Restaurant in India'),
                onTap: () {
                  getData('india');
                  print(fetchedProductList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ListingManagerByQuery(
                          fetchedProductList,
                          fetchListingId,
                          widget.userName,
                          widget.currentImage,
                          widget.email),
                    ),
                  );
                }),
            ListTile(
                title: Text('Top Restaurant in USA'),
                onTap: () {
                  getData('United States Of America');
                  print(fetchedProductList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ListingManagerByQuery(
                          fetchedProductList,
                          fetchListingId,
                          widget.userName,
                          widget.currentImage,
                          widget.email),
                    ),
                  );
                }),
            ListTile(
                title: Text('Top Restaurant in United Arab Emirates'),
                onTap: () {
                  getData('United Arab Emirates');
                  print(fetchedProductList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ListingManagerByQuery(
                          fetchedProductList,
                          fetchListingId,
                          widget.userName,
                          widget.currentImage,
                          widget.email),
                    ),
                  );
                }),
            Divider(
              color: Colors.deepOrange,
            ),
            FlatButton(
              child: Text(widget.userName == null ||
                      widget.userName == 'Sign In' ||
                      widget.userName.isEmpty
                  ? ''
                  : 'Logout'),
              onPressed: () {} //_handleSignOut(context),
            ),
          ],
        ),
      );
    } else {
      return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Image.asset('assets/logo1.png'),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.currentImage),
              ),
              title: Text(widget.userName),
            ),
            Divider(
              color: Colors.deepOrange,
            ),
            ListTile(
                title: Text('Add Restaurant'),
                onTap: () {
                  Navigator.pushNamed(context, '/add');
                }),
            ListTile(
                title: Text('My Restaurant'),
                onTap: () {
                  Navigator.pushNamed(context, '/add');
                }),
            ListTile(
                title: Text('My Reviews'),
                onTap: () {
                  getMyReviewData(widget.email);
                  print("my fetch data from review ${fetchedMyListingDatatList}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyReviews(
                          fetchedMyListingDatatList,
                          fetchedMyReviewDatatList,
                          widget.userName,
                          widget.currentImage,
                          widget.email),
                    ),
                  );
                }),
            Divider(
              color: Colors.deepOrange,
            ),
            ListTile(
                title: Text('Top Restaurant in India'),
                onTap: () {
                  getData('india');
                  print(fetchedProductList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ListingManagerByQuery(
                          fetchedProductList,
                          fetchListingId,
                          widget.userName,
                          widget.currentImage,
                          widget.email),
                    ),
                  );
                }),
            ListTile(
                title: Text('Top Restaurant in USA'),
                onTap: () {
                  getData('United States Of America');
                  print(fetchedProductList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ListingManagerByQuery(
                          fetchedProductList,
                          fetchListingId,
                          widget.userName,
                          widget.currentImage,
                          widget.email),
                    ),
                  );
                }),
            ListTile(
                title: Text('Top Restaurant in United Arab Emirates'),
                onTap: () {
                  getData('United Arab Emirates');
                  print(fetchedProductList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ListingManagerByQuery(
                          fetchedProductList,
                          fetchListingId,
                          widget.userName,
                          widget.currentImage,
                          widget.email),
                    ),
                  );
                }),
            Divider(
              color: Colors.deepOrange,
            ),
            FlatButton(
              child: Text(widget.userName == null ||
                      widget.userName == 'Sign In' ||
                      widget.userName.isEmpty
                  ? ''
                  : 'Logout'),
              onPressed: (){} //_handleSignOut(context),
            ),
          ],
        ),
      );
    }
  }

  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Best Indian Restaurant");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,

      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      home: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(title: appBarTitle, actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search By City",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("Best Indian Restaurant");
                }
              });
            },
          ),
        ]),
        body: ListingManager(widget.fetchedProductList, widget.fetchListingId,
            widget.userName, widget.email),
      ),
    );
  }
}
