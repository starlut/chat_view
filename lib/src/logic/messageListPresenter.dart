import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPresenter {
  getFile({
    required ImageSource source,
    required Function(String path) onImagePickup,
    required BuildContext context,
  }) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        onImagePickup(pickedFile.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error getting image'),
        ),
      );
      debugPrint(e.toString());
    }
  }
}
