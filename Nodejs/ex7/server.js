// ejsファイルを使ってページを表示させる
// やり方としてはまずテンプレートのejsファイルを作成
// jsファイルからそれをテンプレートとして指定する．(fs.readFileSync()を使用)
// ejsテンプレートの変数確定した後,実際にdata変数の中にぶっ込む
var http = require('http'),
	fs = require('fs'),
	ejs = require('ejs');

// あらかじめ用意したhtmlファイルの読み込むために
// fsモジュールを使用する
var settings = require('./settings');

// サーバーを作ってあげる
server = http.createServer();

// fs.readFileSync()関数はブロッキング関数で，ファイルの読み込み完了まで
// 次の処理が行かない
// template は具体的なejsファイルのことをさしてい
var template = fs.readFileSync(__dirname + '/public_html/hello.ejs', 'utf-8');
var n = 0;
server.on('request', function(req, res) {
	n++;
	var data = ejs.render(template, {
		title: "hello",
		content: "<strong>World!</strong>",
		n: n
	});
	res.writeHead(200, {'Content-Type': 'text/html'});
	res.write(data);
	res.end();
	});

server.listen(settings.port, settings.host);
console.log("server listening...");
