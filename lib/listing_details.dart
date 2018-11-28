import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import './helpers/ensure-visible.dart';
import 'package:firebase_database/firebase_database.dart';
import './all_listing_reviews.dart';
import './model/review.dart';

class ListingDetail extends StatefulWidget {
  final Map<dynamic, dynamic> fetchedProductList;
  final List<Map<dynamic, dynamic>> tappedListingReviews;
  final String userName, email;
  ListingDetail(this.fetchedProductList, this.tappedListingReviews,
      this.userName, this.email);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListingDetailState();
  }
}

class _ListingDetailState extends State<ListingDetail> {
  double rateFood = 0.0;
  double rateService = 0.0;
  double rateCost = 0.0;
  double rateOverAll = 0.0;
  String comment = '';
  final _reviewFocusNode = FocusNode();
  bool reviewStatus = false;
  _submitForm() {
    _formKey.currentState.save();
    final Map<String, dynamic> review = {
      'userName': widget.userName,
      'cost': rateCost,
      'food': rateFood,
      'service': rateService,
      'comments': comment,
      'listing_id': widget.fetchedProductList['listingId'],
      "status": "",
      "email": widget.email
    };
    

    print(review);
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    ref.child('reviews').push().set(review).then((v) {});
    widget.tappedListingReviews.add(review);
  }

  _reviewForm() {
    widget.tappedListingReviews.forEach((doc) {
      if (doc['userName'] == 'Rishabh') {
        reviewStatus = true;
      }
    });

    if (reviewStatus == false) {
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
                    labelText: 'Review', counterText: 'Max length: 500', hintText: 'Be polite.',),
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
                _submitForm();
                setState(() {
                  reviewStatus = true;
                });
              },
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Text("Thanks For Your Review"),
        ),
      );
    }

  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  print(widget.tappedListingReviews);
    
    double overAllRating = widget.fetchedProductList['overAllRating'];
    double costRating = widget.fetchedProductList['costRating'];
    double foodRating = widget.fetchedProductList['foodRating'];
    double serviceRating = widget.fetchedProductList['serviceRating'];
    final city = widget.fetchedProductList['location']['city'].toUpperCase();
    final street =
        widget.fetchedProductList['location']['street'].toUpperCase();
    final country =
        widget.fetchedProductList['location']['country'].toUpperCase();
    final pincode = widget.fetchedProductList['location']['pincode'].toString();
    final _reviewCostRecent_0 = widget.tappedListingReviews[0]['cost'];
    final _reviewFoodRecent_0 = widget.tappedListingReviews[0]['food'];
    final _reviewServiceRecent_0 = widget.tappedListingReviews[0]['service'];
    final _reviewOverAllRecent_0 =
        ((_reviewCostRecent_0 + _reviewFoodRecent_0 + _reviewServiceRecent_0) /
                3)
            .toStringAsFixed(1);
    final _commentServiceRecent_0 = widget.tappedListingReviews[0]['comments'];
    final _reviewCostRecent_1 = widget.tappedListingReviews[1]['cost'];
    final _reviewFoodRecent_1 = widget.tappedListingReviews[1]['food'];
    final _reviewServiceRecent_1 = widget.tappedListingReviews[1]['service'];
    final _reviewOverAllRecent_1 =
        ((_reviewCostRecent_1 + _reviewFoodRecent_1 + _reviewServiceRecent_1) /
                3)
            .toStringAsFixed(1);
    final _commentServiceRecent_1 = widget.tappedListingReviews[1]['comments'];
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
                      title: Text(widget.fetchedProductList['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        widget.fetchedProductList['image'],
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
                            widget.fetchedProductList['name'],
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.right,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.deepOrange, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.5),
                                child: Text(
                                  widget.fetchedProductList['overAllRating']
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.deepOrange,
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
                            widget.fetchedProductList['open_hour'],
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
                            widget.fetchedProductList['contact']['mobile'],
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
                      Text(widget.fetchedProductList['cuisine']),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Good For',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(widget.fetchedProductList['good_for']),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'More Info',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(widget.fetchedProductList['description']),
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
                                rating: overAllRating,
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
                                        color: Colors.deepOrange, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.5),
                                  child: Text(
                                    widget.fetchedProductList['overAllRating']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.deepOrange,
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
                                rating: foodRating,
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
                                        color: Colors.deepOrange, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.5),
                                  child: Text(
                                    foodRating.toString(),
                                    style: TextStyle(
                                        color: Colors.deepOrange,
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
                                rating: serviceRating,
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
                                        color: Colors.deepOrange, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.5),
                                  child: Text(
                                    serviceRating.toString(),
                                    style: TextStyle(
                                        color: Colors.deepOrange,
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
                                rating: costRating,
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
                                        color: Colors.deepOrange, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.5),
                                  child: Text(
                                    costRating.toString(),
                                    style: TextStyle(
                                        color: Colors.deepOrange,
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
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/-Te_Kez8z7ts/AAAAAAAAAAI/AAAAAAAAAAA/APUIFaOqldsKQzZs8Oq5ojZw5ys8wIt1_Q/s96-c/photo.jpg'),
                        ),
                        title: Text(
                          'Rishabh Jain',
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
                                  border: Border.all(
                                      color: Colors.deepOrange, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.5),
                                child: Text(
                                  _reviewOverAllRecent_0.toString(),
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _commentServiceRecent_0,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/-Te_Kez8z7ts/AAAAAAAAAAI/AAAAAAAAAAA/APUIFaOqldsKQzZs8Oq5ojZw5ys8wIt1_Q/s96-c/photo.jpg'),
                        ),
                        title: Text(
                          'Ravi Kumar',
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
                                  border: Border.all(
                                      color: Colors.deepOrange, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.5),
                                child: Text(
                                  _reviewOverAllRecent_1.toString(),
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _commentServiceRecent_1,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                      FlatButton(
                        child: Text(
                          'Read More',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => AllReviews(
                                  widget.tappedListingReviews,
                                  widget.fetchedProductList['name']),
                            ),
                          );
                        },
                      ),
                      Divider(
                        height: 4.0,
                        color: Colors.grey,
                      ),
                      _reviewForm()
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
