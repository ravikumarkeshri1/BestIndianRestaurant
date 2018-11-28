import 'package:firebase_database/firebase_database.dart';

class Review {
  String _id;
  String _comments;
  int _cost;
  int _food;
  int _service;
  int _status;
  String _userName;
  //String _createdAt;
  String _listing_id;
  String _profileImage;

  Review(this._id, this._comments, this._cost, this._food, this._service,
      this._userName,  this._listing_id,this._profileImage);

  Review.map(dynamic obj) {
    this._id = obj['id'];
    this._comments = obj['comments'];
    this._cost = obj['cost'];
    this._food = obj['food'];
    this._service = obj['service'];
    this._status = obj['status'];
    this._userName = obj['userName'];
    //this._createdAt = obj['createdAt'];
    this._listing_id = obj['listing_id'];
    this._profileImage = obj['profileImage'];
  }

  String get id => _id;
  String get comments => _comments;
  int get cost => _cost;
  int get food => _food;
  int get service => _service;
  int get status => _status;
  String get userName => _userName;
  //String get createdAt => _createdAt;
  String get listing_id => _listing_id;
  String get profileImage => _profileImage;

  Review.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _comments = snapshot.value['comments'];
    _cost = snapshot.value['cost'];
    _food = snapshot.value['food'];
    _service = snapshot.value['service'];
    _status = snapshot.value['status'];
    _userName = snapshot.value['userName'];

    //_createdAt = snapshot.value['createdAt'];
    _listing_id = snapshot.value['listing_id'];
    _profileImage = snapshot.value['profileImage'];
    // print("hello listing_id>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+ snapshot.value['listing_id'].toString());
    //  print("hello cost>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+ snapshot.value['cost'].toString());
    //  print("hello comments>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+ snapshot.value['comments'].toString());
    //   print("hello userName>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+ snapshot.value['userName'].toString());
  }
}
