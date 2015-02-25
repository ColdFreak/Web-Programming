var async = require('async');
async.waterfall([
  function(callback) {
    console.log('1');
    setTimeout(function() {
      console.log('1 done');
      callback(null, 1);
    }, 3000);
  },
  function(arg1, callback) { // arg1 === 1
    console.log('2');
    setTimeout(function() {
      console.log('2 done');
      callback(null, arg1, 2);
    }, 50);
  },
  function(arg1, arg2, callback) { // arg1 === 1, arg2 === 2
    console.log('3');
    setTimeout(function() {
      console.log('3 done');
      callback(null, arg1, arg2, 3);
    }, 10);
  }
], function(err, arg1, arg2, arg3) { // arg1 === 1, arg2 === 2, arg3 === 3
  if (err) {
    throw err;
  }
  console.log('all done.');
  console.log(arg1, arg2, arg3);
});
