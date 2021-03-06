'use strict'

var express = require('express');
var bodyParser = require('body-parser');

// Notificaciones de eventos
var notifier = require('./controllers/notifications');

var app = express();

//crgar archivos de Rutas
var user_routes = require('./routes/routes');

//middlewares
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

//CORS
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});

// Ruta de eventos
app.get('/events', notifier.eventsHandler);

//Rutas
app.use('/api', user_routes);

//export
module.exports = app;