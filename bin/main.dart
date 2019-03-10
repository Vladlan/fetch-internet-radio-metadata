//import 'package:dart_stream_example/dart_stream_example.dart'
//    as dart_stream_example;
import 'dart:io';
import 'dart:async';

Socket socket;
var buffer = '';

String indexRequest = 'GET /se91d38a33/listen HTTP/1.0';
String clientName = 'node-internet-radio v0.1.5';
String port = '80';
String path = '/se91d38a33/listen';
String hostname = 's2.radio.co';
String headers = "Icy-Metadata: 1\r\nUser-Agent: " +
    clientName +
    "\r\nhost: " +
    hostname +
    "\r\n";
String getString = "GET " + path + " HTTP/1.0\r\n" + headers + "\r\n\r\n";
int maxBufferSize = 100000;
String out = '';

main() async {
//  print('Hello world: ${dart_stream_example.calculate()}!');

  Socket.connect(
    's2.radio.co',
    80,
  ).then((Socket sock) {
    print('Connected to: '
        '${sock.remoteAddress.address}:${sock.remotePort}');
    socket = sock;

    socket.listen((data) {
      String res = new String.fromCharCodes(data);
      print(res);
      var startSubstring = "StreamTitle=";
      var startPosition = new String.fromCharCodes(data).indexOf(startSubstring);
      if (startPosition > -1) {
        print('WARNING: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        print('WARNING: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        print('WARNING: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        print('WARNING: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        print(startSubstring);
        print(startPosition);
        print(res.length);
        for (var i = 0; i < 150; i++) {
          if (res[startPosition+i] == ';') {
            break;
          }
          out = out + res[startPosition+i];
        }
        print(out);
        tearDown(socket);
      }
    }, onDone: () {
      print("Done");
      socket.destroy();
    });

    sock.write(getString);
  }).catchError((AsyncError e) {
    print("Unable to connect: $e");
  });
}

void tearDown(Socket socket) {
  socket.destroy();
}
