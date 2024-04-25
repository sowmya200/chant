import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
       backgroundColor: Color.fromARGB(255, 123,63,211),
      appBar: AppBar(
        title: Text('${widget.receiverName}'),
        backgroundColor: Color.fromARGB(255, 123,63,211), // Change the background color here
      ),
      body: Container(
        decoration: BoxDecoration(
           
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          color: const Color.fromARGB(255,242,242,242),
        ),
        // tileColor: Color.fromARGB(255, 123,63,211),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
  padding: const EdgeInsets.symmetric(vertical: 16.0),
  reverse: true, // Reverse the list so new messages appear at the bottom
  itemCount: messages.length,
  itemBuilder: (context, index) {
    return Align(
      alignment: Alignment.centerRight, // Align messages to the right side
      child: Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(bottom: 8.0, right: 8.0, left: 64.0), // Adjust margins as needed
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Color of the message bubble
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              messages[index]['message'],
              style: TextStyle(fontSize: 16.0, color: Colors.white), // Text color
            ),
            SizedBox(height: 4.0),
            Text(
              messages[index]['time'],
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
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
                      sendMessage();
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

  void sendMessage() {
    String message = _messageController.text;
    String time = DateFormat.Hm().format(DateTime.now()); // Format DateTime to display only hours and minutes
    setState(() {
      
      messages.insert(0, {'message': message, 'time': time}); // Insert new message at the beginning of the list
    });
    _messageController.clear();
  }
}
