var fs = require('fs');

fs.readFile('art.erl', 'utf8', function(err, data) {
    if(err) {
        return console.log(err);
    }
    console.log(data);
});
