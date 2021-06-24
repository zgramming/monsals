import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:global_template/global_template.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../utils/my_utils.dart';

class TakeActivityPicture extends StatefulWidget {
  final File? file;
  final String? filename;
  final Function(File pickedFile) onTakePicture;
  const TakeActivityPicture({
    Key? key,
    this.file,
    this.filename,
    required this.onTakePicture,
  }) : super(key: key);

  @override
  _TakeActivityPictureState createState() => _TakeActivityPictureState();
}

class _TakeActivityPictureState extends State<TakeActivityPicture> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .455,
      child: InkWell(
        onTap: () async {
          final pickedImage = await picker.getImage(source: ImageSource.camera);
          if (pickedImage != null) {
            widget.onTakePicture(File(pickedImage.path));
          }
        },
        child: Ink(
          height: sizes.height(context) / 6,
          decoration: BoxDecoration(
            border: Border.all(color: colorPallete.accentColor!),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: (widget.filename != null && widget.file == null)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    '${Constant.baseImageActivity}/${widget.filename}?uniqid=${const Uuid().v1()}',
                    fit: BoxFit.cover,
                  ),
                )
              : (widget.file == null)
                  ? const Center(
                      child: Icon(FontAwesomeIcons.camera),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.file(
                        widget.file!,
                        fit: BoxFit.cover,
                      ),
                    ),
        ),
      ),
    );
  }
}
