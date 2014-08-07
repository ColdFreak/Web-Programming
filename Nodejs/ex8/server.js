var http = require('http'),
	fs   = require('fs'),
	ejs	 = require('ejs'),
	// フォームからの投稿を処理するにあたっては
	// querystringというモジュールが必要になる
	// それを読み込んでおく
	qs	 = require('querystring');

var settings = require('./settings');

var server = http.createServer();
// 表示する骨組みはテンプレートのこと，
// 読み込む必要がある
var template = fs.readFileSync(__dirname + '/public_html/bbs.ejs', 'utf-8');
// postsは投稿を保持する配列
var posts = [];
function renderForm(posts, res) {
	var data = ejs.render(template, {
		posts: posts
	});
	res.writeHead(200, {'Content-Type': 'text/html'});
	res.write(data);
	res.end();
}
server.on('request', function(req,res) {
	//req.methodがPOSTかどうか判断できるので
	if (req.method=== 'POST') {
		req.data = "";
		req.on("readable", function() {
			req.data += req.read();
		});
		req.on("end", function(){
			// フォームからのデータを受信終わった後に
			// queryのデータを扱っていきたいので
			// querystringを使っていく
			// parseで受信したデータが扱いやすくなる
			var query = qs.parse(req.data);
			// 入って来たのは名前部分なので，名前をpostsの配列に
			// 入れていく
			// これでフォームの中のnameと名前つけられたデータが
			// postsの配列に入ってくるはず
			posts.push(query.name);
			renderForm(posts, res);
		});
	} else {
		renderForm(posts, res);
	}
});

server.listen(settings.port, settings.host);
console.log("server listening...");
