var http = require('http');
// サーバーを作ってあげる
var server = http.createServer();

// あらかじめ用意したhtmlファイルの読み込むために
// fsモジュールを使用する
fs = require('fs');

// server.listen()に使われているport とaddressは
// 外部ファイルのに移行して，requireを使って，
var settings = require('./settings');
console.log(settings);

// サーバーに対して，「リクエストを飛んで来たら
// ．．．をしなさいというイベントを結びつける
// イベントを結びつけるにはonという命令を使う
// コールバック関数の引数にはreq(リクエスト)
// とres(レスポンス)オブジェクトを取るようにする
server.on('request', function(req, res) {

	// ファイルの読み込むにはfs.readFile()という命令を使う
	// ファイル名を指定するが，'__dirname'で今のディレクトリ名
	// がとれるので，それに'/public_html/hello.html'を付け加えて，あげればよい
	// 文字コードもutf-8を指定する
	// ファイルを読み込むのは時間がかかる処理なので，コールバック関数を指定
	// してあげる

	fs.readFile(__dirname + '/public_html/hello.html', 'utf-8', function(err, data) {
		// まずエラー処理を書く
		if( err ) {
			// text/htmlファイルを指定している
			// エラーが起きたら，404を返したい
			res.writeHead(404, {'Content-Type': 'text/html'});
			res.write("not found");
			// return すると次に処理が行かない
			return res.end();
		}
		res.writeHead(200, {'Content-Type': 'text/html'});
		res.write(data);
		res.end();
	});
});

server.listen(settings.port, settings.host);
console.log("server listening...");
