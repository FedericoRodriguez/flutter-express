Mongo
Go to: Tour path where mongo server is ...MongoDb\Server\4.4\bin and open two terminals

Execute mongod.exe to start the server

Execute in the other mongo.exe to start the client version (Testing, Database manipulation)

/////show dbs
/////show collections
/////use myDB
/////db.users.find()
//db.users.drop()

//update a value
/////use myDB

// criteria={email:"fede@gmail.com"}
//db.users.find(criteria)
// update={email:"fede@gmail.com",password:"fede",score:"0",isAdmin:true}
//db.users.update(criteria,update)
//validate
//db.users.find(criteria)

Express

On other terminal execute:

npm install

npm run start
