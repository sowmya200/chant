import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagePage extends StatefulWidget {
  final TextEditingController senderName;
  final String receiverName;

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
                  .where('sender', isEqualTo: widget.senderName.text)
                  .where('receiver', isEqualTo: widget.receiverName)
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot?> snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var messageData =
                        snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    var message = messageData['message'];
                    var time = messageData['time'];

                    DateTime dateTime;

                    if (time is Timestamp) {
                      dateTime = time.toDate();
                    } else if (time is String) {
                      try {
                        // Attempt to parse the string as a DateTime
                        dateTime = DateTime.parse(time);
                      } catch (e) {
                        // Handle parsing errors
                        print('Error parsing DateTime: $e');
                        // Default to current time if parsing fails
                        dateTime = DateTime.now();
                      }
                    } else {
                      // Default to current time if the time field is not a Timestamp or String
                      dateTime = DateTime.now();
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 126, 102, 180),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                message,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
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
                    sendMessage(context, widget.senderName.text, widget.receiverName);
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
