import 'package:flutter/material.dart';
import './listing_details.dart';
import './update_screen.dart';

class ListingManagerByQuery extends StatelessWidget {
  final List items;
  final String userName, currentImage;
  final String country;
  ListingManagerByQuery(
      this.items, this.userName, this.currentImage, this.country);

  _buildAppBarTitle() {
    if (country == 'My Restaurant') {
      return Text(country);
    } else {
      return Text('Top Restaurants in $country');
    }
  }

  final String appBarTitle = 'Top Restaurants in';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: _buildAppBarTitle(), backgroundColor: Colors.deepOrange),
      body: GestureDetector(
        // margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
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
                              image: new NetworkImage(items[index].image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(6.0)),
                          ),
                        ),
                        title: Text(items[index].name),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(items[index].city),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: items[index].totalReviewUser>0 ? Colors.deepOrange:Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.5),
                                child: Text(
                                  items[index].totalReviewUser>0 ? items[index].overAllRating>5?'5.0': items[index].overAllRating.toString():'0.0',
                                  style: TextStyle(
                                      color: items[index].totalReviewUser>0 ?Colors.deepOrange: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListingDetail(
                                      items[index],
                                      userName,
                                      currentImage,
                                    ),
                              ),
                            ),
                      ),
                     new GestureDetector(

                              
                              onTap:() => 
                                  // print("item to be update ${items[index]}")
                                  Navigator.push(context,MaterialPageRoute(
                                    builder: (context) => UpdateScreen(userName,items[index],currentImage)),
                                  ),
                                
                            child :country == 'My Restaurant'?ButtonTheme( minWidth: 5.0,height: 10.0, child: new FlatButton(
                                
                                // padding: EdgeInsets.all(2.0),
                                child:new Icon(Icons.edit),
                                // color:Colors.deepOrange,
                                // textColor: Colors.white,
                                onPressed: ()=>
                                  Navigator.push(context,MaterialPageRoute(
                                    builder: (context) => UpdateScreen(userName,items[index],currentImage)),
                                  ),
                              )):Text(""),
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
                itemCount: items.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
