const app = require('./app')
const { connect } = require('./database')

require('./app')

async function main() {
  //DB connection
  await connect()
  //Express app
  await app.listen(4000)
  console.log('Server on port 4000: Connected')
}

main()
