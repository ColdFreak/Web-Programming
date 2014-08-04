var http = require('http');
var server = http.createServer(function(request, response) {});

server.listen(1234, function() {
    console.log((new Date()) + ' Server is listening on port 1234');
});

// We create the Web Socket Server on the back of the HTTP server
// that we established. 
var WebSocketServer = require('websocket').server;
// We now have a web socket server that is running, and 
// available for us to start adding some event listeners
wsServer = new WebSocketServer({
    httpServer: server
});


wsServer.on('request', function(r) {
    // we need to create an object that will have the clients
    
    var connection = r.accept('echo-protocol', r.origin);    
    var count = 0;    
    // in as well as an incementing number to identify each client
    var clients = {};
    // Specific id for the client & increment count
    var id = count++;
    // Store the connection method so we can loop through & contact all clients
    clients[id] = connection;
    console.log((new Date()) + ' Connection accepted [' + id + ']');
    // Create event listener
    connection.on('message', function(message) {
	


});


















    // The string message that was sent to us
    var msgString = message.utf8Data;

    // Loop through all clients
    for(var i in clients){
        // Send a message to the client with the message
        clients[i].sendUTF(msgString);
    }

});

connection.on('close', function(reasonCode, description) {
    delete clients[id];
    console.log((new Date()) + ' Peer ' + connection.remoteAddress + ' disconnected.');
});

var ws = new WebSocket('ws://some-address-here.com:1234', 'echo-protocol');

function sendMessage(){
    var message = document.getElementById('message').value;
    ws.send(message);
}

// event listener, take the message that's passed to use
// and append it to the div 
ws.addEventListener("message", function(e) {
    // The data is simply the message that we're sending back
    var msg = e.data;

    // Append the message
    document.getElementById('chatlog').innerHTML += '<br>' + msg;
});