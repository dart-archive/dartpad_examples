// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO(kevmoo): add documentation
mixin AnswerMixin {
  int get theAnswer => 42;
}

class MyClass = Object with AnswerMixin;

main() {
  print(MyClass().theAnswer);
}
