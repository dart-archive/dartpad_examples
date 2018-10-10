// Copyright 2018 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:dartpad_examples/legacy/fibonacci.dart' as example;
import 'package:test/test.dart';

void main() {
  test('output', () {
    expect(() => example.main(), prints(r'''
fibonacci(20) = 6765
'''));
  });

  test('function', () {
    expect(example.fibonacci(10), 55);
  });
}
