import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import './listview_note.dart';
import './reservation_info.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/smtp_server/mailgun.dart';

class Reservation extends StatelessWidget {
  DatabaseReference _reservedData;
  Map<String, dynamic> _formData;
  String displayName, photoURl, email;
  Reservation(this._formData, this.displayName, this.photoURl, this.email);
// String restaurantName, restaurantOwnerEmail;
// Reservation(this.restaurantName,this.restaurantOwnerEmail);
  // _editReservationInfo(context){
  //   Navigator.push(context,MaterialPageRoute(builder:(context)=>ReservationInfo()) );
  // }
  final reserveReference =
      FirebaseDatabase.instance.reference().child('myReservations');
  Future<Null> _insertBooking(BuildContext context) async {
    print("jform data:$_formData");
    var newPostRef = reserveReference.push();
    newPostRef.set(_formData);
    String username = 'postmaster@sandboxf009e10754664ec9a6fc51ff5caf1a38.mailgun.org';
    String password = '3e843ac6553cc18a8318c93bb65ec3a5-1053eade-5afeff63';
    //String username = 'ravikumar.deligence@gmail.com';
    //String password = 'Ravideligence1@';
    final smtpServer = mailgun(username, password);
    print(">>>>>>>>>>>>>>>>>smtpServer");
    print(smtpServer);
    // Create our message.
    final message = new Message()
      ..from = new Address(username, 'ravi kumar')
    ..recipients.add('deligence2016@gmail.com')
    ..ccRecipients.addAll(['ravikumar.deligence@gmail.com', 'nitin.deligence@gmail.com'])
    ..bccRecipients.add(new Address('subham.deligence@gmail.com'))
    ..subject = 'Test Dart Mailer library :: 😀 :: ${new DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    print(">>>>>>>>>>>>>>>>message");
    print(message);
    final sendReports = await send(message, smtpServer);
    sendReports.forEach((sr) {
      if (sr.sent)
        print('Message sent');
      else {
        print('Message not sent.');
        for (var p in sr.validationProblems) {
          print('Problem: ${p.code}: ${p.msg}');

          print(p.msg);
         
        }
      }
    });

    print("book restaurant:$newPostRef");
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Bokking Info'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('We have sent your booking details to restaurant owner'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ListViewNote(
                        this.displayName, this.photoURl),
                  ),//, this.email
                );
              },
            ),
          ],
        );
      },
    );

    // Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context) => Reservation(newPostRef) ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Reservation"),
      ),
      body: new Column(children: [
        new Container(
          padding: new EdgeInsets.only(top: 16.0),
          // child:new Text("data")
          height: 200.0,
          decoration: BoxDecoration(color: Colors.grey[200]),

          child: new Column(
            children: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      height: 50.0,
                      child: new Text(
                        "We found you a table",
                        style: TextStyle(color: Colors.green),
                      ))
                ],
              ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // mainAxisSize:MainAxisSize.max ,

                children: <Widget>[
                  new Container(
                    height: 50.0,
                    child: new Column(children: [
                      new Container(
                        child: new Icon(Icons.calendar_today),
                      ),
                      new Container(
                        child: new Text(this._formData['booking_date']),
                      ),
                    ]),
                  ),
                  new Container(
                    height: 50.0,
                    child: new Column(children: [
                      new Container(
                        child: new Icon(Icons.watch_later),
                      ),
                      new Container(
                        child: new Text(this._formData['booking_time'].toUpperCase()),
                      ),
                    ]),
                  ),
                  new Container(
                    height: 50.0,
                    child: new Column(children: [
                      new Container(
                        child: new Icon(Icons.people),
                      ),
                      new Container(
                        child:
                            new Text(this._formData['no_of_people'].toString()),
                      ),
                    ]),
                  ),
                ],
              ),
              new Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                        height: 50.0,
                        child: GestureDetector(
                          child: new Text(
                            "Any Change?",
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {
                            //_editReservationInfo(context);
                            
                           Navigator.pop(context);
                          },
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Expanded(
            child: Column(children: [
          Container(
            padding: EdgeInsets.all(8.0),
            height: 300.0,
            decoration: BoxDecoration(
                // color:Colors.red
                ),
            child: new Column(children: [
              Row(
                children: <Widget>[
                  Text(
                    "RESTAURENT",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[Text(this._formData['restaurantName'])],
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[Text(this.displayName)],
              ),
            ]),
          )
        ])),
        GestureDetector(
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(color: Colors.deepOrange),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              new Text(
                "Submit",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          onTap: () {
            _insertBooking(context);

            print("reserved");
          },
        )

        //  Padding(
        //   padding: const EdgeInsets.only(top: 5.0),
        //   child: IntrinsicHeight(
        //     child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        //       Expanded(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //           Row(
        //             children: <Widget>[
        //               new Text("")
        //             ],
        //           ),
        //           Row(
        //             children: <Widget>[
        //               new Text("datadfadfadfaddfdafdfa")
        //             ],
        //           ),
        //           Container(
        //             height: 50.0, color: Colors.cyan
        //           ),
        //           Container(height: 50.0, color: Colors.red),
        //           Container(height: 50.0, color: Colors.grey),
        //           Container(height: 50.0, color: Colors.green),

        //         ]),
        //       ),
        //       Expanded(child: Container(color: Colors.amber)),
        //     ]),
        //   ),
        // ),

        // new Container(

        //   color: Colors.green,
        //   // // alignment: Alignment.topLeft,
        //   // padding: EdgeInsets.only(left: 20.0),
        //   height: 300.0,
        //   child: new Column(
        //     crossAxisAlignment:CrossAxisAlignment.start,
        //     // mainAxisAlignment: MainAxisAlignment.start,
        //     children:[
        //       // new Container(
        //       //   height: 50.0,
        //       //   color: Colors.red,
        //       //   child:new Column(
        //       //     children:[
        //       //       new Text(
        //       //         "Restaurent",
        //       //         style: TextStyle(
        //       //           fontWeight:FontWeight.bold,

        //       //         ),
        //       //       ),
        //       //       new Text(
        //       //         "balla dhaba"
        //       //       )
        //       //     ]
        //       //   ),

        //       // ),
        //       new Container(
        //         height: 100.0,
        //         color: Colors.red,
        //         // margin: EdgeInsets.only(left:0.0),
        //         alignment: Alignment.topLeft,
        //         child:new Column(

        //           children:[
        //             new Text(
        //               "Name",
        //               style: TextStyle(
        //                 fontWeight:FontWeight.bold,

        //               ),
        //                textAlign:TextAlign.left
        //             ),
        //             new Text(
        //               "ashish aggarwal"
        //             )
        //           ]
        //         ),

        //       ),

        //     ]
        //   ),
        // )
      ]),
    );
  }
}
