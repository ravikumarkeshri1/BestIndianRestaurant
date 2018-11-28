import 'package:flutter/material.dart';

class AllReviews extends StatelessWidget {
  final List reviewItems;
  AllReviews(
    this.reviewItems,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:
          AppBar(title: Text('Reviews'), backgroundColor: Colors.deepOrange),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final _reviewOverAll = ((reviewItems[index].cost +
                      reviewItems[index].food +
                      reviewItems[index].service) /
                  3)
              .toStringAsFixed(1);
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(reviewItems[index].profileImage),
                  ),
                  title: Text(
                    reviewItems[index].userName,
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
                  reviewItems[index].comments,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
        itemCount: reviewItems.length,
      ),
    );
  }
}
