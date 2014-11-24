<?php
set_time_limit(0);
$ip = "127.0.0.1";
$port = 123;

if( !$socket = socket_create(AF_INET, SOCK_STREAM, 0)) {
    showError();
}

echo "The socket's protocol info was set\n";

// SO_REUSEADDRオプションはローカルアドレスが再利用可能するかどうか
if( ! socket_set_option($socket, SOL_SOCKET, SO_REUSEADDR, 1)) {
    showError($socket);
}
// bin the socket
if( !socket_bind($socket, $ip, $port)) {
    showError($socket);
}

echo "The socket has been bound to a specific port now!\n";

// start listening on this port 
if( !socket_listen($socket) ) {
    showError($socket);
}

echo "Now listening for connections...\n";

do {
    $client = socket_accept($socket);
    echo "new connection with client established !!\n";

    // welcome the user
    $message = "\n Hey! Welcome to another exciting talk!\n\n";

    // ソケットへの書き込みに成功したデータのバイト数を返す
    // 失敗した場合にFALSEを返す
    // エラーコードはsocket_last_error()を用いて取得する
    // この値をsocket_strerror()に渡すことでエラー情報を文字列
    // で取得
    socket_write($client, $message, strlen($message));

    // check for any message sent by the user
    do {

        if( !$clientMsg = socket_read($client, 2048, PHP_NORMAL_READ)) {
            showError($socket);
        }

        $messageForUser = "Thanks for you input, Will think about it .";
        socket_write($client, $messageForUser, strlen($messageForUser));

        // クライアントの入力したメッセージは空の場合もう一回listen
        if( !$clientMsg = trim($clientMsg)) {
            continue;
        }

        // クライアントが'close'を打ち込んで，クライアントソケットを閉じる
        if( $clientMsg === 'close' ) {
            socket_close($client);
            echo "\n\n-------------\n" .
                "The user has left the connection\n";
            // breakではオプションの引数でネストしたループ構造を
            // 抜ける数を指定することができるため，２を指定して
            // 二つのdo...whileループから抜ける
            break 2;
        }
    }while(true);
}while(true);
// end the socket
echo "Ending the socket \n";
socket_close($socket);

function showError( $theSocket = null) {
    $errorcode = socket_last_error($theSocket);
    $errormsg = socket_strerror($errorcode);
    die( "Couldn't create socket: [$errorcode] $errormsg");
}
?>
