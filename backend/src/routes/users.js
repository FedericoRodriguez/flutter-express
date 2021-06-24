const { Router } = require('express')
const router = Router()
const mongoose = require('mongoose')
const User = require('../models/User')

const faker = require('faker')

router.get('/api/users', (req, res) => {
  console.log('Email:-->', req.query.email)
  if (req.query.email) {
    User.findOne({ email: req.query.email }, function (err, user) {
      if (err) {
        throw err
      }
      console.log('User Data', user)
      let userData = ''
      if (user) {
        userData = { status: '200', data: user, message: 'Success Get User' }
      } else {
        userData = { status: '500', data: user, message: 'User not Found' }
      }

      res.json(userData)
    })
  } else {
    User.find({}, function (err, users) {
      if (err) {
        throw err
      }
      const userData = { users: users }
      res.json(userData)
    })
  }
})

router.get('/api/users/fake_create', async (req, res) => {
  try {
    for (let i = 0; i < 5; i++) {
      const user = new User({
        _id: new mongoose.Types.ObjectId(),
        email: faker.internet.email(),
        password: faker.internet.password(),
      })
      await user
        .save()
        .then((result) => {
          res.json({ status: '200', message: 'Users created' })
        })
        .catch((err) => {
          res.json({ status: '401', message: 'Users created' })
          console.log('--Show me the error: ', err)
        })
    }
  } catch (e) {
    console.log('Show me the error: ', e)
  }
})

router.post('/api/users/create', async (req, res) => {
  try {
    const user = new User({
      _id: new mongoose.Types.ObjectId(),
      email: req.body.email,
      password: req.body.password,
    })
    await user
      .save()
      .then((result) => {
        res.json({ status: '200', message: 'Users created' })
      })
      .catch((err) => {
        res.json({ status: '500', message: 'Users created Fail' })
        console.log('--Show me the error: ', err)
      })
  } catch (e) {
    console.log('Show me the error: ', e)
  }
})

router.delete('/api/users/delete', async (req, res) => {
  try {
    await User.remove({
      email: req.body.email,
    })
      .then((result) => {
        console.log('Reponse Delete object:', result)
        res.json({
          status: '200',
          message: 'Users ' + req.body.email + ' deleted',
        })
      })
      .catch((err) => {
        res.json({ status: '500', message: 'Users deleted Fail' })
        console.log('--Show me the error: ', err)
      })
  } catch (e) {
    console.log('Show me the error: ', e)
  }
})

router.post('/api/users/login', async (req, res) => {
  try {
    const _email = req.body.email
    const _password = req.body.password
    await User.findOne({ email: _email }, function (err, user) {
      if (err) {
        throw err
      }
      console.log('Login:', user)

      let userData = ''
      if (user) {
        if (_password == user.password) {
          userData = { status: '200', data: user, message: 'Success Get User' }
        } else {
          userData = {
            status: '401',
            message: 'Invalid Credentials',
          }
        }
      } else {
        userData = { status: '500', message: 'User not Found' }
      }

      res.json(userData)
    })
  } catch (e) {
    console.log('Show me the error: ', e)
  }
})

module.exports = router
