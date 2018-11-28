import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';
import './reservation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReservationInfo extends StatefulWidget {
  final String restaurantName, restaurantOwnerEmail, restaurantId,displayName,photoURl,email;
  
  DateTime _bookingDate;
  TimeOfDay _bookingTime;
  ReservationInfo(
      this.restaurantName, this.restaurantOwnerEmail, this.restaurantId,this.displayName,this.photoURl,this.email);
  @override
  _State createState() => _State();
}

class _State extends State<ReservationInfo> {
  int _people=1;
  FirebaseUser _currentUser;
  Auth auth = new Auth();
  @override
  void initState() {
    super.initState();
    auth.userStatus().then((value) {
      setState(() {
        _currentUser = value;
      });
    });
  }

  ///time and date
  final dateFormat = DateFormat("EEEE, MM d, yy");
  final timeFormat = DateFormat("H:MM a");

  ///

  final reserveReference =
      FirebaseDatabase.instance.reference().child('myReservations');

  //Create form key
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //

  

  //current user details

  //

  void _selectPeople() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 10,
            title: new Text("Please pick the number of people"),
            initialIntegerValue: _people,
          );
        }).then((int value) {
      if (value != null) {
        print("value of people >>>>>>>>>>>>>>>>>>>>>>>>>$value");
        print("value after change${_people}");
        setState(() => _people = value);
        print("value after change${_people}");
      }
    });
  }

  Future<Null> _insertBooking() {
    _formkey.currentState.validate();
    _formkey.currentState.save();
   
     var formatter = new DateFormat('EEEE , MMM dd,yy');
  String formatted = formatter.format(widget._bookingDate);
   final bd = formatted;

  print("---------------------------formatted>>>>>>>>>>>>>>>>$bd");
    
    final String bt = widget._bookingTime.hourOfPeriod.toString()+ ':00'+' '+widget._bookingTime.period.toString();
   
    print(widget._bookingTime);
    print("final time:$bt");

var string = bt;
string.indexOf('DayPeriod.');    
int len= bt.length;       
//print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>time ") ; // 1
//print(string.indexOf(new RegExp(r'[A-Z][a-z]'))); 
//print(string.substring(0,5));
//print(string.substring(15,len));
String finalDate=string.substring(0,5)+''+string.substring(15,len);
    Map<String,dynamic>  _formData = { 'restaurant_id': widget.restaurantId,
      'restaurant_email': widget.restaurantOwnerEmail,
      'user_email': _currentUser.email,
      'booking_date': bd.toString(),
      'booking_time': finalDate,
      'no_of_people': _people,
      'date': new DateTime.now().millisecondsSinceEpoch,
      'restaurantName':widget.restaurantName
      };
      print("$_formData");
   // var newPostRef =  reserveReference.push();
   // newPostRef.set(_formData);
    //print("$newPostRef");
   // Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context) => Reservation(newPostRef) ));
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Reservation(_formData,widget.displayName,widget.photoURl,widget.email),
      ),
    );
  }

//  void _onReserveAdded(Event event)
//  {

//  }
// void _onNoteAdded(Event event) {
//     setState(() {
//       // print("---------- onNoteAdded------------- fromd details");
//       items.add(new Note.fromSnapshot(event.snapshot));
//       items.reversed;
//     });
//   }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: new AppBar(title: Text("Table Booking")),
        body: new Column(
          children: [
            new Container(
                height: 150.0,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.black)),
                child: new Padding(
                    padding: EdgeInsets.all(40.0),
                    child: new Column(
                      children: <Widget>[
                        new Row(children: [
                          new Text(
                            "Restaurant",
                            style: TextStyle(fontSize: 20.0),
                          )
                        ]),
                        SizedBox(
                          height: 20.0,
                        ),
                        new Row(
                          children: [
                            new Text(
                              widget.restaurantName,
                              style: TextStyle(fontSize: 20.0),
                            )
                          ],
                        )
                      ],
                    ))),
            // new Padding(
            // padding: EdgeInsets.all(10.0),
            new Expanded(
              child: new Container(
                child: new Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                        key: _formkey,
                        child: ListView(children: [
                          ListTile(
                            leading: Icon(Icons.date_range),
                            trailing: Padding(
                              padding: EdgeInsets.only(left: 35.0),
                              child: DateTimePickerFormField(
                                initialValue: widget._bookingDate,
                                
                                decoration: InputDecoration(
                                    labelText: 'Please pick the booking date'),
                                dateOnly: true,
                                validator: (value) {
                                  print(value);
                                },
                                
                                firstDate: new DateTime.now() ,
                                format: dateFormat,
                                onSaved: (date) {
                                  // Scaffold.of(context).showSnackBar(
                                  //     SnackBar(content: Text('$date')));
                                  widget._bookingDate = date;
                                  print("$widget._bookingDate");
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ListTile(
                            leading: Icon(Icons.access_time),
                            trailing: Padding(
                              padding: EdgeInsets.only(left: 35.0),
                              child: TimePickerFormField(
                                decoration: InputDecoration(
                                    labelText: 'Please pick the booking time'),
                                format: timeFormat,
                                onSaved: (time) {
                                  widget._bookingTime = time;
                                  print("time :$widget._bookingTime");
                                  // Scaffold.of(context).showSnackBar(
                                  //     SnackBar(content: Text('$time')));
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ListTile(
                            leading: Icon(Icons.people),
                            trailing: Padding(
                                padding: EdgeInsets.only(left: 35.0),
                                child: GestureDetector(
                                  child: Container(
                                    width: 300.0,
                                    decoration: const BoxDecoration(
                                      border: const Border(
                                        top: const BorderSide(
                                            width: 0.0, color: Colors.white),
                                        left: const BorderSide(
                                            width: 0.0, color: Colors.white),
                                        right: const BorderSide(
                                            width: 0.0, color: Colors.white),
                                        bottom: const BorderSide(
                                            width: 1.0,
                                            color: const Color(0xFFFF000000)),
                                      ),
                                    ),
                                    child: Text(_people.toString()),
                                  ),
                                  onTap: () {
                                    _selectPeople();
                                  },
                                )),
                          ),
                          SizedBox(height: 5.0),
                          RaisedButton(
                            child: Text('Submit'),
                            onPressed: () => _insertBooking(),
                          )
                        ]))),
              ),
            ),
            // new Align(
            //     child: GestureDetector(
            //   child: Container(
            //     child:
            //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //       new Text(
            //         "Reserve",
            //         style: TextStyle(
            //             color: Colors.white, fontWeight: FontWeight.bold),
            //       ),
            //     ]),
            //     height: 50.0,
            //     decoration: BoxDecoration(color: Colors.deepOrange),
            //   ),
            //   onTap: () {
            //     _reservation();
            //   },
            // ))
            // )

            // Padding(
            //   padding: EdgeInsets.all(0.0),
            //   child:new Divider(
            //     color:Colors.deepOrange
            //   )
            // )
          ],
        ));
  }
}
