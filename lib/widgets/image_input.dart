import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;


class ImageInput extends StatefulWidget {
  final File onSelectImage;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takenPicture() async {
    final picker= ImagePicker();
    // ignore: deprecated_member_use
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if(imageFile == null)
    {
      return;
    }
    setState(() {
      _storedImage= File(imageFile.path);
    });
    final appDir= await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =await  File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
 //   return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'no image taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        TextButton.icon(
          // <-- TextButton
          onPressed: _takenPicture,
          icon: Icon(
            Icons.camera,
            //size: 24.0,
          ),
          label: Text('Take Picture'),
          style: TextButton.styleFrom(
            // ignore: deprecated_member_use
            onSurface: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
