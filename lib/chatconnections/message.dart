import 'package:flutter/material.dart';
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
       // backgroundColor: Color.fromARGB(255, 123,63,211),
        //color: Colors.black,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          color: const Color.fromARGB(255,242,242,242),
        ),
        // tileColor: Color.fromARGB(255, 123,63,211),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true, // Reverse the list so new messages appear at the bottom
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]['message']),
                    subtitle: Text(messages[index]['time']),
                   
                  );
                },
              ),
//               ListView.builder(
//   reverse: true,
//   itemCount: messages.length,
//   itemBuilder: (context, index) {
//     return Container(
//       color: Colors.blue, // Set the background color for the text
//       padding: EdgeInsets.all(8.0), // Add padding to the container
//       margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Add margin to the container
//       child: ListTile(
//         title: Text(
//           messages[index]['message'],
//           style: TextStyle(
//             color: Colors.white, // Set the text color
//           ),
//         ),
//         subtitle: Text(
//           messages[index]['time'],
//           style: TextStyle(
//             color: Colors.white, // Set the text color
//           ),
//         ),
//       ),
//     );
//   },
// ),

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
