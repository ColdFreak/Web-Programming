$(function() {
    var socket = new Phoenix.Socket("ws://" + location.host + "/ws");
    socket.join("rooms", "lobby", {}, function(chan) {
    });
});
