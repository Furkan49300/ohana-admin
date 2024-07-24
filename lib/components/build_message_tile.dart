import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildMessageTile extends StatelessWidget {
  const BuildMessageTile({
    super.key,
    required this.onMessageDetailPressed,
    required this.context,
    required this.doc,
  });

  final Function(Map<String, dynamic> p1, String p2) onMessageDetailPressed;
  final BuildContext context;
  final QueryDocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    var message = doc.data() as Map<String, dynamic>;
    var messageId = doc.id;

    var timestamp = message['date_sent'] as Timestamp;
    var dateTime = timestamp.toDate();
    var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

    return GestureDetector(
      onTap: () {
        onMessageDetailPressed(message, messageId);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                message['lastname'][0],
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${message['lastname']} ${message['firstname']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Sujet: ${message['subject']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Date: $formattedDate",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
