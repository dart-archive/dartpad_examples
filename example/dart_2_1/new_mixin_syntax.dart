// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

mixin AnswerMixin {
  int get answer => 42;

  @override
  String toString() => '[ $runtimeType ]';
}

class Answer with AnswerMixin {}

void main() {
  print('''
*
* Simple usage of `mixin`
*
''');
  printAnswer(Answer(), 'Use `with` to include a mixin');

  print('''
*
* More advanced usage of `mixin`
*
''');
  printAnswer(
      LogAnswer(),
      'Include many mixins by separating with commas. '
      '`$LoggingAnswerMixin` prints every time `answer` is accessed.');

  print('''
*
* The order in which mixins are included matters.
*
''');

  printAnswer(LogVerifyAnswer(), 'In this case, log then verify.');
  printAnswer(VerifyLogAnswer(), 'In this case, verify then log.');

  print('''
*
* You can extend classes that include mixins, too.
*
''');

  printAnswer(DeltaLogVerifyAnswer(), 'Verify will fail.');
  printAnswer(DeltaLogVerifyAnswer(1), 'Verify will succeed.');
}

void printAnswer(AnswerMixin obj, String description) {
  print(obj);
  print('- $description');
  print('answer: ${obj.answer}');
  print('');
}

/// [LoggingAnswerMixin] can only be used as a mixin when the superclass
/// (or one of the mixins that comes before it in a "with" clause) implements
/// [AnswerMixin].
mixin LoggingAnswerMixin on AnswerMixin {
  @override
  int get answer {
    var value = super.answer;
    print('  LOG: `answer` property was accessed');
    return value;
  }
}

class LogAnswer with AnswerMixin, LoggingAnswerMixin {}

mixin VerifyingAnswerMixin on AnswerMixin {
  @override
  int get answer {
    var value = super.answer;
    if (value == 42) {
      print('  VERIFY: Invalid Result!');
    } else {
      print('  VERIFY: valid result');
    }
    return value;
  }
}

class LogVerifyAnswer
    with AnswerMixin, LoggingAnswerMixin, VerifyingAnswerMixin {}

class VerifyLogAnswer
    with AnswerMixin, VerifyingAnswerMixin, LoggingAnswerMixin {}

abstract class DeltaAnswer with AnswerMixin {
  final int delta;

  DeltaAnswer(this.delta);

  @override
  int get answer => super.answer + delta;
}

class DeltaLogVerifyAnswer extends DeltaAnswer
    with LoggingAnswerMixin, VerifyingAnswerMixin {
  DeltaLogVerifyAnswer([int delta = 0]) : super(delta);
}
