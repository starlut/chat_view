import 'dart:io';

import 'package:flutter/material.dart';

import '../dataModels/messageModel.dart';

class MessageListItemView extends StatefulWidget {
  final MessageModel messageModel;
  final BoxDecoration? messageItemDecoration;
  const MessageListItemView({
    required this.messageModel,
    this.messageItemDecoration,
    Key? key,
  }) : super(key: key);

  @override
  State<MessageListItemView> createState() => _MessageListItemViewState();
}

class _MessageListItemViewState extends State<MessageListItemView> {
  bool isShowTime = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.messageModel.isOwnMessage
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: InkWell(
        onTap: () => setState(
          () => isShowTime = !isShowTime,
        ),
        child: Column(
          crossAxisAlignment: widget.messageModel.isOwnMessage
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Align(
              alignment: widget.messageModel.isOwnMessage
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                child: isShowTime
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(widget.messageModel.time),
                      )
                    : const SizedBox(
                        height: 1,
                        width: 1,
                      ),
              ),
            ),
            messageBody,
          ],
        ),
      ),
    );
  }

  Widget get messageBody {
    switch (widget.messageModel.type) {
      case MessageType.text:
        return textMessageType;
      case MessageType.image:
        return imageMessageType;
    }
  }

  Widget get textMessageType => Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: widget.messageItemDecoration ??
            BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.green.shade50,
                    Colors.green.shade100,
                  ],
                  begin: widget.messageModel.isOwnMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft),
              borderRadius: BorderRadius.only(
                topRight: widget.messageModel.isOwnMessage
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
                topLeft: widget.messageModel.isOwnMessage
                    ? const Radius.circular(15)
                    : const Radius.circular(0),
                bottomRight: const Radius.circular(15),
                bottomLeft: const Radius.circular(15),
              ),
            ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        child: Text(
          widget.messageModel.text.trim(),
          textAlign: widget.messageModel.isOwnMessage
              ? TextAlign.start
              : TextAlign.end,
        ),
      );

  Widget get imageMessageType => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        clipBehavior: Clip.antiAlias,
        constraints: BoxConstraints(
          maxHeight: 200,
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: widget.messageModel.isOwnMessage
                ? const Radius.circular(0)
                : const Radius.circular(15),
            topLeft: widget.messageModel.isOwnMessage
                ? const Radius.circular(15)
                : const Radius.circular(0),
            bottomRight: const Radius.circular(15),
            bottomLeft: const Radius.circular(15),
          ),
        ),
        child: Image.file(
          File(widget.messageModel.text),
        ),
      );
}
