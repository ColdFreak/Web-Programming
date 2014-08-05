// processはグローバルオブジェクトで、どこからでアクセスできる
//  EventEmitter
process.argv.forEach(function(val, index, array) {
    console.log(index + ': ' + val);
});

//使用例
//$ node process_argv.js one two=three four
//0: node
//1: /home/vagrant/Web-Programming/Nodejs/ex5/process_argv.js
//2: one
//3: two=three
//4: four


