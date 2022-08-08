import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../logic/messageListPresenter.dart';

class ImagePickerChoiceView extends StatelessWidget {
  final ImagePickerPresenter presenter = ImagePickerPresenter();
  final BoxDecoration? filePickerDecoration;
  final Function(String file) onImagePickup;

  ImagePickerChoiceView({
    required this.onImagePickup,
    this.filePickerDecoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      constraints: const BoxConstraints(
        maxHeight: 180,
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: filePickerDecoration ??
            BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.decal,
                colors: [
                  Colors.green.shade200,
                  Colors.green.shade300,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getBottomSheetItem(
                itemName: 'Camera',
                onTap: () async {
                  Navigator.pop(context);

                  await presenter.getFile(
                    source: ImageSource.camera,
                    onImagePickup: onImagePickup,
                    context: context,
                  );
                },
                icon: Icons.camera_alt,
              ),
              getBottomSheetItem(
                itemName: 'Gallery',
                onTap: () async {
                  Navigator.pop(context);

                  presenter.getFile(
                    source: ImageSource.gallery,
                    onImagePickup: onImagePickup,
                    context: context,
                  );
                },
                icon: Icons.photo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBottomSheetItem({
    required String itemName,
    required Function() onTap,
    required IconData icon,
  }) =>
      Material(
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        elevation: 8.0,
        shadowColor: Colors.green.shade200,
        child: InkWell(
          splashColor: Colors.blue,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.decal,
                colors: [
                  Colors.green.shade50,
                  Colors.green.shade100,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                ),
                Text(
                  itemName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
