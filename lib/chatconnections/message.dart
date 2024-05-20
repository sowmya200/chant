import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sms_autofill/sms_autofill.dart';

class MessagePage extends StatefulWidget {
  final TextEditingController senderName;
  final String receiverName;
  static const Route = '/message-screen';

  MessagePage({required this.senderName, required this.receiverName});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.receiverName,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 123, 63, 211),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
  stream: FirebaseFirestore.instance
    .collection('messages')
    .where('sender', isEqualTo: widget.receiverName)
    .where('receiver', isEqualTo: widget.senderName.text)
    .orderBy('time', descending: true)
    .snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
    if (!snapshot.hasData || snapshot.data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    var receiverStream = FirebaseFirestore.instance
      .collection('messages')
      .where('sender', isEqualTo: widget.senderName.text)
      .where('receiver', isEqualTo: widget.receiverName)
      .orderBy('time', descending: true)
      .snapshots();

    return StreamBuilder(
      stream: receiverStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> receiverSnapshot) {
        if (!receiverSnapshot.hasData || receiverSnapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var allMessages = <DocumentSnapshot>[...snapshot.data!.docs, ...receiverSnapshot.data!.docs];
        allMessages.sort((a, b) {
          var timeA = a['time'] as Timestamp;
          var timeB = b['time'] as Timestamp;
          return timeB.compareTo(timeA);
        });

        return ListView.builder(
          reverse: true,
          itemCount: allMessages.length,
          itemBuilder: (context, index) {
            var messageData = allMessages[index].data() as Map<String, dynamic>;
            var message = messageData['message'];
            var time = messageData['time'];
            var sender = messageData['sender'];

            DateTime dateTime;

            if (time is Timestamp) {
              dateTime = time.toDate();
            } else if (time is String) {
              try {
                dateTime = DateTime.parse(time);
              } catch (e) {
                print('Error parsing DateTime: $e');
                dateTime = DateTime.now();
              }
            } else {
              dateTime = DateTime.now();
            }

            bool isSender = sender == widget.senderName.text;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isSender ? Color.fromARGB(255, 126, 102, 180) : const Color.fromARGB(255,222,207,228),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: isSender ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        DateFormat.yMd().add_jm().format(dateTime),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  },
),
          
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                     SmsAutoFill().listenForCode();
                    sendMessage(
                        context, widget.senderName.text, widget.receiverName);
                  },
                ),
              ],
            ),
          ),
        ], 
      ),
    );
  }

  void sendMessage(BuildContext context, String sender, String receiver) async {
    String message = _messageController.text;
    Timestamp Fulltime = Timestamp.now();

    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'sender': sender,
        'receiver': receiver,
        'message': message,
        'time': Fulltime,
      });
      print('Message sent successfully');
    } catch (e) {
      print('Error sending message: $e');
    }

    // Clear the message input field
    _messageController.clear();
  }
}
