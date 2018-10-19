// Copyright 2018 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:test/test.dart';

import '../../example/dart_2_1/int_to_double.dart' as example;

void main() {
  test('output', () {
    expect(example.main, prints(r'''
12.566370614359172
12.566370614359172
'''));
  });

  test('api', () {
    var size = example.Circle(1);
    expect(size.radius, const TypeMatcher<double>());
    expect(size.area, math.pi);
  });
}
