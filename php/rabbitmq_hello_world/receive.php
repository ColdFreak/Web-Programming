<?php
require_once './vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPConnection;
$connection = new AMQPConnection('localhost', 5672, 'guest', 'guest');
$channel = $connection->channel();

// ここまではsend.phpと一緒で、
// コネクションを張って、チャンネルを作って、キューを宣言する
$channel->queue_declare('hello', false, false, false, false);

echo ' [*] Waiting for messages. To exit press CTRL+C', "\n";

$callback = function($msg) {
      echo " [x] Received ", $msg->body, "\n";
};

$channel->basic_consume('hello', '', false, true, false, false, $callback);

while(count($channel->callbacks)) {
        $channel->wait();
}

?>
