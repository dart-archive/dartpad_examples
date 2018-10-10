// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Size {
  final double width, height;

  const Size(this.width, this.height);

  @override
  String toString() => '{$width, $height}';
}

void main() {
  print(Size(0, 0));
}
