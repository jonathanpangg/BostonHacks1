var express = require('express')
var app = express()
var mongodb = require('mongodb').MongoClient
var assert = require('assert')
var db = require('mongoose')  
const mongodb_URI = process.env.mongodb_URI || 'mongodb+srv://pangj130:Jonathan3388@cluster0.zw1as.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
app.use(express.json())

app.get('/tests', (req, res) => {
    mongodb.connect(mongodb_URI, function(error, db) {
        if (error) throw error
        var dbo = db.db('BostonHacks')
        var query = { username: req.params.username, password: req.params.password }
        dbo.collection('SleepData').find(query).toArray(function(error, result) { 
            if (error) throw error
            res.send(result)
            console.log(result)
            db.close()
        })
    })
})

app.post('/sleep/:id/:timeStart', (req, res) => {
    const data = {
        id: req.body.id,
        timeStart: req.body.timeStart
    }

    mongodb.connect(mongodb_URI, function (error, db) {
        if (error) throw error;
        var dbo = db.db('BostonHacks')
        dbo.collection('SleepData').insertOne(data, function(error, result) {
            if (error) throw error;
            assert.equal(null, error)
            console.log('Item inserted')
            db.close();
        })
    })
})

const port = process.env.PORT || 2000
app.listen(port, () => console.log('Listening on ' + port + '...'))