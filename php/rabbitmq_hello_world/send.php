<?php
require_once './vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPConnection;
use PhpAmqpLib\Message\AMQPMessage;

// RabbitMQサーバーに接続するためにコネクションを張る
// このコネクションはsocketコネクションを抽象化したもので
$connection = new AMQPConnection('localhost', 5672, 'guest', 'guest');

// チャンネルを作成する、大多数のAPIはチャンネルの中に仕事をしている
$channel = $connection->channel();

// メッセージを送りたい場合はqueueを宣言しないといけない
$channel->queue_declare('hello', false, false, false, false);

// $msgはバイト配列
$msg = new AMQPMessage('Hello World!');
$channel->basic_publish($msg, '', 'hello');

echo " [x] Sent 'Hello World!'\n";
// 最後にチャンネルをクローズする
$channel->close();
$connection->close();
?>
