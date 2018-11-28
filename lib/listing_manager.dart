import 'package:flutter/material.dart';
import './listing_details.dart';

class ListingManager extends StatelessWidget {
  final List<Map<dynamic, dynamic>> fetchedProductList;
  final List<Map<dynamic, dynamic>> fetchListingId;
  final String userName,email;
  ListingManager(this.fetchedProductList, this.fetchListingId, this.userName,this.email);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
          margin: EdgeInsets.all(10.0),
          
          child: Column(
            children: <Widget>[
              // TextField(
              //   maxLines: 1,
              //   decoration: InputDecoration(labelText: 'Search By City'),
              //   onChanged: (String value) {},
              // ),
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
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    Text('>>'),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 160.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 80.0),
                          ),
                          // SizedBox(height: 20.0),
                          Image(
                            image: NetworkImage(fetchedProductList[0]['image']),
                            fit: BoxFit.cover,
                            width: 150.0,
                            height: 100.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            fetchedProductList[0]['name'],
                            textAlign: TextAlign.left,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange, width: 1.0),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 2.5),
                              child: Text("5.0",
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 80.0),
                          ),
                          // SizedBox(height: 20.0),
                          Image(
                            image: NetworkImage(fetchedProductList[1]['image']),
                            fit: BoxFit.cover,
                            width: 150.0,
                            height: 100.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            fetchedProductList[1]['name'],
                            textAlign: TextAlign.left,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange, width: 1.0),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 2.5),
                              child: Text("5.0",
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 80.0),
                          ),
                          // SizedBox(height: 20.0),
                          Image(
                            image: NetworkImage(fetchedProductList[2]['image']),
                            fit: BoxFit.cover,
                            width: 150.0,
                            height: 100.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            fetchedProductList[2]['name'],
                            textAlign: TextAlign.left,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange, width: 1.0),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 2.5),
                              child: Text(
                                "5.0",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 80.0),
                          ),
                          // SizedBox(height: 20.0),
                          Image(
                            image: NetworkImage(fetchedProductList[3]['image']),
                            fit: BoxFit.cover,
                            width: 150.0,
                            height: 100.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            fetchedProductList[3]['name'],
                            textAlign: TextAlign.left,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange, width: 1.0),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 2.5),
                              child: Text(
                                "5.0",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //tile start
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Top Rated",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                  Text(''),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              new Expanded(
                  child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      ListTile(
                        leading: Container(
                          width: 100.0,
                          height: 80.0,
                          decoration: new BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: new DecorationImage(
                              image: new NetworkImage(
                                  fetchedProductList[index]['image']),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(6.0)),
                          ),
                        ),
                        title: Text(fetchedProductList[index]['name']),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(fetchedProductList[index]['location']['city']),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.deepOrange, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.5),
                                child: Text(
                                  fetchedProductList[index]['overAllRating']
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          String tappedListingId =
                              fetchedProductList[index]['listingId'];
                          List<Map<dynamic, dynamic>> tappedListingReviews = [];
                          print(tappedListingReviews);
                          fetchListingId.forEach((doc) {
                            if (doc['listing_id'] == tappedListingId) {
                              tappedListingReviews.add(doc);
                            }
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ListingDetail(
                                  fetchedProductList[index],
                                  tappedListingReviews,userName,email),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.deepOrange,
                      )
                    ],
                  );
                },
                itemCount: fetchedProductList.length,
              ))
            ],
          )),
    );
  }
}
