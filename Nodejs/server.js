// Node.jsが用意しているhttpモジュール
// を読み込んでおく
var http = require('http');
// サーバーを作ってあげる
var server = http.createServer();

// server.listen()に使われているport とaddressは
// 外部ファイルのに移行して，requireを使って，
// 設定ファイルを読み込む形で使う
// settingsファイルの中にはexportsを使って
// 設定している
var settings = require('./settings');
console.log(settings);

// サーバーに対して，「リクエストを飛んで来たら
// ．．．をしなさいというイベントを結びつける
// イベントを結びつけるにはonという命令を使う
// コールバック関数の引数にはreq(リクエスト)
// とres(レスポンス)オブジェクトを取るようにする
server.on('request', function(req, res) {
	//httpのステータスコード２００を書いて，
	//コンテンツのタイプをtext/plainとして普通のテキスト
	//を返すようにする
	res.writeHead(200, {'Content-Type': 'text/plain'});
	res.write('hello world');
	// resは必ず最後に「res.end();」として終了させる
	res.end();
});

server.listen(settings.port, settings.host);
console.log("server listening...");
