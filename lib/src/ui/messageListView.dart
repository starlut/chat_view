import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dataModels/messageModel.dart';
import 'messageInputView.dart';
import 'messageItemView.dart';

class MessageListView extends StatefulWidget {
  final List<MessageModel> messageList;
  final Function(String file) onImagePickup;
  final Function(String message) onSendText;
  final BoxDecoration? messageListDecoration;
  final BoxDecoration? messageItemDecoration;
  final BoxDecoration? filePickerDecoration;
  const MessageListView({
    required this.messageList,
    required this.onImagePickup,
    required this.onSendText,
    this.messageListDecoration,
    this.messageItemDecoration,
    this.filePickerDecoration,
    Key? key,
  }) : super(key: key);

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  TextEditingController controllerMessage = TextEditingController();

  @override
  void dispose() {
    controllerMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.green.shade400,
        title: const Text('Message'),
      ),
      resizeToAvoidBottomInset: false,
      body: getBody(),
    );
  }

  Widget getBody() => Container(
        decoration: widget.messageListDecoration ??
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
        child: getMessageBody(),
      );

  Widget getMessageBody() => Column(
        children: [
          Expanded(
            child: getMessageList(),
          ),
          getMessageWriteBox(),
        ],
      );

  Widget getMessageList() => Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          reverse: true,
          dragStartBehavior: DragStartBehavior.down,
          itemCount: widget.messageList.length,
          itemBuilder: (context, index) => MessageListItemView(
            messageModel: widget.messageList[index],
            messageItemDecoration: widget.messageItemDecoration,
          ),
        ),
      );

  Widget getMessageWriteBox() => MessageInputFieldView(
        controllerMessage: controllerMessage,
        onImagePickup: widget.onImagePickup,
        onSendText: widget.onSendText,
        filePickerDecoration: widget.filePickerDecoration,
      );
}
