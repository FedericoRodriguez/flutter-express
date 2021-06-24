const mongoose = require('mongoose')
const keys = require('./keys')

async function connect() {
  await mongoose
    .connect('mongodb://localhost/flutter-app', {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    })
    .then((db) => console.log('DB Connected ---', db))
    .catch((err) => console.log(err))
}

module.exports = { connect }
