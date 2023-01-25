#!/bin/sh
dart compile js -O1 --no-frequency-based-minification --server-mode -o ./test.dart.js ./main_test.dart
node ./test.dart.js