// Express (npm install express)
const express = require('express');
const router = express.Router();

// atob (npm install atob); used for parsing the Authorization header
const atob = require('atob');

// basic path that will return the authorizatin parsed into JSON
router.get('/', async (req, res) => {
    let auth = req.get('authorization')
    // Keycloak's structure is period delimiated, with the first part being metadata, and the second part being the content
    let jwt = JSON.parse(atob(auth.split('.')[1]))
    res.status(200).send(jwt)
})

// CHECKMATE'S solution was to have the Express backend authorize users, and the React frontend saves that response into
// a LoginContext.Provider

module.exports = router