import 'package:flutter/material.dart';

import 'imagePickerChoiceView.dart';

class MessageInputFieldView extends StatelessWidget {
  final TextEditingController controllerMessage;
  final BoxDecoration? filePickerDecoration;

  final Function(String file) onImagePickup;
  final Function(String message) onSendText;

  const MessageInputFieldView(
      {required this.controllerMessage,
      this.filePickerDecoration,
      required this.onImagePickup,
      required this.onSendText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        left: false,
        bottom: true,
        right: false,
        child: getInputChoiceRow(context),
      ),
    );
  }

  Widget getInputChoiceRow(BuildContext context) => Row(
        children: [
          IconButton(
            onPressed: () => showBottomSheet(context),
            icon: const Icon(Icons.add),
          ),
          Expanded(
            child: TextField(
              controller: controllerMessage,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'write your message',
                constraints: const BoxConstraints(maxHeight: 100),
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      );

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImagePickerChoiceView(
        onImagePickup: onImagePickup,
        filePickerDecoration: filePickerDecoration,
      ),
    );
  }

  void sendMessage() {
    if (controllerMessage.text.isNotEmpty) {
      onSendText(controllerMessage.text.trim());
      controllerMessage.clear();
    }
  }
}
