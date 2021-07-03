import 'dart:io';

import 'package:assosnation_app/components/no_image_placeholder.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditAssociationImgDialog extends StatefulWidget {
  const EditAssociationImgDialog({Key? key, required this.association})
      : super(key: key);

  final Association association;

  @override
  _EditAssociationImgDialogState createState() =>
      _EditAssociationImgDialogState();
}

class _EditAssociationImgDialogState extends State<EditAssociationImgDialog> {
  File? _updatedImage;

  _verifyAndValidateForm() async {
    if (_updatedImage != null) {
      final imgUrl = await StorageService().uploadAssociationImageToStorage(
          _updatedImage!, widget.association.uid);
      Navigator.pop(context);
    } else
      Navigator.pop(context);
  }

  Widget _displayAssosImageOrPlaceholder() {
    if (widget.association.banner == "")
      return NoImagePlaceholder();
    else if (_updatedImage == null) {
      return Opacity(
        opacity: 0.5,
        child: CachedNetworkImage(
          imageUrl: widget.association.banner,
          placeholder: (context, url) => CircularProgressIndicator(),
        ),
      );
    } else {
      return Align(
        child: Image.file(_updatedImage!),
        alignment: Alignment.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: InkWell(
              onTap: () async {
                final img = await StorageService().selectImageFromGallery();
                setState(() {
                  _updatedImage = img;
                });
              },
              child: Stack(
                children: [
                  Container(
                    child: _displayAssosImageOrPlaceholder(),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Theme.of(context).accentColor, width: 1)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Theme.of(context).accentColor,
                      size: 50,
                    ),
                  ),
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel", style: TextStyle(color: Colors.red))),
                OutlinedButton(
                    onPressed: _verifyAndValidateForm,
                    child: Text(
                      "Update",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
