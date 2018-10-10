// Copyright 2018 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

@Skip('Not working on SDK - 2.1.0-dev.6.0')

import 'package:dartpad_examples/dart_2_1/int_to_double.dart' as example;
import 'package:test/test.dart';

void main() {
  test('output', () {
    expect(() => example.main(), prints(r'''
Something?
'''));
  });
}
