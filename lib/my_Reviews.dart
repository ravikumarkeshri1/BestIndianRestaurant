import 'package:flutter/material.dart';
import './listing_details.dart';

class MyReviews extends StatelessWidget {
  final List<Map<dynamic, dynamic>> fetchedProductList;
  List<Map<dynamic, dynamic>> fetchListingId;
  String userName, currentImage,email;
  MyReviews(this.fetchedProductList, this.fetchListingId,
      this.userName, this.currentImage,this.email); 
  

  @override
  Widget build(BuildContext context) {
    print(
        "BUILD >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>BUILD");
        print(fetchedProductList);
         print(fetchListingId);
    return new Scaffold(
      appBar: AppBar(
          title: Text('My Review'),
          backgroundColor: Colors.deepOrange),
      body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              // TextField(
              //   maxLines: 1,
              //   decoration: InputDecoration(labelText: 'Search By City'),
              //   onChanged: (String value) {},
              // ),

              //tile start
              SizedBox(
                height: 20.0,
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
