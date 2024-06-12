// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// class EmailSender {
//   final String username = 'sowmyakumaravel2024@gmail.com'; // Replace with your email
//   final String password = 'vtyq jero tldx enlq'; // Replace with your app password

//   Future<void> sendEmail(String toEmail, String subject, String body) async {
//     final smtpServer = gmail(username, password);

//     final message = Message()
//       ..from = Address(username, 'ChantApp')
//       ..recipients.add('sowmyakumaravel2002@gmail.com')
//       ..subject = subject 
//       ..text = body;

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (e) {
//       print('Message not sent. \n' + e.toString());
//     }
//   }
// }
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// class EmailSender {
//   final String username = 'sowmyakumaravel2024@gmail.com'; // Replace with your email
//   final String password = 'vtyq jero tldx enlq';

//   EmailSender(String toEmail, subject, String body); // App password generated for your Gmail account

//   Future<void> sendEmail(String toEmail, String subject, String body) async {
//     final smtpServer = gmail(username, password);

//     final message = Message()
//       ..from = Address(username, 'Your Name')
//       ..recipients.add(toEmail)
//       ..subject = subject
//       ..text = body;

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (e) {
//       print('Message not sent. \n' + e.toString());
//     }
//   }
// }
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSender {
  final String username = 'sowmyakumaravel2024@gmail.com'; // Replace with your email
  final String password = 'vtyq jero tldx enlq';

  EmailSender(); // Replace with your app password

  // Constructor is unnecessary for sending email in this context
  // EmailSender(String toEmail, subject, String body);

  Future<void> sendEmail(String toEmail, String subject, String body) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'chantApp')
      ..recipients.add(toEmail)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
      throw e; // Re-throw the exception to handle it further up the call stack if needed
    }
  }
}

