// Copyright 2018 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:dartpad_examples/dart_2_1/int_to_double.dart' as example;
import 'package:test/test.dart';

void main() {
  test('output', () {
    String expectedOutput;
    if (identical(1, 1.0)) {
      // javascript
      expectedOutput = r'''
{0, 0}
''';
    } else {
      // vm
      expectedOutput = r'''
{0.0, 0.0}
''';
    }

    expect(example.main, prints(expectedOutput));
  });

  test('api', () {
    var size = example.Size(1, 2);
    expect(size.width, const TypeMatcher<double>());
    expect(size.height, const TypeMatcher<double>());
  });
}
