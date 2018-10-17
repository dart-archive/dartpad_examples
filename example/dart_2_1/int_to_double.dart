// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Size {
  double width, height;

  Size(this.width, this.height);

  @override
  String toString() => '{$width, $height}';
}

void main() {
  // Size width and height are of type `double`.
  // Before Dart 2.1, you had to provide a trailing `.0` – `42.0` – when
  // assigning to fields or parameters of type `double`.
  // A value like `42` was not allowed.

  print(Size(2.0, 4.0)); // Before Dart 2.1, the trailing `.0` is required.

  // With Dart 2.1, you can provide whole-number values when assigning to
  // a double without the trailing `.0`.
  print(Size(2, 4)); // Legal with Dart 2.1
}
