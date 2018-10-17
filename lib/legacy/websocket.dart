// Copyright 2012 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

//# Captured on 2018-10-17
//# https://dartpad.dartlang.org/479ecba5a56fd706b648

import 'dart:html';

void main() {
  var wsTest = WebSocketTest('wss://echo.websocket.org');

  InputElement input = querySelector('input');
  input.onChange.listen((_) {
    wsTest.send(input.value);
    input.value = '';
  });
}

class WebSocketTest {
  final WebSocket _socket;
  final _timer = Stopwatch()..start();

  WebSocketTest(String url) : _socket = WebSocket(url) {
    print('Connecting to $url...');
    _startListening();
  }

  void send(String value) {
    print('==> $value');
    _socket.send(value);
    _timer.reset();
  }

  void _startListening() {
    _socket.onOpen.listen((e) {
      print('Connected!');
      send('Hello from Dart!');
    });

    _socket.onClose.listen((_) => print('Websocket closed.'));
    _socket.onError.listen((_) => print('Error opening connection.'));

    _socket.onMessage.listen((e) {
      print('<== ${e.data} [${_timer.elapsedMilliseconds}ms]');
    });
  }
}
