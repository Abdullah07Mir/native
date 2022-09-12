import 'dart:io';
import 'package:flutter/material.dart';
import 'package:native_features/providers/great_places.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File ?_pickedImage;
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }
  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null )
    {
      return;
    }
    Provider.of<GreatPlaces>(context).addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new places'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(decoration: InputDecoration(labelText: 'Title '),
                    controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(),
                  ],
                ),
              ),
            )),
            ElevatedButton.icon(
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.add,
                // ignore: deprecated_member_use
                // color: Theme.of(context).accentColor,
                //size: 24.0,
              ),
              label: Text('Add place'), onPressed: _savePlace,
              style: ElevatedButton.styleFrom(
                // ignore: deprecated_member_use
                primary: Theme.of(context).accentColor,
                // ignore: deprecated_member_use
                onPrimary: Colors.black,
              ),
            )
          ]),
    );
  }
}