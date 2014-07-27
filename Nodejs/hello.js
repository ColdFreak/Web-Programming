// $ node hello.jsコマンドをうって
// コンソールに出力
//console.log("hello world");


// non blocking
// $ node hello.js
// setTimeoutの中の関数はコールバック関数で
// １秒経過するすると，実行される
// setTimeoutが終わるのを待たずに
// 次のconsole.logが実行される．
//
//setTimeout(function() {
//	console.log("hello");
//}, 1000);
//console.log("world");


// blocking
// $ node hello.js
// while文が終わるまで次の命令をブロックしている
// のが分かる
// メインのスレッドは一つなので，すべてのリクエストを
// ブロックしてしまうことになる
var start = new Date().getTime();
while ( new Date().getTime() < start + 1000 ) 
	;
console.log("world");
