// Copyright 2018 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../../example/dart_2_1/new_mixin_syntax.dart' as example;

void main() {
  test('output', () {
    expect(example.main, prints(r'''
*
* Simple usage of `mixin`
*

[ Answer ]
- Use `with` to include a mixin
answer: 42

*
* More advanced usage of `mixin`
*

[ LogAnswer ]
- Include many mixins by separating with commas. `LoggingAnswerMixin` prints every time `answer` is accessed.
  LOG: `answer` property was accessed
answer: 42

*
* The order in which mixins are included matters.
*

[ LogVerifyAnswer ]
- In this case, log then verify.
  LOG: `answer` property was accessed
  VERIFY: Invalid Result!
answer: 42

[ VerifyLogAnswer ]
- In this case, verify then log.
  VERIFY: Invalid Result!
  LOG: `answer` property was accessed
answer: 42

*
* You can extend classes that include mixins, too.
*

[ DeltaLogVerifyAnswer ]
- Verify will fail.
  LOG: `answer` property was accessed
  VERIFY: Invalid Result!
answer: 42

[ DeltaLogVerifyAnswer ]
- Verify will succeed.
  LOG: `answer` property was accessed
  VERIFY: valid result
answer: 43

'''));
  });
}
