// Node.jsが用意しているhttpモジュール
// を読み込んでおく
var http = require('http');
// サーバーを作ってあげる
var server = http.createServer();

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

server.listen(1337, '192.168.100.100');
console.log("server listening...");
