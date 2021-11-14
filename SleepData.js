const mongoose = require('mongoose')
const Schema = mongoose.Schema

const data = new Schema ({
    id: {
        type: String,
        require: true 
    },
    timeStart: {
        type: String,
        require: true
    }
})

const SleepData = mongoose.model('SleepData', data)
module.exports = TimeData