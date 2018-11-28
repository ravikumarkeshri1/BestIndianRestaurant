import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './listview_note.dart';
import '../model/note.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:typed_data';
import 'dart:io';

//import 'package:typed_data/typed_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import './image.dart';
import './image.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  String userName, currentImage;
  NoteScreen(this.note, this.userName, this.currentImage);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

final notesReference =
    FirebaseDatabase.instance.reference().child('myRestaurantListing');

class _NoteScreenState extends State<NoteScreen> {
  String _path, imagePath;

  void _setImage(File image) {
    imagePath = image.path;
    print("imagePath " + imagePath);
  }

  Future<Null> insertRestaurantListing(
      String filepath,
      String title,
      String description,
      String city,
      String openHours,
      String cuisines,
      String goodFor,
      String contactName,
      String contactEmail,
      String contactNumber,
      String street,
      String state,
      String country,
      String pincode) async {
    print("filepath>>> " + filepath);
    final ByteData bytes = await rootBundle.load(filepath);
  
    final Directory tempDir = Directory.systemTemp;
   
    print("directore>>>"+tempDir.toString());
    final String fileName = "${Random().nextInt(10000)}.jpg";
print("fileName>>>"+fileName.toString());
String test="/data/user/0/com.deligence.bestindianrestaurant/cache";
    final File file = File('${test}/${fileName}');
print("file>>>>"+file.toString());
    file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);
    final StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    print("test1>>>>>>>>>>>>>>>>>>>test1");
    final StorageUploadTask task = ref.putFile(file);
    print("test2>>>>>>>>>>>>>>>test2");
    final Uri downloadUrl = (await task.future).downloadUrl;
    _path = downloadUrl.toString();
    print("file path>>>> " + _path);

    notesReference.push().set({
      'name': title,
      'description': description,
      'city': city,
      'image': _path,
      'totalCost': 0,
      'totalFood': 0,
      'totalService': 0,
      'overAllRating': 0,
      'totalReviewUser': 0,
      'openHours': openHours,
      'cuisines': cuisines,
      'goodFor': goodFor,
      'contactName': contactName,
      'contactEmail': contactEmail,
      'contactNumber': contactNumber,
      'street': street,
      'state': state,
      'country': country,
      'pincode': pincode,
      'userName': widget.userName,
      'status':0
    }).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ListViewNote(widget.userName, widget.currentImage),
        ),
      );
    });
  }

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _cityController;
  TextEditingController _openHourController;
  TextEditingController _cuisinesController;
  TextEditingController _goodForController;
  TextEditingController _contactNameController;
  TextEditingController _contactEmailController;
  TextEditingController _contactPhoneController;
  TextEditingController _streetController;
  TextEditingController _stateController;
  TextEditingController _countryController;
  TextEditingController _pincodeController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.note.name);
    _descriptionController =
        new TextEditingController(text: widget.note.description);
    _cityController = new TextEditingController(text: widget.note.city);
    _openHourController =
        new TextEditingController(text: widget.note.openHours);
    _cuisinesController = new TextEditingController(text: widget.note.cuisines);
    _goodForController = new TextEditingController(text: widget.note.goodFor);
    _contactNameController =
        new TextEditingController(text: widget.note.contactName);
    _contactEmailController =
        new TextEditingController(text: widget.note.contactEmail);
    _contactPhoneController =
        new TextEditingController(text: widget.note.contactNumber);
    _streetController = new TextEditingController(text: widget.note.street);
    _stateController = new TextEditingController(text: widget.note.state);
    _countryController = new TextEditingController(text: widget.note.country);
    _pincodeController = new TextEditingController(text: widget.note.pincode);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Restaurant'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Restaurant Details',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Name can not be empty.';
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _openHourController,
                decoration: InputDecoration(labelText: 'Open Hours'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Open Hours can not be empty. Ex 11AM - 3PM, 7PM - 1AM';
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _cuisinesController,
                decoration: InputDecoration(labelText: 'Cuisines'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Description can not be empty.';
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _goodForController,
                decoration: InputDecoration(labelText: 'Good For'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "'Good For' can not be empty. Ex. Family, Corporate, couple";
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                maxLines: 3,
                maxLength: 300,
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Description can not be empty.';
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Contact Details',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              TextFormField(
                controller: _contactNameController,
                decoration: InputDecoration(labelText: 'Contact Person Name'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Contact Person can not be empty.';
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _contactEmailController,
                decoration: InputDecoration(labelText: 'Email Id'),
                validator: (String value) {
                  if (value.isEmpty ||
                      !RegExp(r'[\w-]+@([\w-]+\.)+[\w-]+').hasMatch(value)) {
                    return 'Email is required and pattern ex. brad@deligence.com.';
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _contactPhoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (String value) {
                  if (value.isEmpty || value.length < 8) {
                    return 'Number can not be empty and should be 8+characters long.';
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Located At',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Street'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Street can not be empty.';
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'City can not be empty.';
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Country can not be empty.';
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Pincode'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Pincode can not be empty.';
                  }
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ImageInput(_setImage),
              SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                color: Colors.deepOrange,
                child: (widget.note.id != null)
                    ? Text('Update')
                    : Text(
                        'ADD',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                onPressed: () {
                  _formKey.currentState.validate();
                  if (_formKey.currentState.validate()) {
                  insertRestaurantListing(
                    imagePath,
                    _titleController.text,
                    _descriptionController.text,
                    _cityController.text,
                    _openHourController.text,
                    _cuisinesController.text,
                    _goodForController.text,
                    _contactNameController.text,
                    _contactEmailController.text,
                    _contactPhoneController.text,
                    _streetController.text,
                    _stateController.text,
                    _countryController.text,
                    _pincodeController.text,
                  );
                  
                    return showDialog<Null>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: new Text('Voila!! '),
                          content: new SingleChildScrollView(
                            child: new ListBody(
                              children: <Widget>[
                                new Text(
                                    'Your restaurant will be added to our list after verification'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            // new FlatButton(
                            //   child: new Text('Awesome'),
                            //   onPressed: () {
                            //     // Navigator.of(context).pop();
                            //   },
                            // ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
