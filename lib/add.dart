import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import './helpers/ensure-visible.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:typed_data';
import 'dart:io';
//import 'package:typed_data/typed_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import './image.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPageState();
  }
}

class _AddPageState extends State<AddPage> {
  String _path,imagePath;
  final Map<dynamic, dynamic> _formData = {
    'contact': {'email': '', 'mobile': '', 'name': ''},
    'coords': {'latitude': '', 'longitude': ''},
    'creared_at': '',
    'created_by': '',
    'cuisine': '',
    'description': '',
    'good_for': '',
    'image': '',
    'location': {
      'city': '',
      'country': '',
      'pincode': '',
      'state': '',
      'street': ''
    },
    'modified_at': '',
    'name': '',
    'open_hour': '',
    'status': ''
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _countries = <String>[
    "Afghanistan",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "United States Of America",
    "India",
    "United Kingdom"
  ];

  void _setImage(File image) {
    _formData['image'] = image;
    imagePath=image.path;
  }


Future<Null> uploadFile(String filepath) async{
   print("filepath "+ filepath);
final ByteData bytes=await rootBundle.load(filepath);
final Directory tempDir=Directory.systemTemp;
print(">>>>>>>>>>>>>>>>>>>>>>directory ${tempDir}");
final String fileName="${Random().nextInt(10000)}.jpg";
print("random filename "+fileName);
final File file=File('${tempDir.path}/fileName');
print("file>>>>>>>>>>>>>"+file.toString());
file.writeAsBytes(bytes.buffer.asInt8List(),mode: FileMode.write);
final StorageReference ref=FirebaseStorage.instance.ref().child(fileName);
final StorageUploadTask task=ref.putFile(file);
final Uri downloadUrl=(await task.future).downloadUrl;
_path=downloadUrl.toString();
print("path "+_path);
 }

  void submitForm() {
    if (!_formKey.currentState.validate() || (_formData['image'] == null)) {
      return;
    }
    _formKey.currentState.save();
      print("selected files "+ imagePath);
      String filePath=imagePath;
      uploadFile(filePath);
      print("new path "+ _path);

    String _cuisinesSave = '';
    if (checkboxValueA) _cuisinesSave += 'South Indian, ';
    if (checkboxValueB) _cuisinesSave += 'North Indian, ';
    if (checkboxValueD) _cuisinesSave += 'East Indian, ';

    String _goodFor = '';
    if (goodFor1) _goodFor += 'Couple, ';
    if (goodFor2) _goodFor += 'Children, ';
    if (goodFor3) _goodFor += 'Business Meetings, ';

    if (goodFor4) _goodFor += 'Groups, ';

    if (goodFor5) _goodFor += 'All, ';

    _cuisinesSave = _cuisinesSave.substring(0, (_cuisinesSave.length) - 2);
    _goodFor = _goodFor.substring(0, (_goodFor.length - 2));
    //print("selected file "+ _formData['image'].toString());
 //uploadFile('/storage/emulated/0/Android/data/com.deligence.bestindianrestaurant/files/Pictures/scaled_IMG_20180831_173836.jpg');
 //print("new path "+ _path);
    final _data = {
      'contact': {
        'email': _emailTextController.text,
        'mobile': _phoneTextContoller.text,
        'name': _namePTextController.text
      },
      'coords': {'latitude': '', 'longitude': ''},
      'creared_at': '',
      'created_by': '',
      'cuisine': _cuisinesSave,
      'description': _detailTextController.text,
      'good_for': _goodFor,
      'image': _path,
      'location': {
        'city': _cityTextContoller.text,
        'country': _formData['location']['country'],
        'pincode': _pincodeTextController.text,
        'state': _stateTextController.text,
        'street': _streetTextController.text
      },
      'modified_at': '',
      'name': _nameRTextController.text,
      'open_hour': _openHourTextController.text,
      'status': ''
    };

    DatabaseReference ref = FirebaseDatabase.instance.reference();
  // uploadFile('assets/food.jpg');
    ref.child('listing').push().set(_data).then((v) {
      //Navigator.pushReplacementNamed(context, '/listing');
    });

    print(_data);
  }

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCountry;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCountry = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String country in _countries) {
      items.add(new DropdownMenuItem(value: country, child: new Text(country)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCountry) {
    setState(() {
      _currentCountry = selectedCountry;
      _formData['location']['country'] = selectedCountry;
    });
  }

  bool checkboxValueA = false;
  bool checkboxValueB = false;
  bool checkboxValueD = false;

  Widget buildCheckbox() {
    return new Container(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cuisines',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          new CheckboxListTile(
            title: Text('South Indian'),
            activeColor: Colors.deepOrange,
            value: checkboxValueA,
            onChanged: (bool value) {
              setState(() {
                checkboxValueA = value;
              });
            },
          ),
          new CheckboxListTile(
            title: Text('North Indian'),
            activeColor: Colors.deepOrange,
            value: checkboxValueB,
            onChanged: (bool value) {
              setState(() {
                checkboxValueB = value;
              });
            },
          ),
          new CheckboxListTile(
            title: Text('East Indian'),
            activeColor: Colors.deepOrange,
            value: checkboxValueD,
            onChanged: (bool value) {
              setState(() {
                checkboxValueD = value;
              });
            },
          ),
        ],
      ),
    );
  }

  bool goodFor1 = false;
  bool goodFor2 = false;
  bool goodFor3 = false;
  bool goodFor4 = false;
  bool goodFor5 = false;

  final fontSize = 18.0;

  Widget buildCheckboxGF() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Good For',
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
        new CheckboxListTile(
          title: Text('Couple'),

          activeColor: Colors.deepOrange,
          value: goodFor1,
          onChanged: (bool value) {
            setState(() {
              goodFor1 = value;
            });
          },
        ),
        new CheckboxListTile(
          title: Text('Children'),
          activeColor: Colors.deepOrange,
          value: goodFor2,
          onChanged: (bool value) {
            setState(() {
              goodFor2 = value;
            });
          },
        ),
        new CheckboxListTile(
          title: Text('Business Meetings'),
          activeColor: Colors.deepOrange,
          value: goodFor3,
          onChanged: (bool value) {
            setState(() {
              goodFor3 = value;
            });
          },
        ),
        new CheckboxListTile(
          title: Text('Groups'),
          activeColor: Colors.deepOrange,
          value: goodFor4,
          onChanged: (bool value) {
            setState(() {
              goodFor4 = value;
            });
          },
        ),
        new CheckboxListTile(
          title: Text('All'),
          activeColor: Colors.deepOrange,
          value: goodFor5,
          onChanged: (bool value) {
            setState(() {
              goodFor5 = value;
            });
          },
        ),
      ],
    );
  }

  final _nameRTextController = TextEditingController();

  Widget _buildRTextField() {
    if (_nameRTextController.text.trim() != null)
      _nameRTextController.text = _nameRTextController.text;

    return new TextFormField(
      controller: _nameRTextController,
      decoration: const InputDecoration(
        hintText: 'Enter Restaurant name',
        labelText: 'Name',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Name can not be empty and should be 5+characters long.';
        }
      },
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  final _openHourTextController = TextEditingController();

  Widget _buildOpenHourTextField() {
    if (_openHourTextController.text.trim() != null)
      _openHourTextController.text = _openHourTextController.text;

    return new TextFormField(
      maxLines: 2,
      controller: _openHourTextController,
      decoration: const InputDecoration(
        hintText: 'Sunday - 8AM-9AM, Monday - 8AM-9AM',
        labelText: 'Open Hours',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Open Hour can not be empty and should be 5+characters long.';
        }
      },
      onSaved: (String value) {
        _formData['open_hour'] = value;
      },
    );
  }

  final _stateTextController = TextEditingController();
  final _cityTextContoller = TextEditingController();
  final _pincodeTextController = TextEditingController();
  final _streetTextController = TextEditingController();

  Widget _buildLocationFields() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Located At',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          new TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Street',
              labelText: 'Street',
            ),
            controller: _streetTextController,
            validator: (String value) {
              if (value.isEmpty || value.length < 2) {
                return 'Street can not be empty and should be 2+characters long.';
              }
            },
            onSaved: (String value) {
              _formData['location']['street'] = value;
            },
          ),
          new TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter City',
              labelText: 'City',
            ),
            controller: _cityTextContoller,
            validator: (String value) {
              if (value.isEmpty || value.length < 2) {
                return 'City can not be empty and should be 2+characters long.';
              }
            },
            onSaved: (String value) {
              _formData['location']['city'] = value;
            },
          ),
          new TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter State',
              labelText: 'State',
            ),
            controller: _stateTextController,
            validator: (String value) {
              if (value.isEmpty || value.length < 2) {
                return 'State can not be empty and should be 2+characters long.';
              }
            },
            onSaved: (String value) {
              _formData['location']['state'] = value;
            },
          ),
          new TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Pincode',
              labelText: 'Pincode',
            ),
            keyboardType: TextInputType.number,
            controller: _pincodeTextController,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Pincode can not be empty.';
              }
            },
            onSaved: (String value) {
              _formData['location']['pincode'] = value;
            },
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text("Country"),
              new DropdownButton(
                value: _currentCountry,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
            ],
          ),
        ],
      ),
    );
  }

  final _namePTextController = TextEditingController();
  final _phoneTextContoller = TextEditingController();
  final _emailTextController = TextEditingController();

  Widget _buildContactInfoFields() {
    if (_namePTextController != null)
      _namePTextController.text = _namePTextController.text;

    if (_phoneTextContoller != null)
      _phoneTextContoller.text = _phoneTextContoller.text;
    if (_emailTextController != null)
      _emailTextController.text = _emailTextController.text;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contact Details',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          new TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Contact Person name',
              labelText: 'Name',
            ),
            controller: _namePTextController,
            validator: (String value) {
              if (value.isEmpty || value.length < 5) {
                return 'Contact Name can not be empty and should be 5+characters long.';
              }
            },
            onSaved: (String value) {
              _formData['contact']['name'] = value;
            },
          ),
          new TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter email address',
              labelText: 'Email',
            ),
            controller: _emailTextController,
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty ||
                  !RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
                      .hasMatch(value))
                return 'Email address can not be empty and should be in email format';
            },
            onSaved: (String value) {
              _formData['contact']['email'] = value;
            },
          ),
          new TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter phone number',
              labelText: 'Phone',
            ),
            controller: _phoneTextContoller,
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty ||
                  !RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                      .hasMatch(value))
                return 'Phone no. can not be empty and should be in proper format';
            },
            onSaved: (String value) {
              _formData['contact']['mobile'] = value;
            },
          ),
        ],
      ),
    );
  }

  final _detailTextController = TextEditingController();

  Widget _buildDetailsTextField() {
    if (_detailTextController != null)
      _detailTextController.text = _detailTextController.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Description',
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
        new TextFormField(
          maxLines: 4,
          controller: _detailTextController,
          decoration: const InputDecoration(
            hintText: 'Restaurant Details',
            labelText: 'Description',
          ),
          validator: (String value) {
            if (value.isEmpty || value.length < 5)
              return 'Description can not be empty and should be 5+ characters';
          },
          onSaved: (String value) {
            _formData['contact']['mobile'] = value;
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Restaurent'),
        backgroundColor: Colors.deepOrange,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: new SafeArea(
            top: false,
            bottom: false,
            child: new Form(
                key: _formKey,
                child: new ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    _buildRTextField(),
                    SizedBox(height: 10.0),
                    _buildOpenHourTextField(),
                    SizedBox(height: 10.0),
                    buildCheckbox(),
                    SizedBox(height: 10.0),
                    buildCheckboxGF(),
                    SizedBox(height: 10.0),
                    _buildDetailsTextField(),
                    SizedBox(height: 10.0),
                    _buildContactInfoFields(),
                    SizedBox(height: 10.0),
                    _buildLocationFields(),
                    SizedBox(height: 15.0),
                    ImageInput(_setImage),
                    SizedBox(height: 15.0),
                    new Container(
                      child: new RaisedButton(
                        color: Colors.deepOrange,
                        child: const Text('SUBMIT'),
                        textColor: Colors.white,
                        onPressed: () => submitForm(),
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ))),
      ),
    );
  }
}
