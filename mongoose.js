var mongoose = require('mongoose')
const mongodb_URI = process.env.mongodb_URI || 'mongodb+srv://pangj130:Jonathan3388@cluster0.zw1as.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
mongoose.connect(mongodb_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useCreateIndex: true
})

const db = mongoose.connection

db.on('error', () => {
  console.log('mongodb error!')
})

db.on('open', () => {
  console.log('mongodb connected!')
})

module.exports = db