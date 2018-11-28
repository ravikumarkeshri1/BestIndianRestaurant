import 'package:flutter/material.dart';
import '../model/note.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './image.dart';
import 'dart:io';
import './listview_note.dart';
import 'dart:math';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_storage/firebase_storage.dart';

class UpdateScreen extends StatefulWidget {
//  final List item;

  Note item;
  String userName, userEmail,currentImage;

  UpdateScreen(this.userName, this.item,this.currentImage);

  @override
  _State createState() => _State();
}

class _State extends State<UpdateScreen> {
  Note note;

  TextEditingController nameController;
  TextEditingController openHourController;
  TextEditingController cuisinesController;
  TextEditingController goodForController;
  TextEditingController descriptionController;
  TextEditingController contactNameController;
  TextEditingController contactEmailController;
  TextEditingController contactPhoneController;
  TextEditingController streetController;
  TextEditingController cityController;
  TextEditingController countryController;
  TextEditingController pincodeController;

  // TextEditingController stateController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final notesReference =
      FirebaseDatabase.instance.reference().child('myRestaurantListing');
  String _path = null, imagePath = null;
  void _setImage(File image) {
    imagePath = image.path;
    print("imagePath " + imagePath);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("url of image ${widget.item.image}");
    // note = new Note("","","","","","","","","")
    nameController = new TextEditingController(text: widget.item.name);
    openHourController = new TextEditingController(text: widget.item.openHours);
    cuisinesController = new TextEditingController(text: widget.item.cuisines);
    goodForController = new TextEditingController(text: widget.item.goodFor);
    descriptionController =
        new TextEditingController(text: widget.item.description);
    contactNameController =
        new TextEditingController(text: widget.item.contactName);
    contactEmailController =
        new TextEditingController(text: widget.item.contactEmail);
    contactPhoneController =
        new TextEditingController(text: widget.item.contactNumber);
    streetController = new TextEditingController(text: widget.item.street);
    cityController = new TextEditingController(text: widget.item.city);
    countryController = new TextEditingController(text: widget.item.country);
    pincodeController = new TextEditingController(text: widget.item.pincode);

    print("Item to be updated ${widget.item}");
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    // myController.dispose();
    super.dispose();
  }

  Future updateRestaurent() async {
    print("calling updateRestaurent--------------------------------------");
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

    // //  if (imagePath != null) {
    //     // print("filepath>>> " + filepath);
    //     final ByteData bytes = await rootBundle.load(imagePath);

    //     final Directory tempDir = Directory.systemTemp;

    //     // print("directore>>>"+tempDir.toString());
    //     final String fileName = "${Random().nextInt(10000)}.jpg";
    //     // print("fileName>>>"+fileName.toString());
    //     String test = "/data/user/0/com.deligence.bestindianrestaurant/cache";
    //     final File file = File('${test}/${fileName}');
    //     // print("file>>>>"+file.toString());
    //     file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);
    //     final StorageReference ref =
    //         FirebaseStorage.instance.ref().child(fileName);
    //     // print("test1>>>>>>>>>>>>>>>>>>>test1");
    //     //final StorageUploadTask task = ref.putFile(file);
    //     // print("test2>>>>>>>>>>>>>>>test2");
    //     // final Uri downloadUrl = (await task.future).downloadUrl;

    //     String downloadUrl;
    //     // await ref.putFile(file).onComplete.then((val) {
    //     //   val.ref.getDownloadURL().then((val) {
    //     //     print(val);
    //     //     downloadUrl = val; //Val here is Already String
    //     //     _path = downloadUrl.toString();
        print("-------------------------------- item id------------------------");
        print(widget.item.id);
        print(widget.item.image);

            notesReference.child(widget.item.id).set({
              'name': nameController.text,
              'description': descriptionController.text,
              'city': cityController.text,
              'image': _path == null ? widget.item.image : _path,
              'totalCost': widget.item.totalCost,
              'totalFood': widget.item.totalFood,
              'totalService': widget.item.totalService,
              'overAllRating': widget.item.overAllRating,
              'totalReviewUser': widget.item.totalReviewUser,
              'openHours': openHourController.text,
              'cuisines': cuisinesController.text,
              'goodFor': goodForController.text,
              'contactName': contactNameController.text,
              'contactEmail': contactEmailController.text,
              'contactNumber': contactPhoneController.text,
              'street': streetController.text,
              'state': widget.item.state,
              'country': countryController.text,
              'pincode': pincodeController.text,
              'userName': widget.userName,
              'status': widget.item.status,
            });
            //  save our form now.
            print("Update successfully");
            return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Update Info'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Your Restaurant details has been updated successfully'),
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
                        widget.userName, widget.currentImage),
                  ),//, this.email
                );
              },
            ),
          ],
        );
      },
    );
            Navigator.pop(context);
         // });
       // });

       
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Update Restaurent"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
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
                // controller: _titleController,

                controller: nameController,

                // initialValue:widget.item.name,
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
                controller: openHourController,
                // initialValue:widget.item.openHours,
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
                controller: cuisinesController,
                // initialValue:widget.item.cuisines,
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
                controller: goodForController,
                // initialValue:widget.item.goodFor,
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
                controller: descriptionController,
                // initialValue:widget.item.description,
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
                controller: contactNameController,
                // initialValue:widget.item.userName,
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
                controller: contactEmailController,
                // initialValue:widget.item.contactEmail,
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
                controller: contactPhoneController,
                // initialValue:widget.item.contactNumber,
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
                controller: streetController,
                // initialValue:widget.item.street,
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
                controller: cityController,
                // initialValue:widget.item.city,
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
                controller: countryController,
                // initialValue:widget.item.country,
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
                controller: pincodeController,
                // initialValue:widget.item.pincode,
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
           //   ImageInput(_setImage, widget.item.image, "update"),
              SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                color: Colors.deepOrange,
                child: Text("Update", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  updateRestaurent();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
