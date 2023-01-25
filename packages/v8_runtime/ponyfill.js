const fs = require('fs');
const vm = require('vm');
const ponyfill = require('@edge-runtime/ponyfill');
const testFile = process.argv.at(2);
const file = fs.readFileSync(testFile, 'utf8');

vm.runInContext(file, vm.createContext({
  window: ponyfill,
  require: require,
  exports: exports,
  process: process,
  ...ponyfill,
}));