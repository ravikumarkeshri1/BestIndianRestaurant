// import 'package:firebase_database/firebase_database.dart';

// class Note {
//   String _id;
//   String _name;
//   String _openHours;
//   String _cuisines;
//   String _goodFor;
//   String _description;
//   String _contactName;
//   String _contactEmail;
//   String _contactNumber;
//   String _street;
//   String _city;
//   String _state;
//   String _country;
//   String _pincode;
//   String _image;
//  String _userName;
//   double _totalCost;
//   double _totalService;
//   double _totalFood;
//   double _overAllRating;
//   int _totalReviewUser;
//   int _status;

//   Note(this._id, this._name, this._description,this._image,this._totalCost,this._totalFood,this._totalService,this._overAllRating,this._totalReviewUser,this._userName,this._status);

//   Note.map(dynamic obj) {
//     this._id = obj['id'];
//     this._name = obj['name'];
//     this._openHours = obj['openHours'];
//     this._cuisines = obj['cuisines'];
//     this._goodFor = obj['goodFor'];
//     this._contactName = obj['contactName'];
//     this._contactEmail = obj['contactEmail'];
//     this._contactNumber = obj['contactNumber'];
//     this._street = obj['street'];
//     this._city = obj['city'];
//     this._state = obj['state'];
//     this._country = obj['country'];
//     this._pincode = obj['pincode'];
//     this._description = obj['description'];
//      this._city = obj['city'];
//     this._image = obj['image'];
//     this._totalCost=obj['totalCost'];
//     this._totalFood=obj['totalFood'];
//     this._totalService=obj['totalService'];
//     this._overAllRating=obj['overAllRating'];
//     this._totalReviewUser=obj['totalReviewUser'];
//     this._userName= obj['userName'];
//     this._status=obj['status'];
//   }

//   String get id => _id;
//   String get name => _name;
//   String get openHours => _openHours;
//   String get cuisines => _cuisines;
//   String get goodFor => _goodFor;
//   String get contactName => _contactName;
//   String get contactEmail => _contactEmail;
//   String get contactNumber => _contactNumber;
//   String get street => _street;
//   String get city => _city;
//   String get state => _state;
//   String get country => _country;
//   String get pincode => _pincode;
//   String get description => _description;
  
//   String get image => _image;
//   double get totalCost => _totalCost;
//   double get totalFood => _totalFood;
//   double get totalService => _totalService;
//   double get overAllRating => _overAllRating;
//   int get totalReviewUser => _totalReviewUser;
//    int get status => _status;
//   String get userName => _userName;

//   Note.fromSnapshot(DataSnapshot snapshot) {
//     _id = snapshot.key;
//     _name = snapshot.value['name'];
//     _openHours = snapshot.value['openHours'];
//     _cuisines = snapshot.value['cuisines'];
//     _goodFor = snapshot.value['goodFor'];
//     _contactName = snapshot.value['contactName'];
//     _contactEmail = snapshot.value['contactEmail'];
//     _contactNumber = snapshot.value['contactNumber'];
//     _street = snapshot.value['street'];
//     _city = snapshot.value['city'];
//     _state = snapshot.value['state'];
//     _country = snapshot.value['country'];
//     _pincode = snapshot.value['pincode'];
//     _description = snapshot.value['description'];
    
//     _image = snapshot.value['image'];
//     _totalCost= snapshot.value['totalCost'];
//     _totalFood= snapshot.value['totalFood'];
//     _totalService=snapshot.value['totalService'];
//     _overAllRating=snapshot.value['overAllRating'];
//     _totalReviewUser=snapshot.value['totalReviewUser'];
//     _userName=snapshot.value['userName'];
//     _status=snapshot.value['status'];
    
//   }
// }


import 'package:firebase_database/firebase_database.dart';

class Note {
  String _id;
  String _name;
  String _openHours;
  String _cuisines;
  String _goodFor;
  String _description;
  String _contactName;
  String _contactEmail;
  String _contactNumber;
  String _street;
  String _city;
  String _state;
  String _country;
  String _pincode;
  String _image;
 String _userName;
  dynamic _totalCost;
  dynamic _totalService;
  dynamic _totalFood;
  dynamic _overAllRating;
  int _totalReviewUser;
  int _status;

  Note(this._id, this._name, this._description,this._image,this._totalCost,this._totalFood,this._totalService,this._overAllRating,this._totalReviewUser,this._userName,this._status);
  Note.update(
    this._id,this._name,this._openHours,this._cuisines,
    this._goodFor,this._description,this._contactEmail,
    this._contactNumber,this._street,this._city,this._state,
    this._country,this._pincode,this._image,this._userName,
    this._totalCost,this._totalService,this._totalFood,
    this._overAllRating,this._totalReviewUser,this._status
  );
  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._openHours = obj['openHours'];
    this._cuisines = obj['cuisines'];
    this._goodFor = obj['goodFor'];
    this._contactName = obj['contactName'];
    this._contactEmail = obj['contactEmail'];
    this._contactNumber = obj['contactNumber'];
    this._street = obj['street'];
    this._city = obj['city'];
    this._state = obj['state'];
    this._country = obj['country'];
    this._pincode = obj['pincode'];
    this._description = obj['description'];
     this._city = obj['city'];
    this._image = obj['image'];
    this._totalCost=obj['totalCost'];
    this._totalFood=obj['totalFood'];
    this._totalService=obj['totalService'];
    this._overAllRating=obj['overAllRating'];
    this._totalReviewUser=obj['totalReviewUser'];
    this._userName= obj['userName'];
    this._status=obj['status'];
  }

  String get id => _id;
  String get name => _name;
  String get openHours => _openHours;
  String get cuisines => _cuisines;
  String get goodFor => _goodFor;
  String get contactName => _contactName;
  String get contactEmail => _contactEmail;
  String get contactNumber => _contactNumber;
  String get street => _street;
  String get city => _city;
  String get state => _state;
  String get country => _country;
  String get pincode => _pincode;
  String get description => _description;
  
  String get image => _image;
  dynamic get totalCost => _totalCost;
  dynamic get totalFood => _totalFood;
  dynamic get totalService => _totalService;
  dynamic get overAllRating => _overAllRating;
  int get totalReviewUser => _totalReviewUser;
   int get status => _status;
  String get userName => _userName;

  Note.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _openHours = snapshot.value['openHours'];
    _cuisines = snapshot.value['cuisines'];
    _goodFor = snapshot.value['goodFor'];
    _contactName = snapshot.value['contactName'];
    _contactEmail = snapshot.value['contactEmail'];
    _contactNumber = snapshot.value['contactNumber'];
    _street = snapshot.value['street'];
    _city = snapshot.value['city'];
    _state = snapshot.value['state'];
    _country = snapshot.value['country'];
    _pincode = snapshot.value['pincode'];
    _description = snapshot.value['description'];
    
    _image = snapshot.value['image'];
    _totalCost= snapshot.value['totalCost'];
    _totalFood= snapshot.value['totalFood'];
    _totalService=snapshot.value['totalService'];
    _overAllRating=snapshot.value['overAllRating'];
    _totalReviewUser=snapshot.value['totalReviewUser'];
    _userName=snapshot.value['userName'];
    _status=snapshot.value['status'];
    
  }
  
}
