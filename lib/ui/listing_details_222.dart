// import 'package:flutter/material.dart';
// import 'package:flutter_rating/flutter_rating.dart';
// import '../helpers/ensure-visible.dart';
// import 'package:firebase_database/firebase_database.dart';
// import '../model/note.dart';
// import '../model/review.dart';
// import './login.dart';
// import 'dart:async';
// import 'dart:convert';
// import './all_listing_reviews.dart';

// class ListingDetail extends StatefulWidget {
//   final Note note;
//   final Review review;
//   final String userName, currentImage;

//   ListingDetail(this.note, this.userName, this.currentImage);
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _ListingDetailState();
//   }
// }

// final reviewReference =
//     FirebaseDatabase.instance.reference().child('myReviews');
// final notesReference =
//     FirebaseDatabase.instance.reference().child('myRestaurantListing');

// class _ListingDetailState extends State<ListingDetail> {
//   double rateFood = 0.0;
//   double rateService = 0.0;
//   double rateCost = 0.0;
//   double rateOverAll = 0.0;
//   String comment = '';
//   final _reviewFocusNode = FocusNode();
//   List<Review> reviewItems;
//   List<Note> items;
//   StreamSubscription<Event> _onReviewAddedSubscription;
//   StreamSubscription<Event> _onNoteAddedSubscription;
//   StreamSubscription<Event> _onNoteChangedSubscription;
//   // TextEditingController _commentController;

//   //   @override
//   void initState() {
//     super.initState();
//     reviewItems = new List();
//     items = new List();
//     print("current id " + widget.note.id);

//     final reviewReferenceCurrent = FirebaseDatabase.instance
//         .reference()
//         .child('myReviews')
//         .orderByChild('listing_id')
//         .equalTo(widget.note.id.toString());
//     _onReviewAddedSubscription =
//         reviewReferenceCurrent.onChildAdded.listen(_onReviewAdded);
//   }

//   @override
//   void dispose() {
//     _onReviewAddedSubscription.cancel();
//     super.dispose();
//   }

//   void _onReviewAdded(Event event) {
//     setState(() {
//       reviewItems.add(new Review.fromSnapshot(event.snapshot));
//     });
//   }

//   void _onNoteAdded(Event event) {
//     setState(() {
//       print("---------- onNoteAdded------------- fromd details");
//       items.add(new Note.fromSnapshot(event.snapshot));
//       items.reversed;
//     });
//   }

//   void _onNoteUpdated(Event event) {
//     var oldNoteValue =
//         items.singleWhere((note) => note.id == event.snapshot.key);
//     setState(() {
//       print("--------------onNoteUpdate from details -------------------");
//       items[items.indexOf(oldNoteValue)] =
//           new Note.fromSnapshot(event.snapshot);
//     });
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   _submitForm() {
//     _formKey.currentState.save();

//     final Map<String, dynamic> review = {
//       'userName': widget.userName,
//       'cost': rateCost,
//       'food': rateFood,
//       'service': rateService,
//       'comments': comment,
//       'listing_id': widget.note.id,
//       "status": 0,
//       "email": widget.userName,
//       "profileImage": widget.currentImage
//     };

//     reviewReference.push().set({
//       'userName': widget.userName,
//       'cost': rateCost,
//       'food': rateFood,
//       'service': rateService,
//       'comments': comment,
//       'listing_id': widget.note.id,
//       "status": 0,
//       "email": widget.userName,
//       "profileImage": widget.currentImage
//     }).then((_) {
//       int totalReviewUser = widget.note.totalReviewUser;
//       totalReviewUser++;
//       double newCostRating =
//           (widget.note.totalCost + rateCost) / totalReviewUser;
//       newCostRating = num.parse(newCostRating.toStringAsFixed(1));
//       double newFoodRating =
//           (widget.note.totalFood + rateFood) / totalReviewUser;
//       newFoodRating = num.parse(newFoodRating.toStringAsFixed(1));
//       double newServiceRating =
//           (widget.note.totalCost + rateService) / totalReviewUser;
//       newServiceRating = num.parse(newServiceRating.toStringAsFixed(1));
//       double newOverAllRating =
//           (newCostRating + newFoodRating + newServiceRating) / 3;
//       newOverAllRating = num.parse(newOverAllRating.toStringAsFixed(1));

//       if (newFoodRating % 1 == 0) {
//         newFoodRating = newFoodRating + 0.1;
//       }
//       if (newCostRating % 1 == 0) {
//         newCostRating = newCostRating + 0.1;
//       }
//       if (newServiceRating % 1 == 0) {
//         newServiceRating = newServiceRating + 0.1;
//       }
//       if (newOverAllRating % 1 == 0) {
//         newOverAllRating = newOverAllRating + 0.1;
//       }
//       notesReference.child(widget.note.id).set({
//         'name': widget.note.name,
//         'description': widget.note.description,
//         'city': widget.note.city,
//         'image': widget.note.image,
//         'totalCost': newCostRating,
//         'totalFood': newFoodRating,
//         'totalService': newServiceRating,
//         'overAllRating': newOverAllRating,
//         'totalReviewUser': totalReviewUser,
//         'openHours': widget.note.openHours,
//         'cuisines': widget.note.cuisines,
//         'goodFor': widget.note.goodFor,
//         'contactName': widget.note.contactName,
//         'contactEmail': widget.note.contactEmail,
//         'contactNumber': widget.note.contactNumber,
//         'street': widget.note.street,
//         'state': widget.note.state,
//         'country': widget.note.country,
//         'pincode': widget.note.pincode,
//         'userName': widget.userName,
//         'status':widget.note.status,
//       }).then((_) {
//         _onNoteAddedSubscription =
//             notesReference.onChildAdded.listen(_onNoteAdded);
//         _onNoteChangedSubscription =
//             notesReference.onChildChanged.listen(_onNoteUpdated);
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (BuildContext context) => ListViewNote(widget.userName,widget.currentImage),
//         //   ),
//         // );
//       });
//     });

//     return showDialog<Null>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return new AlertDialog(
//           title: new Text('Thank You For The Review'),
//           content: new SingleChildScrollView(
//             child: new ListBody(
//               children: <Widget>[
//                 new Text('Your review has been submitted.'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text('Cool'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (BuildContext context) => AllReviews(
//                           reviewItems,
//                         ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   _reviewForm() {
//     if (widget.userName == 'Sign In' ||
//         widget.userName == null ||
//         widget.userName.isEmpty) {
//       return Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 20.0),
//             child: Text(
//               "Please login to add a review",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
//             ),
//           ),
//           RaisedButton(
//             child: Text(
//               "LOGIN",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             color: Colors.deepOrange,
//             padding: EdgeInsets.symmetric(horizontal: 170.0),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//               );
//             },
//           ),
//         ],
//       );
//     } else {
//       bool reviewStatus = false;
//       reviewItems.forEach((doc) {
//         if (doc.userName == widget.userName) {
//           reviewStatus = true;
//         }
//       });
//       if (reviewStatus) {
//         return Text(
//           "You've reviewed this restaurant",
//           textAlign: TextAlign.center,
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
//         );
//       } else {
//         return Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(top: 10.0),
//                 child: Text(
//                   "Write Reviews",
//                   style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Text(
//                 'Rate Your Experience',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text("Food"),
//                   StarRating(
//                     rating: rateFood,
//                     color: Colors.deepOrange,
//                     borderColor: Colors.grey,
//                     size: 25.0,
//                     starCount: 5,
//                     onRatingChanged: (rating) => setState(() {
//                           this.rateFood = rating;
//                         }),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text("Services"),
//                   StarRating(
//                     rating: rateService,
//                     color: Colors.deepOrange,
//                     borderColor: Colors.grey,
//                     size: 25.0,
//                     starCount: 5,
//                     onRatingChanged: (rating) => setState(() {
//                           this.rateService = rating;
//                         }),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text("Cost"),
//                   StarRating(
//                     rating: rateCost,
//                     color: Colors.deepOrange,
//                     borderColor: Colors.grey,
//                     size: 25.0,
//                     starCount: 5,
//                     onRatingChanged: (rating) => setState(() {
//                           this.rateCost = rating;
//                         }),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Text(
//                 'Start Writing Your Review',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               EnsureVisibleWhenFocused(
//                 focusNode: _reviewFocusNode,
//                 child: TextFormField(
//                   focusNode: _reviewFocusNode,
//                   maxLines: 4,
//                   maxLength: 400,
//                   decoration: InputDecoration(
//                     labelText: 'Write Review',
//                     counterText: 'Max length: 500',
//                     hintText: 'Be polite and help others make better choices.',
//                   ),
//                   validator: (String value) {
//                     if (value.isEmpty || value.length < 10) {
//                       return 'This Field cannot be empty and should be 10+ characters long.';
//                     }
//                   },
//                   onSaved: (String value) {
//                     setState(() {
//                       comment = value;
//                     });
//                   },
//                 ),
//               ),
//               RaisedButton(
//                 padding: EdgeInsets.symmetric(horizontal: 170.0),
//                 color: Colors.deepOrange,
//                 child: Text("SUBMIT"),
//                 textColor: Colors.white,
//                 onPressed: () {
//                   _formKey.currentState.validate();
//                   if (rateCost < 1.0 || rateFood < 1.0 || rateService < 0) {
//                     return showDialog<Null>(
//                       context: context,
//                       barrierDismissible: false, // user must tap button!
//                       builder: (BuildContext context) {
//                         return new AlertDialog(
//                           title: new Text('Oops!!'),
//                           content: new SingleChildScrollView(
//                             child: new ListBody(
//                               children: <Widget>[
//                                 new Text(
//                                     'Please rate the restaurant before you submit.'),
//                               ],
//                             ),
//                           ),
//                           actions: <Widget>[
//                             new FlatButton(
//                               child: new Text('Got It!!'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                   if (_formKey.currentState.validate()) {
//                     _submitForm();
//                   }
//                 },
//               )
//             ],
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final description = widget.note.description;
//     final name = widget.note.name.toUpperCase();
//     final openHours = widget.note.openHours.toUpperCase();
//     final cuisines = widget.note.cuisines;
//     final goodFor = widget.note.goodFor;
//     final contactName = widget.note.contactName;
//     final contactEmail = widget.note.contactEmail;
//     final contactNumber = widget.note.contactNumber;
//     final street = widget.note.street;
//     final city = widget.note.city;
//     final state = widget.note.state;
//     final country = widget.note.country;
//     final pincode = widget.note.pincode;
//     double overAllRating = widget.note.overAllRating;
//      int totalReviewUser = widget.note.totalReviewUser;
//     double costRating = widget.note.totalCost;
//     double serviceRating = widget.note.totalService;
//     double foodRating = widget.note.totalFood;
//     final _reviewCostRecent_0 = 5.0;
//     final _reviewFoodRecent_0 = 4.0;
//     final _reviewServiceRecent_0 = 3.5;
//     final _reviewOverAllRecent_0 =
//         ((_reviewCostRecent_0 + _reviewFoodRecent_0 + _reviewServiceRecent_0) /
//                 3)
//             .toStringAsFixed(1);
// // get the data fromreview

//     String comment0,
//         comment1,
//         userName0,
//         userName1,
//         profileImage0,
//         profileImage1;
//     int cost0, food0, service0, cost1, food1, service1;
//     double overall0, overall1;
//     if (reviewItems.length >= 1) {
//       comment0 = reviewItems[0].comments;
//       userName0 = reviewItems[0].userName;
//       profileImage0 = reviewItems[0].profileImage;
//       cost0 = reviewItems[0].cost;
//       food0 = reviewItems[0].food;
//       service0 = reviewItems[0].service;
//       overall0 = (cost0 + food0 + service0) / 3;
//     } else {
//       comment0 = 'No Review Yet';
//     }
//     final _commentServiceRecent_0 = comment0;
//     final _reviewCostRecent_1 = 3.5;
//     final _reviewFoodRecent_1 = 5.0;
//     final _reviewServiceRecent_1 = 2.5;
//     final _reviewOverAllRecent_1 =
//         ((_reviewCostRecent_1 + _reviewFoodRecent_1 + _reviewServiceRecent_1) /
//                 3)
//             .toStringAsFixed(1);
//     if (reviewItems.length >= 2) {
//       comment1 = reviewItems[1].comments;
//       userName1 = reviewItems[1].userName;
//       profileImage1 = reviewItems[1].profileImage;
//       cost1 = reviewItems[1].cost;
//       food1 = reviewItems[1].food;
//       service1 = reviewItems[1].service;
//       overall1 = (cost1 + food1 + service1) / 3;
//     } else {
//       comment1 = 'No Review Yet';
//     }
//     final _commentServiceRecent_1 = comment1;
//     _buildHighlightedReview0() {
//       print('-------------------&&&--------');
//       print(reviewItems.length);
//       if (reviewItems.length > 0) {
//         return ListTile(
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(profileImage0),
//           ),
//           title: Text(
//             userName0,
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           subtitle: Row(
//             children: <Widget>[
//               Text('Rated'),
//               SizedBox(
//                 width: 10.0,
//               ),
//               DecoratedBox(
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.deepOrange, width: 2.0),
//                     borderRadius: BorderRadius.circular(4.0)),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
//                   child: Text(
//                     overall0.toStringAsFixed(1),
//                     style: TextStyle(
//                         color: Colors.deepOrange, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else {
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: 20.0),
//           child: Text(
//             'No Reviews Yet. Be the first one to review',
//             textAlign: TextAlign.center,
//           ),
//         );
//       }
//     }

//     _buildHighlightedReviewComment0() {
//       if (reviewItems.length > 0) {
//         return Text(
//           _commentServiceRecent_0,
//           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
//         );
//       } else {
//         return SizedBox();
//       }
//     }

//     _buildHighlightedReview1() {
//       if (reviewItems.length > 1) {
//         return ListTile(
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(profileImage1),
//           ),
//           title: Text(
//             userName1,
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           subtitle: Row(
//             children: <Widget>[
//               Text('Rated'),
//               SizedBox(
//                 width: 10.0,
//               ),
//               DecoratedBox(
//                 decoration: BoxDecoration(
//                     border: Border.all(color:totalReviewUser >0 ? Colors.deepOrange:Colors.grey, width: 2.0),
//                     borderRadius: BorderRadius.circular(4.0)),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
//                   child: Text(
//                    totalReviewUser>0 ? overall1.toStringAsFixed(1):'0.0',
//                     style: TextStyle(
//                         color: totalReviewUser >0? Colors.deepOrange:Colors.grey, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else {
//         return SizedBox();
//       }
//     }

//     _buildHighlightedReviewComment1() {
//       if (reviewItems.length > 1) {
//         return Text(
//           _commentServiceRecent_1,
//           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
//         );
//       } else {
//         return SizedBox();
//       }
//     }

//     _buildReadMore() {
//       if (reviewItems.length > 2) {
//         return FlatButton(
//           child: Text(
//             'Read More',
//             style: TextStyle(color: Colors.grey),
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) => AllReviews(
//                       reviewItems,
//                     ),
//               ),
//             );
//           },
//         );
//       } else {
//         return SizedBox();
//       }
//     }

//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: DefaultTabController(
//           length: 2,
//           child: NestedScrollView(
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverAppBar(
//                   expandedHeight: 200.0,
//                   floating: false,
//                   pinned: true,
//                   flexibleSpace: FlexibleSpaceBar(
//                       centerTitle: true,
//                       title: Text(name,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0,
//                           )),
//                       background: Image.network(
//                         widget.note.image,
//                         fit: BoxFit.cover,
//                       )),
//                 ),
//                 SliverPersistentHeader(
//                   delegate: _SliverAppBarDelegate(
//                     TabBar(
//                       labelColor: Colors.black87,
//                       unselectedLabelColor: Colors.grey,
//                       tabs: [
//                         Tab(icon: Icon(Icons.info_outline), text: "Info"),
//                         Tab(icon: Icon(Icons.star_border), text: "Reviews"),
//                       ],
//                     ),
//                   ),
//                   // pinned: true,
//                   // floating: true,
//                 ),
//               ];
//             },
//             body: TabBarView(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10.0),
//                   child: ListView(
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             name,
//                             style: TextStyle(
//                                 fontSize: 20.0, fontWeight: FontWeight.w600),
//                             textAlign: TextAlign.right,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(right: 10.0),
//                             child: DecoratedBox(
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color:totalReviewUser>0 ? Colors.deepOrange:Colors.grey, width: 2.0),
//                                   borderRadius: BorderRadius.circular(4.0)),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 6.0, vertical: 2.5),
//                                 child: Text(
//                                 totalReviewUser>0?  widget.note.overAllRating <= 5
//                                       ? widget.note.overAllRating.toString()
//                                       : '5.0':'0.0',
//                                   style: TextStyle(
//                                       color:totalReviewUser>0 ? Colors.deepOrange:Colors.grey,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(3.0),
//                       ),
//                       Text(
//                         city + ', ' + country,
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),

//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             'Open Hours: ',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                           Text(
//                             openHours,
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ],
//                       ),

//                       Padding(
//                         padding: EdgeInsets.only(top: 15.0),
//                         child: Text(
//                           "Details",
//                           style: TextStyle(
//                               fontSize: 17.0, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             contactNumber,
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.call),
//                             color: Colors.green,
//                             onPressed: () {},
//                           )
//                         ],
//                       ),
//                       // Padding(
//                       //   padding: EdgeInsets.all(5.0),
//                       // ),
//                       Text(
//                         'Address',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       Text(street +
//                           ', ' +
//                           city +
//                           ', ' +
//                           state +
//                           ', ' +
//                           country +
//                           ', ' +
//                           pincode),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Text(
//                         'Cuisine',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       Text(cuisines),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Text(
//                         'Good For',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       Text(goodFor),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Text(
//                         'More Info',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       Text(description),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10.0),
//                   child: ListView(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(top: 10.0),
//                         child: Text(
//                           "User Ratings",
//                           style: TextStyle(
//                               fontSize: 17.0, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text("Over All Rating"),
//                           Row(
//                             children: <Widget>[
//                               StarRating(
//                                 rating: totalReviewUser>0 ?overAllRating:0.0,
//                                 color: Colors.deepOrange,
//                                 borderColor: Colors.grey,
//                                 size: 25.0,
//                                 starCount: 5,
//                                 // onRatingChanged: (rating) => setState(() {
//                                 //       this.rating = rating;
//                                 //     }),
//                               ),
//                               SizedBox(
//                                 width: 25.0,
//                               ),
//                               DecoratedBox(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey, width: 2.0),
//                                     borderRadius: BorderRadius.circular(4.0)),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 6.0, vertical: 2.5),
//                                   child: Text(
//                                    totalReviewUser>0 ? widget.note.overAllRating <= 5
//                                         ? widget.note.overAllRating.toString()
//                                         : '5.0':'0.0',
//                                     style: TextStyle(
//                                         color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text("Food Quality"),
//                           Row(
//                             children: <Widget>[
//                               StarRating(
//                                 rating: totalReviewUser >0 ? foodRating:0.0,
//                                 color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey,
//                                 borderColor: Colors.grey,
//                                 size: 25.0,
//                                 starCount: 5,
//                                 // onRatingChanged: (rating) => setState(() {
//                                 //       this.rating = rating;
//                                 //     }),
//                               ),
//                               SizedBox(
//                                 width: 25.0,
//                               ),
//                               DecoratedBox(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey, width: 2.0),
//                                     borderRadius: BorderRadius.circular(4.0)),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 6.0, vertical: 2.5),
//                                   child: Text(
//                                     totalReviewUser >0 ? foodRating <= 5
//                                         ? foodRating.toString()
//                                         : '5.0':'0.0',
//                                     style: TextStyle(
//                                         color: totalReviewUser >0? Colors.deepOrange:Colors.grey,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text("Services"),
//                           Row(
//                             children: <Widget>[
//                               StarRating(
//                                 rating: totalReviewUser >0 ?serviceRating:0.0,
//                                 color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey,
//                                 borderColor: Colors.grey,
//                                 size: 25.0,
//                                 starCount: 5,
//                                 // onRatingChanged: (rating) => setState(() {
//                                 //       this.rating = rating;
//                                 //     }),
//                               ),
//                               SizedBox(
//                                 width: 25.0,
//                               ),
//                               DecoratedBox(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey, width: 2.0),
//                                     borderRadius: BorderRadius.circular(4.0)),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 6.0, vertical: 2.5),
//                                   child: Text(
//                                     totalReviewUser >0 ? serviceRating <= 5
//                                         ? serviceRating.toString()
//                                         : '5.0':'0.0',
//                                     style: TextStyle(
//                                         color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text("Cost"),
//                           Row(
//                             children: <Widget>[
//                               StarRating(
//                                 rating: totalReviewUser >0 ? costRating: 0.0,
//                                 color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey,
//                                 borderColor: Colors.grey,
//                                 size: 25.0,
//                                 starCount: 5,
//                                 // onRatingChanged: (rating) => setState(() {
//                                 //       this.rating = rating;
//                                 //     }),
//                               ),
//                               SizedBox(
//                                 width: 25.0,
//                               ),
//                               DecoratedBox(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey, width: 2.0),
//                                     borderRadius: BorderRadius.circular(4.0)),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 6.0, vertical: 2.5),
//                                   child: Text(
//                                    totalReviewUser >0 ? costRating <= 5
//                                         ? costRating.toString()
//                                         : '5.0':'0.0',
//                                     style: TextStyle(
//                                         color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Divider(
//                         height: 4.0,
//                         color: Colors.grey,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10.0),
//                         child: Text(
//                           "Higlighted Reviews",
//                           style: TextStyle(
//                               fontSize: 17.0, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       // Row(
//                       // children: <Widget>[
//                       _buildHighlightedReview0(),
//                       _buildHighlightedReviewComment0(),
//                       _buildHighlightedReview1(),
//                       _buildHighlightedReviewComment1(),
//                       _buildReadMore(),
//                       Divider(
//                         height: 4.0,
//                         color: Colors.grey,
//                       ),
//                       _reviewForm(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);

//   final TabBar _tabBar;

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new Container(
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import '../helpers/ensure-visible.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/note.dart';
import '../model/review.dart';
import './login.dart';
import 'dart:async';
import 'dart:convert';
import './all_listing_reviews.dart';

class ListingDetail extends StatefulWidget {
  final Note note;
   Review review;
  final String userName, currentImage;

  ListingDetail(this.note, this.userName, this.currentImage);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListingDetailState();
  }
}

final reviewReference =
    FirebaseDatabase.instance.reference().child('myReviews');
final notesReference =
    FirebaseDatabase.instance.reference().child('myRestaurantListing');

class _ListingDetailState extends State<ListingDetail> {
  double rateFood = 0.0;
  double rateService = 0.0;
  double rateCost = 0.0;
  double rateOverAll = 0.0;
  String comment = '';
  final _reviewFocusNode = FocusNode();
  List<Review> reviewItems;
  List<Note> items;
  StreamSubscription<Event> _onReviewAddedSubscription;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;
  // TextEditingController _commentController;

  //   @override
  void initState() {
    super.initState();
    reviewItems = new List();
    items = new List();
    print("current id " + widget.note.id);

    final reviewReferenceCurrent = FirebaseDatabase.instance
        .reference()
        .child('myReviews')
        .orderByChild('listing_id')
        .equalTo(widget.note.id.toString());
    _onReviewAddedSubscription =
        reviewReferenceCurrent.onChildAdded.listen(_onReviewAdded);
  }

  @override
  void dispose() {
    _onReviewAddedSubscription.cancel();
    super.dispose();
  }

  void _onReviewAdded(Event event) {
    setState(() {
      reviewItems.add(new Review.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteAdded(Event event) {
    setState(() {
      print("---------- onNoteAdded------------- fromd details");
      items.add(new Note.fromSnapshot(event.snapshot));
      items.reversed;
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue =
        items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      print("--------------onNoteUpdate from details -------------------");
      items[items.indexOf(oldNoteValue)] =
          new Note.fromSnapshot(event.snapshot);
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _submitForm() {
    _formKey.currentState.save();

    final Map<String, dynamic> review = {
      'userName': widget.userName,
      'cost': rateCost,
      'food': rateFood,
      'service': rateService,
      'comments': comment,
      'listing_id': widget.note.id,
      "status": 0,
      "email": widget.userName,
      "profileImage": widget.currentImage
    };

    reviewReference.push().set({
      'userName': widget.userName,
      'cost': rateCost,
      'food': rateFood,
      'service': rateService,
      'comments': comment,
      'listing_id': widget.note.id,
      "status": 0,
      "email": widget.userName,
      "profileImage": widget.currentImage
    }).then((_) {
      int totalReviewUser = widget.note.totalReviewUser;
      totalReviewUser++;
      double newCostRating =
          (widget.note.totalCost + rateCost) / totalReviewUser;
      newCostRating = num.parse(newCostRating.toStringAsFixed(1));
      double newFoodRating =
          (widget.note.totalFood + rateFood) / totalReviewUser;
      newFoodRating = num.parse(newFoodRating.toStringAsFixed(1));
      double newServiceRating =
          (widget.note.totalCost + rateService) / totalReviewUser;
      newServiceRating = num.parse(newServiceRating.toStringAsFixed(1));
      double newOverAllRating =
          (newCostRating + newFoodRating + newServiceRating) / 3;
      newOverAllRating = num.parse(newOverAllRating.toStringAsFixed(1));

      if (newFoodRating % 1 == 0) {
        newFoodRating = newFoodRating + 0.1;
      }
      if (newCostRating % 1 == 0) {
        newCostRating = newCostRating + 0.1;
      }
      if (newServiceRating % 1 == 0) {
        newServiceRating = newServiceRating + 0.1;
      }
      if (newOverAllRating % 1 == 0) {
        newOverAllRating = newOverAllRating + 0.1;
      }
      notesReference.child(widget.note.id).set({
        'name': widget.note.name,
        'description': widget.note.description,
        'city': widget.note.city,
        'image': widget.note.image,
        'totalCost': newCostRating,
        'totalFood': newFoodRating,
        'totalService': newServiceRating,
        'overAllRating': newOverAllRating,
        'totalReviewUser': totalReviewUser,
        'openHours': widget.note.openHours,
        'cuisines': widget.note.cuisines,
        'goodFor': widget.note.goodFor,
        'contactName': widget.note.contactName,
        'contactEmail': widget.note.contactEmail,
        'contactNumber': widget.note.contactNumber,
        'street': widget.note.street,
        'state': widget.note.state,
        'country': widget.note.country,
        'pincode': widget.note.pincode,
        'userName': widget.note.userName,
        'status':widget.note.status,
      }).then((_) {
        _onNoteAddedSubscription =
            notesReference.onChildAdded.listen(_onNoteAdded);
        _onNoteChangedSubscription =
            notesReference.onChildChanged.listen(_onNoteUpdated);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => ListViewNote(widget.userName,widget.currentImage),
        //   ),
        // );
      });
    });

    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Thank You For The Review'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Your review has been submitted.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cool'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AllReviews(
                          reviewItems,
                        ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  _reviewForm() {
    if (widget.userName == 'Sign In' ||
        widget.userName == null ||
        widget.userName.isEmpty) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Please login to add a review",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
            ),
          ),
          RaisedButton(
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.deepOrange,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      );
    } else {
      bool reviewStatus = false;
      reviewItems.forEach((doc) {
        if (doc.userName == widget.userName) {
          reviewStatus = true;
        }
      });
      if (reviewStatus) {
        return Text(
          "You've reviewed this restaurant",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
        );
      } else {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Write Reviews",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Rate Your Experience',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Food"),
                  StarRating(
                    rating: rateFood,
                    color: Colors.deepOrange,
                    borderColor: Colors.grey,
                    size: 25.0,
                    starCount: 5,
                    onRatingChanged: (rating) => setState(() {
                          this.rateFood = rating;
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Services"),
                  StarRating(
                    rating: rateService,
                    color: Colors.deepOrange,
                    borderColor: Colors.grey,
                    size: 25.0,
                    starCount: 5,
                    onRatingChanged: (rating) => setState(() {
                          this.rateService = rating;
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Cost"),
                  StarRating(
                    rating: rateCost,
                    color: Colors.deepOrange,
                    borderColor: Colors.grey,
                    size: 25.0,
                    starCount: 5,
                    onRatingChanged: (rating) => setState(() {
                          this.rateCost = rating;
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Start Writing Your Review',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              EnsureVisibleWhenFocused(
                focusNode: _reviewFocusNode,
                child: TextFormField(
                  focusNode: _reviewFocusNode,
                  maxLines: 4,
                  maxLength: 400,
                  decoration: InputDecoration(
                    labelText: 'Write Review',
                    counterText: 'Max length: 500',
                    hintText: 'Be polite and help others make better choices.',
                  ),
                  validator: (String value) {
                    if (value.isEmpty || value.length < 10) {
                      return 'This Field cannot be empty and should be 10+ characters long.';
                    }
                  },
                  onSaved: (String value) {
                    setState(() {
                      comment = value;
                    });
                  },
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 170.0),
                color: Colors.deepOrange,
                child: Text("SUBMIT"),
                textColor: Colors.white,
                onPressed: () {
                  _formKey.currentState.validate();
                  if (rateCost < 1.0 || rateFood < 1.0 || rateService < 0) {
                    return showDialog<Null>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: new Text('Oops!!'),
                          content: new SingleChildScrollView(
                            child: new ListBody(
                              children: <Widget>[
                                new Text(
                                    'Please rate the restaurant before you submit.'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('Got It!!'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (_formKey.currentState.validate()) {
                    _submitForm();
                  }
                },
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.note.description;
    final name = widget.note.name.toUpperCase();
    final openHours = widget.note.openHours.toUpperCase();
    final cuisines = widget.note.cuisines;
    final goodFor = widget.note.goodFor;
    final contactName = widget.note.contactName;
    final contactEmail = widget.note.contactEmail;
    final contactNumber = widget.note.contactNumber;
    final street = widget.note.street;
    final city = widget.note.city;
    final state = widget.note.state;
    final country = widget.note.country;
    final pincode = widget.note.pincode;
    double overAllRating = widget.note.overAllRating;
     int totalReviewUser = widget.note.totalReviewUser;
    double costRating = widget.note.totalCost;
    double serviceRating = widget.note.totalService;
    double foodRating = widget.note.totalFood;
    final _reviewCostRecent_0 = 5.0;
    final _reviewFoodRecent_0 = 4.0;
    final _reviewServiceRecent_0 = 3.5;
    final _reviewOverAllRecent_0 =
        ((_reviewCostRecent_0 + _reviewFoodRecent_0 + _reviewServiceRecent_0) /
                3)
            .toStringAsFixed(1);
// get the data fromreview

    String comment0,
        comment1,
        userName0,
        userName1,
        profileImage0,
        profileImage1;
    int cost0, food0, service0, cost1, food1, service1;
    double overall0, overall1;
    if (reviewItems.length >= 1) {
      comment0 = reviewItems[0].comments;
      userName0 = reviewItems[0].userName;
      profileImage0 = reviewItems[0].profileImage;
      cost0 = reviewItems[0].cost;
      food0 = reviewItems[0].food;
      service0 = reviewItems[0].service;
      overall0 = (cost0 + food0 + service0) / 3;
    } else {
      comment0 = 'No Review Yet';
    }
    final _commentServiceRecent_0 = comment0;
    final _reviewCostRecent_1 = 3.5;
    final _reviewFoodRecent_1 = 5.0;
    final _reviewServiceRecent_1 = 2.5;
    final _reviewOverAllRecent_1 =
        ((_reviewCostRecent_1 + _reviewFoodRecent_1 + _reviewServiceRecent_1) /
                3)
            .toStringAsFixed(1);
    if (reviewItems.length >= 2) {
      comment1 = reviewItems[1].comments;
      userName1 = reviewItems[1].userName;
      profileImage1 = reviewItems[1].profileImage;
      cost1 = reviewItems[1].cost;
      food1 = reviewItems[1].food;
      service1 = reviewItems[1].service;
      overall1 = (cost1 + food1 + service1) / 3;
    } else {
      comment1 = 'No Review Yet';
    }
    final _commentServiceRecent_1 = comment1;
    _buildHighlightedReview0() {
      print('-------------------&&&--------');
      print(reviewItems.length);
      if (reviewItems.length > 0) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profileImage0),
          ),
          title: Text(
            userName0,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Row(
            children: <Widget>[
              Text('Rated'),
              SizedBox(
                width: 10.0,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                  child: Text(
                    overall0.toStringAsFixed(1),
                    style: TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            'No Reviews Yet. Be the first one to review',
            textAlign: TextAlign.center,
          ),
        );
      }
    }

    _buildHighlightedReviewComment0() {
      if (reviewItems.length > 0) {
        return Text(
          _commentServiceRecent_0,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        );
      } else {
        return SizedBox();
      }
    }

    _buildHighlightedReview1() {
      if (reviewItems.length > 1) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profileImage1),
          ),
          title: Text(
            userName1,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Row(
            children: <Widget>[
              Text('Rated'),
              SizedBox(
                width: 10.0,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color:totalReviewUser >0 ? Colors.deepOrange:Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                  child: Text(
                   totalReviewUser>0 ? overall1.toStringAsFixed(1):'0.0',
                    style: TextStyle(
                        color: totalReviewUser >0? Colors.deepOrange:Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return SizedBox();
      }
    }

    _buildHighlightedReviewComment1() {
      if (reviewItems.length > 1) {
        return Text(
          _commentServiceRecent_1,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        );
      } else {
        return SizedBox();
      }
    }

    _buildReadMore() {
      if (reviewItems.length > 2) {
        return FlatButton(
          child: Text(
            'Read More',
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AllReviews(
                      reviewItems,
                    ),
              ),
            );
          },
        );
      } else {
        return SizedBox();
      }
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        widget.note.image,
                        fit: BoxFit.cover,
                      )),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(icon: Icon(Icons.info_outline), text: "Info"),
                        Tab(icon: Icon(Icons.star_border), text: "Reviews"),
                      ],
                    ),
                  ),
                  // pinned: true,
                  // floating: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.right,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:totalReviewUser>0 ? Colors.deepOrange:Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.5),
                                child: Text(
                                totalReviewUser>0?  widget.note.overAllRating <= 5
                                      ? widget.note.overAllRating.toString()
                                      : '5.0':'0.0',
                                  style: TextStyle(
                                      color:totalReviewUser>0 ? Colors.deepOrange:Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Text(
                        city + ', ' + country,
                        style: TextStyle(color: Colors.grey[600]),
                      ),

                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Open Hours: ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            openHours,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Details",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            contactNumber,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          IconButton(
                            icon: Icon(Icons.call),
                            color: Colors.green,
                            onPressed: () {},
                          )
                        ],
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(5.0),
                      // ),
                      Text(
                        'Address',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(street +
                          ', ' +
                          city +
                          ', ' +
                          state +
                          ', ' +
                          country +
                          ', ' +
                          pincode),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Cuisine',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(cuisines),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Good For',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(goodFor),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'More Info',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(description),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "User Ratings",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Over All Rating"),
                          Row(
                            children: <Widget>[
                              StarRating(
                                rating: totalReviewUser>0 ?overAllRating:0.0,
                                color: Colors.deepOrange,
                                borderColor: Colors.grey,
                                size: 25.0,
                                starCount: 5,
                                // onRatingChanged: (rating) => setState(() {
                                //       this.rating = rating;
                                //     }),
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.5),
                                  child: Text(
                                   totalReviewUser>0 ? widget.note.overAllRating <= 5
                                        ? widget.note.overAllRating.toString()
                                        : '5.0':'0.0',
                                    style: TextStyle(
                                        color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Food Quality"),
                          Row(
                            children: <Widget>[
                              StarRating(
                                rating: totalReviewUser >0 ? foodRating:0.0,
                                color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey,
                                borderColor: Colors.grey,
                                size: 25.0,
                                starCount: 5,
                                // onRatingChanged: (rating) => setState(() {
                                //       this.rating = rating;
                                //     }),
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.5),
                                  child: Text(
                                    totalReviewUser >0 ? foodRating <= 5
                                        ? foodRating.toString()
                                        : '5.0':'0.0',
                                    style: TextStyle(
                                        color: totalReviewUser >0? Colors.deepOrange:Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Services"),
                          Row(
                            children: <Widget>[
                              StarRating(
                                rating: totalReviewUser >0 ?serviceRating:0.0,
                                color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey,
                                borderColor: Colors.grey,
                                size: 25.0,
                                starCount: 5,
                                // onRatingChanged: (rating) => setState(() {
                                //       this.rating = rating;
                                //     }),
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.5),
                                  child: Text(
                                    totalReviewUser >0 ? serviceRating <= 5
                                        ? serviceRating.toString()
                                        : '5.0':'0.0',
                                    style: TextStyle(
                                        color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Cost"),
                          Row(
                            children: <Widget>[
                              StarRating(
                                rating: totalReviewUser >0 ? costRating: 0.0,
                                color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey,
                                borderColor: Colors.grey,
                                size: 25.0,
                                starCount: 5,
                                // onRatingChanged: (rating) => setState(() {
                                //       this.rating = rating;
                                //     }),
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: totalReviewUser >0 ? Colors.deepOrange: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.5),
                                  child: Text(
                                   totalReviewUser >0 ? costRating <= 5
                                        ? costRating.toString()
                                        : '5.0':'0.0',
                                    style: TextStyle(
                                        color: totalReviewUser >0 ? Colors.deepOrange:Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        height: 4.0,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Higlighted Reviews",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Row(
                      // children: <Widget>[
                      _buildHighlightedReview0(),
                      _buildHighlightedReviewComment0(),
                      _buildHighlightedReview1(),
                      _buildHighlightedReviewComment1(),
                      _buildReadMore(),
                      Divider(
                        height: 4.0,
                        color: Colors.grey,
                      ),
                      _reviewForm(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}