// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show htmlEscape;

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

Builder exampleWebBuilder(BuilderOptions options) => _ExampleWebBuilder();

Builder exampleRootBuilder(BuilderOptions options) => _WebRootBuilder();

class _ExampleWebBuilder implements Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    var source = await buildStep.readAsString(buildStep.inputId);

    var hasCss =
        await buildStep.canRead(buildStep.inputId.changeExtension('.css'));

    var htmlAsset = buildStep.inputId.changeExtension('.html_snippet');
    String snippetContent;
    if (await buildStep.canRead(htmlAsset)) {
      snippetContent = await buildStep.readAsString(htmlAsset);
    }

    var sampleName = p.basenameWithoutExtension(buildStep.inputId.path);

    await buildStep.writeAsString(
        buildStep.inputId.changeExtension('.html'),
        _template(
            sampleName, hasCss, source, snippetContent ?? 'Open console...'));
  }

  @override
  final buildExtensions = const {
    '.dart': ['.html']
  };

  String _template(
          String name, bool hasCss, String source, String snippetContent) =>
      '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${name.replaceAll('_', ' ')}</title>
  ${hasCss ? '<link rel="stylesheet" href="$name.css">' : ''}
  <script defer src="$name.dart.js"></script>
</head>
<body>
$snippetContent

<h3>Source</h3>
<pre style='background: lightgray; display: inline-block; padding: 15px;'>
$source
</pre>
</body>
</html>
''';
}

class _WebRootBuilder implements Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    var examples = await buildStep
        .findAssets(Glob('example/**/*.dart'))
        .map((asset) =>
            p.joinAll(asset.changeExtension('.html').pathSegments.skip(1)))
        .toList();

    var exampleLinks = examples.map((p) {
      return '<p><a href="$p">$p</a></p>';
    }).join('\n');

    await buildStep.writeAsString(
        AssetId(buildStep.inputId.package, 'example/index.html'), '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body>
$exampleLinks
</body>
</html>
''');
  }

  @override
  final buildExtensions = const {
    r'test/$test$': ['example/index.html']
  };
}
