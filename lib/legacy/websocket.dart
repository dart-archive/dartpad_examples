// Copyright 2012 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

//# Captured on 2018-10-17
//# https://dartpad.dartlang.org/479ecba5a56fd706b648

import 'dart:html';

const echoUrl = 'wss://echo.websocket.org';

void main() {
  WebSocketTest wsTest = new WebSocketTest(echoUrl);

  InputElement input = querySelector('input');
  input.onChange.listen((_) {
    wsTest.send(input.value);
    input.value = '';
  });
}

class WebSocketTest {
  WebSocket _socket;
  Stopwatch _timer;

  WebSocketTest(String url) {
    print("Connecting to ${url}…");
    _socket = new WebSocket(url);
    _startListening();
  }

  void send(String value) {
    print('==> ${value}');
    _socket.send(value);
    _timer = new Stopwatch()..start();
  }

  void _startListening() {
    _socket.onOpen.listen((e) {
      print('Connected!');
      send('Hello from Dart!');
    });

    _socket.onClose.listen((_) => print('Websocket closed.'));
    _socket.onError.listen((_) => print("Error opening connection."));

    _socket.onMessage.listen((MessageEvent e) {
      print('<== ${e.data} [${_timer.elapsedMilliseconds}ms]');
    });
  }
}
