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
  List<Map<String, dynamic>> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 123, 63, 211),
      appBar: AppBar(
        title: Text('${widget.receiverName}'),
        backgroundColor: Color.fromARGB(
            255, 123, 63, 211), // Change the background color here
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          color: const Color.fromARGB(255, 242, 242, 242),
        ),
        // tileColor: Color.fromARGB(255, 123,63,211),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var messageData = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
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

                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.only(
                              bottom: 8.0, right: 8.0, left: 64.0),
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
                                DateFormat.yMd().add_jm().format(
                                    dateTime), // Format timestamp as needed
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
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
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      sendMessage(
                          context, widget.senderName.text, widget.receiverName);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void sendMessage() {
  //   String message = _messageController.text;
  //   String time = DateFormat.Hm().format(DateTime.now()); // Format DateTime to display only hours and minutes
  //   setState(() {

  //     messages.insert(0, {'message': message, 'time': time}); // Insert new message at the beginning of the list
  //   });
  //   _messageController.clear();
  // }
  void sendMessage(BuildContext context, String sender, String receiver) async {
    String message = _messageController.text;
    String time = DateFormat.Hm().format(DateTime.now());
    Timestamp Fulltime =
        Timestamp.now(); // Format DateTime to display only hours and minutes

    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'sender': sender,
        'receiver': receiver,
        'message': message,
        'time': Fulltime,
      });
      print('Message sent successfully');

      // Update UI by inserting the new message into the messages list
      setState(() {
        messages.insert(0, {
          'message': message,
          'time': time
        }); // Insert new message at the beginning of the list
      });
    } catch (e) {
      print('Error sending message: $e');
    }

    // Clear the message input field
    _messageController.clear();
  }
}
