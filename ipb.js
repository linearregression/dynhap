#!/usr/bin/env node

'use strict';

var http = require('http');

const LISTEN_PORT = process.env.IPB_LISTEN_PORT || 8099;
const LISTEN_ADDRESS = process.env.IPB_LISTEN_ADDRESS || '0.0.0.0';

function handleRequest(request, response){
    let ipa = request.connection.remoteAddress;
    response.end(ipa);
    console.log('Request from ', ipa);
}

var server = http.createServer(handleRequest);

server.listen(LISTEN_PORT, LISTEN_ADDRESS, function(){
    console.log("Server listening on port %s:%s", LISTEN_ADDRESS, LISTEN_PORT);
});
