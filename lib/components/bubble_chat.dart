import 'package:flutter/material.dart';
import 'package:tiligrim/utils/pallete.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({super.key, required this.text, required this.isSender, required this.time, required this.isRead});

  final String text, time;
  final bool isSender, isRead;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSender ? const Color(0xffE1FEC6) : const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15.5
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(width: 5),
              isSender
              ?
              Icon(
                Icons.done_all_rounded,
                color: isRead ? Pallete.primary : Colors.white,
                size: 20,
              )
              :
              Container()
            ],
          )
        ],
      ),
    );
  }
}