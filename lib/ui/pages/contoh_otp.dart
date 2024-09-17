import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';


class ContohOTPPage extends StatefulWidget {
  @override
  _ContohOTPPageState createState() => _ContohOTPPageState();
}

class _ContohOTPPageState extends State<ContohOTPPage> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  Future<void> _getMessages() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        count: 2, // Batasi jumlah pesan yang dibaca
      );
      setState(() {
        _messages = messages.where((msg) => 
        // msg.address == 'BPR WM'
        msg.address?.toUpperCase() == 'BPR WM' &&
        msg.body!.contains('OTP') &&
        msg.date!.isAfter(DateTime.now().subtract(Duration(days: 2)))
        ).toList();
      });
    } else {
      await Permission.sms.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SMS Reader')),
      body: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final otpMatch = RegExp(r'\d{6}').firstMatch(message.body ?? '');
          final otp = otpMatch?.group(0) ?? 'OTP tidak ditemukan';
          return ListTile(
            title: Text(otp),
            // subtitle: Text(message.date?.toString() ?? ''),
            subtitle: Text(message.body ?? ''),
          );
        },
      ),
    );
  }
}

// class ContohOTPPage extends StatefulWidget {
//   const ContohOTPPage({Key? key}) : super(key: key);

//   @override
//   State<ContohOTPPage> createState() => _ContohOTPPageState();
// }

// class _ContohOTPPageState extends State<ContohOTPPage> {
//   String _code="";
//   String signature = "{{ app signature }}";
//   // final signature = SmsAutoFill().getAppSignature;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     SmsAutoFill().unregisterListener();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               const PhoneFieldHint(),
//               const Spacer(),
//               PinFieldAutoFill(
//                 decoration: UnderlineDecoration(
//                   textStyle: const TextStyle(fontSize: 20, color: Colors.black),
//                   colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
//                 ),
//                 currentCode: _code,
//                 onCodeSubmitted: (code) {},
//                 onCodeChanged: (code) {
//                   if (code!.length == 6) {
//                     FocusScope.of(context).requestFocus(FocusNode());
//                   }
//                 },
//               ),
//               const Spacer(),
//               TextFieldPinAutoFill(
//                 currentCode: _code,
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 child: const Text('Listen for sms code'),
//                 onPressed: () async {
//                   await SmsAutoFill().listenForCode();
//                 },
//               ),
//               ElevatedButton(
//                 child: const Text('Set code to 123456'),
//                 onPressed: () async {
//                   setState(() {
//                     _code = '123456';
//                   });
//                 },
//               ),
//               const SizedBox(height: 8.0),
//               const Divider(height: 1.0),
//               const SizedBox(height: 4.0),
//               Text("App Signature : $signature"),
//               const SizedBox(height: 4.0),
//               ElevatedButton(
//                 child: const Text('Get app signature'),
//                 onPressed: () async {
//                   signature = await SmsAutoFill().getAppSignature;
//                   setState(() {});
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => CodeAutoFillTestPage()));
//                 },
//                 child: const Text("Test CodeAutoFill mixin"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CodeAutoFillTestPage extends StatefulWidget {
//   const CodeAutoFillTestPage({Key? key}) : super(key: key);

//   @override
//   State<CodeAutoFillTestPage> createState() => _CodeAutoFillTestPageState();
// }

// class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage> with CodeAutoFill {
//   String? appSignature;
//   String? otpCode;

//   @override
//   void codeUpdated() {
//     setState(() {
//       otpCode = code!;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     listenForCode();

//     SmsAutoFill().getAppSignature.then((signature) {
//       setState(() {
//         appSignature = signature;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const textStyle = TextStyle(fontSize: 18);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Listening for code"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
//             child: Text(
//               "This is the current app signature: $appSignature",
//             ),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Builder(
//               builder: (_) {
//                 if (otpCode == null) {
//                   return const Text("Listening for code...", style: textStyle);
//                 }
//                 return Text("Code Received: $otpCode", style: textStyle);
//               },
//             ),
//           ),
//           const Spacer(),
//         ],
//       ),
//     );
//   }
// }



// class ContohOTPPage extends StatefulWidget {
//   @override
//   _ContohOTPPageState createState() => _ContohOTPPageState();
// }

// class _ContohOTPPageState extends State<ContohOTPPage> {
//   @override
//   void initState() {
//     super.initState();
//     listenForSms();
//   }

//   @override
//   void dispose() {
//     SmsAutoFill().unregisterListener();
//     super.dispose();
//   }

//   void listenForSms() async {
//     print('Starting to listen for SMS...');
//     try {
//       await SmsAutoFill().listenForCode;
//       print('SMS code received');
//     } catch (e) {
//       print('Error: $e');
//     }
//     print('Finished listening for SMS');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: PinFieldAutoFill(
//         codeLength: 6,
//         onCodeChanged: (code) {
//           if (code!.length == 6) {
//             // Proses kode
//             print('Received code: $code');
//           }
//         },
//       ),
//     );
//   }
// }