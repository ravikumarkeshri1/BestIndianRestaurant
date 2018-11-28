import 'package:flutter/material.dart';

class AllReviews extends StatelessWidget {
  final List<Map<dynamic, dynamic>> tappedListingReviews;
  final String fetchedProductListName;
  AllReviews(this.tappedListingReviews, this.fetchedProductListName);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(fetchedProductListName),
          backgroundColor: Colors.deepOrange),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final _reviewOverAll = ((tappedListingReviews[index]['cost'] +
                  tappedListingReviews[index]['food'] +
                  tappedListingReviews[index]['service']) /
              3).toStringAsFixed(1);
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                            _reviewOverAll.toString(),
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
                  tappedListingReviews[index]['comments'],
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
        itemCount: tappedListingReviews.length,
      ),
    );
  }
}