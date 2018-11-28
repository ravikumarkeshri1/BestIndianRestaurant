import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './helpers/ensure-visible.dart';

class ImageInput extends StatefulWidget {
  final Function setImage;
  ImageInput(this.setImage);
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
       setState(() {
        _imageFile = image;
      });
      widget.setImage(image);
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text('Pick an Image'),
                SizedBox(height: 10.0),
                FlatButton(
                    onPressed: () {
                      _getImage(context, ImageSource.camera);
                    },
                    child: Text('Use Camara'),
                    color: Theme.of(context).primaryColor),
                SizedBox(height: 5.0),
                FlatButton(
                    onPressed: () {
                      _getImage(context, ImageSource.gallery);
                    },
                    child: Text('Use Gallery'),
                    color: Theme.of(context).primaryColor)
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).accentColor;
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(width: 2.0, color: buttonColor),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(width: 5.0),
              Text(
                'Add Image',
                style: TextStyle(color: buttonColor),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _imageFile == null
            ? Text('Please choose an image')
            : Image.file(
                _imageFile,
                fit: BoxFit.cover,
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
              ),
      ],
    );
  }
}
