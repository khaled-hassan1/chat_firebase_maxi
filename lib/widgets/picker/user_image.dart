import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File? image) imagePickedFn;

  const UserImagePicker({Key? key, required this.imagePickedFn})
      : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _imageFile; // Change type to File

  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: source, imageQuality: 50, maxWidth: 150);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path); // Convert XFile to File
      });
      widget.imagePickedFn(File(pickedImage.path));
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _chooseImage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Choose',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Gallery')),
          TextButton(
            onPressed: () => _pickImage(ImageSource.camera),
            child: const Text('Camera'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _imageFile != null
              ? FileImage(_imageFile!)
              : const NetworkImage(
                      'https://leadseguros.com.br/wa_images/icone-pessoal_1.png?v=1dpdgv1')
                  as ImageProvider,
        ),
        TextButton(onPressed: _chooseImage, child: const Text('Add Image')),
      ],
    );
  }
}
