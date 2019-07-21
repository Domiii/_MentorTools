const fs = require('fs');
const path = require('path');

const process = require('process')
//console.log("NODE_PATH="+process.env['NODE_PATH']);

// setup our VM (seems quite safe; see: https://www.npmjs.com/package/vm2)
const vm2Path = 'vm2';
const { VM } = require(vm2Path);
const vmExports = {};
const vm = new VM({
  // run at most for 5 seconds
  timeout: 5000,

  // pass in our own exports object
  sandbox: {
    exports: vmExports,
    module: { exports: vmExports },
    require(file) {
      // if (file.endsWith('.js')) {
      //   file = file.substring(0, file.length - 3);
      // }
      // file += '.safe.js';
      absFile = path.resolve(__dirname, file);
      if (!absFile.match(`^${__dirname}.*\.js$`)) {
        throw new Error('Tried to require non-local file: ' + file);
      }
      return require(absFile);
    }
  }
});

// get code from "original" file
const origFile = path.basename(__filename);
//const fname = __dirname + '/_sandbox/' + origFile.substring(0, origFile.length - 3) + '.es5.js';
const fname = __dirname + '/_sandbox/' + origFile + '.es5.js';
let code = fs.readFileSync(fname, 'utf8');
code = `${code}`;

// run the code!
vm.run(code);

// export the vmExports
Object.assign(exports, vmExports);

//console.log(exports.twoFer(123));