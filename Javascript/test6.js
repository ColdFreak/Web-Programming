var fs = require('fs');

callback = function(err, data) {
    if(err) {
        return console.log(err);
    }
    console.log(data);
}
fs.readFile('test.js', 'utf8', callback );
